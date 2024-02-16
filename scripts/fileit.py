import os
import pathlib
import logging
import re
import shutil
from datetime import datetime

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

LOG_TRUNCATE_SRC_SIZE = 18

GDRIVE_DIR_ENV_VAR = "TK_GDRIVE_DIR"
TURBOSCAN_DIR_ENV_VAR = "TK_TURBOSCAN_DIR"

GDRIVE_TO_FILE_RELPATH = pathlib.Path("records/_to-file")

GENERAL_RECORDS_RELPATH = pathlib.Path("records/general")
KEEPSAKES_RECORDS_RELPATH = pathlib.Path("records/keepsakes")

IGNORE_FILES = [
    ".DS_Store",
]


DIR_KEY_MAP = {
    "$keepsakes$": KEEPSAKES_RECORDS_RELPATH,
    "$keepsake$": KEEPSAKES_RECORDS_RELPATH,
}


def _get_local_path(env_var) -> pathlib.Path:
    try:
        return pathlib.Path(os.environ[env_var])
    except (KeyError, EnvironmentError):
        logger.error(f"Missing {env_var} environment variable!")
        exit(1)



def _clean_file_name(orig: str) -> str:
    return (
        re.sub(r"\s+", " ", orig)  # condense whitespace
        .strip()  # strip trailing space
        .replace(" - ", "-")  # replace space-dash-space
        .replace(" ", "-")  # replace space with hyphen
        .replace("__", "_") # handle double underscore
        .lower()  # lower-case-ify
    )

def _get_created_when_str(p: pathlib.Path) -> str:
    created_when_timestamp = p.stat().st_birthtime
    created_when = datetime.fromtimestamp(created_when_timestamp)
    return created_when.strftime("%Y-%m-%d")


def _get_target_path(p: pathlib.Path) -> pathlib.Path:
    filename = p.name

    target_dir = GENERAL_RECORDS_RELPATH

    for k in DIR_KEY_MAP:
        if filename.startswith(k):
            filename = filename.lstrip(k).lstrip("_")
            target_dir = DIR_KEY_MAP[k]
            break

    created_when_str = _get_created_when_str(p)
    clean_file_name = _clean_file_name(filename)
    target_name = f"{created_when_str}_{clean_file_name}"

    return target_dir / target_name


def main(dry_run: bool = False):
    gdrive_path = _get_local_path(GDRIVE_DIR_ENV_VAR)
    turboscan_path = _get_local_path(TURBOSCAN_DIR_ENV_VAR)

    dropoff_dirs = [
        gdrive_path / GDRIVE_TO_FILE_RELPATH,
        turboscan_path,
    ]

    for dropoff_dir in dropoff_dirs:
        for f in dropoff_dir.glob("*"):
            if f.name in IGNORE_FILES:
                continue
            target = _get_target_path(f)
            if not dry_run:
                shutil.move(f, gdrive_path / target)
            truncated_src = f.name[:LOG_TRUNCATE_SRC_SIZE]
            truncated_src += "..." if len(f.name) > LOG_TRUNCATE_SRC_SIZE else ""
            logger.info(f"DONE {repr(truncated_src)} --> {target}")


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Do not actually move any files, just perform a dry run",
    )

    ns = parser.parse_args()
    main(dry_run=ns.dry_run)
