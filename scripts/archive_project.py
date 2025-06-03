#!/usr/bin/python3

import logging
import os
import pathlib
import shutil
import datetime

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

GDRIVE_DIR_ENV_VAR = "TK_GDRIVE_DIR"

GDRIVE_PROJECTS_RELPATH = pathlib.Path("hq/02-projects")
GDRIVE_ARCHIVED_PROJECTS_RELPATH = pathlib.Path("hq/05-res/archived-projects")


def _get_local_path(env_var) -> pathlib.Path:
    try:
        return pathlib.Path(os.environ[env_var])
    except (KeyError, EnvironmentError):
        logger.error(f"Missing {env_var} environment variable!")
        exit(1)


def _today_str() -> str:
    return datetime.date.today().isoformat()


def main(project_name: str):

    gdrive_path = _get_local_path(GDRIVE_DIR_ENV_VAR)
    projects_dir = gdrive_path / GDRIVE_PROJECTS_RELPATH
    archives_dir = gdrive_path / GDRIVE_ARCHIVED_PROJECTS_RELPATH

    path = projects_dir / project_name

    if not path.exists():
        logger.error(f"Project {project_name} not found!")
        exit(1)

    new_name = f"{_today_str()}--{project_name}"
    archive_path = archives_dir / new_name
    archive_path.mkdir()
    shutil.move(str(path), str(archive_path))


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("project_name")

    ns = parser.parse_args()
    main(project_name=ns.project_name)
