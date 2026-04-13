"""
All functions to download data
"""


def download_version(
    version: str,
) -> str:
    """
    Download given version.

    The config is read from the versions dict defined in versions.py

    Parameters
    ----------
    version:
        The version to download. It has to be defined in versions.py

    Returns
    -------
        None

    """
    print(f"test {version}")

    return version
