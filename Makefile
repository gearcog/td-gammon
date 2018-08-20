#
# Basic targets for interacting with the td-gammon model.
#
SHELL := /bin/bash

.PHONY: create-venv build-model clean

.ONESHELL:
create-venv:
	@# create the virtualenv
	[ -r venv/ok ] && {
		echo "(virtualenv already exists)"
		exit 0
	}
	virtualenv venv || {
		echo "Failed to created virtualenv" 1>&2
		exit 1
	}
	source venv/bin/activate || {
		echo "Failed to activate virtualenv" 1>&2
		exit 1
	}
	pip install -r requirements.txt || {
		echo "Failed to install requirements" 1>&2
		exit 1
	}
	echo "ok" >> venv/ok || {
		echo "Failed to create virtualenv ok file." 1>&2
		exit 1
	}
	exit 0

.ONESHELL:
build-model: create-venv
	@# build the model
	echo "Building model (this takes awhile)"
	source venv/bin/activate || {
		echo "Failed to activate venv" 1>&2
		exit 1
	}
	python main.py

clean:
	@# clean up after ourselves
	@rm -rf venv logs summaries models *.pyc
