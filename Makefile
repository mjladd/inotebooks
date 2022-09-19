PYTHON := $(shell which python3)
ENV := $(CURDIR)/env
PIP := $(ENV)/bin/pip3
PRINTF := $(shell which printf)

#> deps: build deps to setup virtualenv
deps: $(ENV)
	$(PIP) install --upgrade -r requirements.txt

$(ENV):
	$(PYTHON) -m venv env
	$(PIP) install -U pip setuptools
	$(PIP) --upgrade -r requirements.txt
.PHONY: deps

#> build: build the docker container
build:
	docker build . -t mjladd/ml
.PHONY: build

#> clean: clean up the virtualenv
clean:
	rm -rf $(ENV)
.PHONY: clean

#> notebook: run jupyter as a containerized notebook
notebook:
	docker run -d -p 8888:8888 -v $(PWD)/notebooks:/notebooks mjladd/ml
.PHONY: clean

.DEFAULT_GOAL = help

help:
	@echo ""
	@echo " "
	@echo "🤖 I can help!"
	@echo " "
	@echo "Please use 'make <target> [<target>]...' where <target> is one of"
	@echo " "
	@sed -n 's/^#>/ /p' $(MAKEFILE_LIST)
	@echo " "
.PHONY: help