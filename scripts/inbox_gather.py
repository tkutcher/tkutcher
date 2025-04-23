#!/usr/bin/python3

import os
import pathlib
import logging
import re
import shutil
import subprocess
from datetime import datetime

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

LOG_TRUNCATE_SRC_SIZE = 18

GDRIVE_DIR_ENV_VAR = "TK_GDRIVE_DIR"
TURBOSCAN_DIR_ENV_VAR = "TK_TURBOSCAN_DIR"
SHORTCUT_SYNC_NAME = "Move Reminders to Obsidian Inbox File"

GDRIVE_INBOX_RELPATH = pathlib.Path("hq/_inbox")

IGNORE_FILES = [
    ".DS_Store",
    "__inbox__.md"
]


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
        .replace("__", "_") # handle double underscore
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


def _move_files_from_other_dir(dropoff_dir: pathlib.Path, inbox_dir: pathlib.Path):
    for f in dropoff_dir.glob("*"):
        if f.name in IGNORE_FILES:
            continue
        normalized = _normalize_file_name(f)
        logger.info(f"Gathered {f.name} -> {normalized}")
        shutil.move(f, inbox_dir / normalized)


def _normalize_inbox_file_names(inbox_dir: pathlib.Path):
    for f in inbox_dir.glob("*"):
        x = f.name
        y = IGNORE_FILES
        if f.name in IGNORE_FILES:
            continue
        new_path = inbox_dir / _normalize_file_name(f)
        f.rename(new_path)

def main(sync_reminders=True):
    gdrive_path = _get_local_path(GDRIVE_DIR_ENV_VAR)
    turboscan_path = _get_local_path(TURBOSCAN_DIR_ENV_VAR)
    inbox_dir = gdrive_path / GDRIVE_INBOX_RELPATH

    logger.info("Starting inbox gathering process")
    logger.info(f"Gathering files from {turboscan_path}")
    _move_files_from_other_dir(turboscan_path, inbox_dir)
    logger.info("Normalizing file names")
    _normalize_inbox_file_names(inbox_dir)
    if sync_reminders:
        logger.info("Syncing reminders via shortcut")
        subprocess.run(["shortcuts", "run", SHORTCUT_SYNC_NAME])
    logger.info("Done!")


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    ns = parser.parse_args()
    main()
