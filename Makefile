# Makefile to run repository maintenance and development steps.
# Data reading and processing is done via pydoit

# TODO help
default: help

.PHONY: help
help: # display this help message
	@grep -E '^[a-zA-Z0-9 _]+:.*#'  Makefile | sort | \
	while read -r l; do \
		printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; \
	done


# virtual environment make targets
.PHONY: virtual_environment
virtual_environment: # make virtual environment
	uv venv

update_virtual_environment: .venv # upgrade packages in the virtual environment but respect pinned versions in pyproject.toml
	uv lock --upgrade

sync_virtual_environment: .venv # sync virtual environment to lock file
	uv sync

# clean

# ruff make targets (add folders like scripts to ruff calls if necessary)
.PHONY: ruff
ruff: .venv # run ruff for formatting and fixes
	uv run ruff format src tests
	uv run ruff check src tests --fix
	uv run ruff format src tests

# pre-commit
install-pre-commit: sync_virtual_environment # Install the pre-commit hooks
	uv run pre-commit install

.PHONY: pre-commit
pre-commit: install-pre-commit # Run pre-commit hooks manually
	uv run pre-commit

# tests
test: .venv

# coverage

# docs (TODO if we use more than a readme file)

# changelog
