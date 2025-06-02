#!/usr/bin/python3

import logging
import os
import pathlib

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

LOG_TRUNCATE_SRC_SIZE = 18

GDRIVE_DIR_ENV_VAR = "TK_GDRIVE_DIR"

GDRIVE_PROJECTS_RELPATH = pathlib.Path("hq/02-projects")
PROJECT_TYPE_KEYS = {
    "personal": "personal",
    "p": "personal",
    "work": "work",
    "w": "work",
    "dicorp": "dicorp",
    "d": "dicorp",
    "anvilor": "anvilor",
    "a": "anvilor",
}


def _get_local_path(env_var) -> pathlib.Path:
    try:
        return pathlib.Path(os.environ[env_var])
    except (KeyError, EnvironmentError):
        logger.error(f"Missing {env_var} environment variable!")
        exit(1)


def _normalize_project_name(project_name: str) -> str:
    return project_name.replace(" ", "-")


def _normalize_project_type(project_type: str) -> str:
    return PROJECT_TYPE_KEYS[project_type]


def _render_project_page(project_name, project_type_tag) -> None:
    return f"""---
tags:
  - {project_type_tag}
---

**Next Actions:**
- [ ] TODO


"""


def main(project_name: str, project_type: str):

    gdrive_path = _get_local_path(GDRIVE_DIR_ENV_VAR)
    projects_dir = gdrive_path / GDRIVE_PROJECTS_RELPATH

    project_name = _normalize_project_name(project_name)
    project_type = _normalize_project_type(project_type)
    path = projects_dir / project_name / f"{project_name}.md"
    if path.exists():
        logger.error(f"Project {project_name} already exists!")
        return
    path.parent.mkdir(parents=True, exist_ok=True)
    contents = _render_project_page(
        project_name,
        project_type_tag={
            "personal": "personal",
            "work": "work",
            "anvilor": "work/anvilor",
            "dicorp": "work/dicorp",
        }[project_type],
    )
    with open(path, "w") as f:
        f.write(contents)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("project_name")
    parser.add_argument("-t", default="p")

    ns = parser.parse_args()
    main(
        project_name=ns.project_name,
        project_type=ns.t,
    )
