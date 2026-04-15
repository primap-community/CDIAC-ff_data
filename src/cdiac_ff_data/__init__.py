"""
Package to download read CDIAC data and store in primap2 data format
"""

# import tomllib
# from pathlib import Path
from .download import download_version

__all__ = [
    "download_version",
]


# # Read version from the pyproject.toml so we have to update it in only one place
# with open(Path(__file__).parent.parent / "pyproject.toml", "rb") as f:
#     __version__ = tomllib.load(f)["project"]["version"]
