#!/bin/bash

pack install-app json-schema
pack install-app idris2-python
pack install-deps dummy.ipkg

idris2-python --build ../idris2-jupyter.ipkg

jupyter kernelspec install --user ../Idris2Jupyter/

export PYTHONPATH="../build/exec:$(pack libs-path)"
jupyter notebook
