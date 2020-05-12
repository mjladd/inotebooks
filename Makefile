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
	@echo "  notebook      run docker container with jupyter notebook"
	@echo " "

default: help

build:
	docker build . -t mjladd/ml

deps: $(ENV)
	$(PIP) install --upgrade -r requirements.txt

$(ENV):
	virtualenv --python=$(PYTHON) $(ENV)
	$(PIP) install -U pip setuptools

clean:
	rm -rf $(ENV)


notebook:
	docker run -d -p 8888:8888 -v $(PWD)/notebooks:/notebooks mjladd/ml


.PHONY: clean deps build
