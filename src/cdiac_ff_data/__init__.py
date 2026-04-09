"""
Package to download read CDIAC fossil fuel related emissions data and store in primap2
data format
"""

from .download import download_version

__all__ = [
    download_version,
]

__version__ = "0.1.0"