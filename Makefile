ifndef sc
$(error sc environment variable is not defined)
endif

.PHONY: default install test venv venv-clean clean pull

WORKDIR?=.
PY?=python3
VENVDIR?=$(WORKDIR)/venv
VENV=$(VENVDIR)/bin

.EXPORT_ALL_VARIABLES:

default: install

install: venv
	$(VENV)/ansible-playbook site.yaml -v -e "sc=${sc}" --tags lokistack

uninstall: venv
	$(VENV)/ansible-playbook site.yaml -v -e "sc=${sc}" -e state=absent --tags "lokistack"

clean: venv-clean

# prepare the base python3 virtualenv
venv:
	$(PY) -m venv --prompt lokistack $(VENVDIR)
	$(VENV)/pip install --upgrade pip --quiet
	$(VENV)/pip install -Ur requirements.txt pip --quiet

venv-clean:
	rm -fr $(VENVDIR)
