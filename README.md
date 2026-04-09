# CDIAC Global, Regional, and National Fossil-Fuel CO2 Emissions Dataset

This repository downloads the CDIAC fossil fuel related CO2 emissions dataset from figshare or zenodo depending on version.
The dataset is converted to the PRIMAP2 format and provided in both the csv-based interchange format and the netCDF-based native primap2 format. We aim to provide past current and future versions of the dataset within this repository.

## Description

This repository downloads the CDIAC fossil fuel related CO2 emissions dataset from figshare or zenodo depending on version. Information on the dataset is available on the [AppState](https://rieee.appstate.edu/projects-programs/cdiac/) website and in a paper publised in [ESSD](https://essd.copernicus.org/articles/13/1667/2021/).
The downloaded dataset can then be converted into CSV (.csv file extension) or NetCDF (.nc file extension) format. Converted data are available for the following versions:

TODO: earlier versions

- | v2025 |[Figshare](https://doi.org/10.6084/m9.figshare.31449082) |
- | v2020 |[zenodo](https://zenodo.org/records/4281271) |


The data management tool [DataLad](http://docs.datalad.org/en/stable/) is used to version control the data sets and store the data in the repository while keeping the large files out of github.
Commands to manage the data are executed via the [pydoit](https://pydoit.org/) package.

## DataLad datasets and how to use them

This repository is a [DataLad](https://www.datalad.org/) dataset. It provides  
fine-grained data access down to the level of individual files, and allows for  
tracking future updates. In order to use this repository for data retrieval,  
[DataLad](https://www.datalad.org/) is required. It is a free and open source  
command line tool, available for all major operating systems, and builds upon  
Git and [git-annex](https://git-annex.branchable.com/) to allow sharing,  
synchronizing, and version controlling collections of large files.

## Installation

Note that for [simply downloading the dataset,](#1-easy-access) uv is not required.

- Install datalad according to the [DataLad handbook](https://handbook.datalad.org/en/latest/intro/installation.html). We recommend installing datalad globally as managing it from within the venv is not something we do for you.
- Install [uv](https://www.python.org). uv manages the python version and all dependencies in the repository, thus no further individual installation steps are needed.

## Getting Started

### Clone the repository

A DataLad dataset can be `cloned` by running

```sh
datalad clone git@github.com:primap-community/CDIAC-ff_data.git
```
Do not use git clone to download the repository! If you use plain git clone, DataLad will not have the necessary
information to manage the dataset. Once the repository is cloned, it is like using a standard light-weight repository on your local machine.  
At this point, the repository contains only small metadata and information on the identity of the files in the dataset, but not the actual *content* of the (sometimes large) files. The large files are just present as broken symlinks.


<h3 id="1-easy-access"> Easy access </h3>
Users who simply want to retrieve the dataset have the option to access both the
original and extracted files with

```sh
dataland get <filename>
```

This command will trigger a download of the files, directories, or subdatasets you have specified.

TODO: make example with actual file
For example, the CSV file for the XXX release can be downloaded with

```sh
datalad get extracted_data/XXX/YYY.csv 
```

### Stay up-to-date

DataLad datasets can be updated. The command `datalad update` will *fetch*  
updates and store them on a different branch to the one you're currently working on (by default  
`remotes/origin/master`). Running

```  
datalad update --merge  
```  

will *fetch* available updates and integrate them in one go.

### Find out what has been done

DataLad datasets contain their history in the `git log`.  By running `git  
log` (or a tool that displays Git history) in the dataset or on specific  
files, you can find out what has been done to the dataset or to individual  
files by whom, and when.

## Contributing

For those who wish to contribute to the repository, below we go through the key commands you will need to use. While the actual data handling functionality is run using pydoit the repository management uses make so we can install pydoit in the virtual environment.

#### Set up the virtual environment with uv

```sh
make virtual_environment
```

#### <a name="download"></a>Download the version from the command line.

This will download all files from Zenodo as they are for a specific version (note this version must already be in `versions.py`, if you want to add a new version, see the section on adding a new version below).

```sh
doit download_version version=<XXX>
```

TODO: make real example
For example, the following command will download all files from XXX for the YYY release

```sh
doit download_version version=YYY
```

#### <a name="convert"></a> Read the version from the command line.

Reading data refers to the conversion of the downloaded files into CSV and NetCDF format. Similarly to the download
command, the data is read for a specific version with

```sh
doit read_version version=<YYY>
```
TODO: real example
For example, the following command will read the YYY release

```sh
doit read_version version=YYY
```

## <a name="newversion"></a> How to add a new version

To add a new version go to `src/cdiac_ff_data/config/versions.py` and create a new value in the
`versions` dictionary. Fill all the required information similar to the previous entries.
For example, the value for key `"20260303"` in the `versions` dictionary describes the 2026-03-03 release.

````python
versions = {
    "260303": {
        'date': '03-Mar-2026',
        'ver_str_long': 'version 20260303',
        'ver_str_short': '260303',
        "folder": "260303",
        'references': 'https://doi.org/10.6084/m9.figshare.31449082',
        'title': 'Global, Regional, and National Fossil-Fuel CO2 Emissions: 1750-2022 CDIAC-FF',
        'institution': "Research Institute for Environment, Energy, and Economics, Appalachian State University",
        'filter_keep': {},
        'filter_remove': {},
        'contact': "mail@johannes-guetschow.de",
        'comment': ("Published by M. Erb and G. Marland, converted to PRIMAP2 format by "
                    "Johannes Gütschow"),
    },
}
````

Then run the two commands, `download_version` and `read_version` as described in [Contributing](#contributing) for your newly added version.

## Help

Show all doit commands

```sh
doit help
```

See a list with possible doit commands specific to this repository

```sh
doit list
```

Get help on a specific command

```
doit help <command>
```

### Repository structure
TODO: adapt to final code structure, e.g. where are the datalad functions
- `.datalad/` contains config file for datalad
- `downloaded_data/` contains original data from Zenodo.
- `extracted_data/` contains data in .csv and .nc format
- `literature/` contains link to relevant publications. Can be downloaded with _datalad get_ command
- `src/cdiac_ff_data/`
    - `config/`
      - `version.py` contains a dictionary that contains configuration and metadata for each release. This file has to be updated when [adding a new version](#a-namenewversiona-how-to-add-a-new-version)
    - `download.py` functions to download files for a given version. 
    - `helper.py` helper functions if needed
    - `read_process.py` reads the data for a given version and saves to [PRIMAP2](https://primap2.readthedocs.io/en/stable/) native and interchange format.
- `tests\` contains subfolders with test functions
- `dodo.py` defines pydoit commands.
- `Makefile` to make virtual environment and run development tools 
- `LICENSE` contains the license information
- `pyproject.toml` configuration file
- `README.md` you're reding it
- `uv.lock` lock file for uv defining the package versions so a defined environment can be used by everyone

We omit the git files and folders here as they should be known to all possible contributors.

TODO: add info on ruff etc?

### Make sure to correctly set up the DataLad siblings

Git repositories can configure clones of a dataset as remotes in order to fetch, pull, or push from and to them. A `datalad sibling` is the equivalent of a git clone that is configured as a remote.

**Query information** about about all known siblings with

```sh
datalad siblings
```
TODO: adapt to final storage location

**Add a sibling** to allow pushing to github

```sh
datalad siblings add --dataset . --name <name> --url git@github.com:XXX
```

SSH-access is needed to run this command. Note that `name` can be freely chosen (we tend to just use "github" for GitHub siblings)

**Push to the github repository**

```
datalad push --to <name>
```

where `name` should match the name you used above
### Issues

There always issues open regarding coding, some of them easy to resolve, some harder.

### Your ideas

Contributing is ouf course not limited to the categories above. If you have ideas for improvements just open an issue or a discussion page to discuss your idea with the community.

### Technical HowTo for contributors
TODO adapt for final storage location. Account needed for contributing. Gin info can be removed. 
As we have a datalad repository using github and gin, the process of contributing code and data is a bit different from pure git repositories. As the data is only stored on gin, the gin repository is the source to start
from. As gin currently has a problem with forks (the annexed data is not
forked) we have to use branches for development and, thus, to contribute you
first need to contact the maintainers to get write access to the gin repository.
You have to clone the repository using ssh to be able to push to it.
For that you first need to store your public ssh key on the gin server
(settings -> SSH Keys).

### Instructions for merge requests

Once you have everything set up you can create a new branch branch and work there.
When you're done, create a pull request to integrate your work into the main
branch. This should be done first on github to allow for discussions and review (gin servers don't have the same review features). Afterwards the changes
can be actually merged on gin (so that the annex is merged properly too). 