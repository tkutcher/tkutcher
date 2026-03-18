#!/usr/bin/python3

import logging
import os
import pathlib
import re
import shutil
from datetime import datetime

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

LOG_TRUNCATE_SRC_SIZE = 18

TURBOSCAN_DIR_ENV_VAR = "TK_TURBOSCAN_DIR"
INBOX_DIR_ENV_VAR = "TK_INBOX_DIR"

IGNORE_FILES = [".DS_Store", "__inbox.md"]


def _get_local_path(env_var) -> pathlib.Path:
    try:
        return pathlib.Path(os.environ[env_var])
    except (KeyError, EnvironmentError):
        logger.error(f"Missing {env_var} environment variable!")
        exit(1)


def _is_normalized(p: pathlib.Path) -> bool:
    matches = bool(re.match(r"^\d{4}-\d{2}-\d{2}", p.name))
    return matches


def _clean_file_name(orig: str, lower=False) -> str:
    s = (
        re.sub(r"\s+", " ", orig)  # condense whitespace
        .strip()  # strip trailing space
        .replace(" - ", "-")  # replace space-dash-space
        .replace(" ", "-")  # replace space with hyphen
        .replace("__", "_")  # handle double underscore
    )
    return s.lower() if lower else s


def _get_created_when_str(p: pathlib.Path) -> str:
    created_when_timestamp = p.stat().st_birthtime
    created_when = datetime.fromtimestamp(created_when_timestamp)
    return created_when.strftime("%Y-%m-%d")


def _normalize_file_name(p: pathlib.Path) -> str:
    if _is_normalized(p):
        return p.name
    return f"{_get_created_when_str(p)}--{_clean_file_name(p.name)}"


def _move_files_from_dropoff_dir(title: str, dropoff_dir: pathlib.Path, inbox_dir: pathlib.Path):
    logger.info(f"Gathering files from {title}...")
    logger.info(f"dropoff_dir: {dropoff_dir}")
    num_files_gathered = 0
    for f in dropoff_dir.glob("*"):
        if f.name in IGNORE_FILES:
            continue
        num_files_gathered += 1
        normalized = _normalize_file_name(f)
        logger.info(f"{title} - Gathered {f.name} -> {normalized}")
        shutil.move(f, inbox_dir / normalized)
    logger.info(f"Done. Gathered {num_files_gathered} files from {title}.")


def main():
    turboscan_path = _get_local_path(TURBOSCAN_DIR_ENV_VAR)
    inbox_dir = _get_local_path(INBOX_DIR_ENV_VAR)

    logger.info("Starting inbox gathering process")

    _move_files_from_dropoff_dir("TurboScan", turboscan_path, inbox_dir)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    ns = parser.parse_args()
    main()
