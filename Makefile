PYTHON := $(shell which python3)
ENV := $(CURDIR)/env
WENV := $(CURDIR)/wenv
PIP := $(ENV)/bin/pip3
PRINTF := $(shell which printf)


help:
	@echo ""
	@echo " "
	@echo "Please use 'make <target> [<target>]...' where <target> is one of"
	@echo "  deps          initialize the ansible environment"
	@echo "  clean         remove the ansible environment"
	@echo "  lint          run lint checks against playbooks"
	@echo "  notebook      run docker container with jupyter notebook"
	@echo " "

default: help


deps: $(ENV)
	$(PIP) install --upgrade -r requirements.txt

wdeps: $(WENV)
	$(PIP) install --upgrade -r requirements.txt

$(ENV):
	virtualenv --python=$(PYTHON) $(ENV)
	$(PIP) install -U pip setuptools

$(WENV):
	virtualenv --python=python $(WENV)
	$(PIP) install -U pip setuptools


clean:
	rm -rf $(ENV)

wclean:
	rm -rf $(WENV)

notebook:
	docker run -d -p 8888:8888 -v $(PWD)/notebooks:/notebooks mladd/fastai:v1


env-info:
	./bin/env-info

.PHONY: clean deps env-info
