PYTHON := $(shell which python3)
ENV := $(CURDIR)/env
PIP := $(ENV)/bin/pip3
PRINTF := $(shell which printf)


help:
	@echo ""
	@echo " "
	@echo "Please use 'make <target> [<target>]...' where <target> is one of"
	@echo "  deps          initialize the ansible environment"
	@echo "  clean         remove the ansible environment"
	@echo "  lint          run lint checks against playbooks"
	@echo " "

default: help


deps: $(ENV)
	$(PIP) install --upgrade -r requirements.txt

$(ENV):
	virtualenv --python=$(PYTHON) $(ENV)
	$(PIP) install -U pip setuptools


clean:
	rm -rf $(ENV)


env-info:
	./bin/env-info

.PHONY: clean deps env-info
