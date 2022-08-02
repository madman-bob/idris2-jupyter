#!/bin/bash

pack install-app json-schema
pack install-app idris2-python
pack install-deps idris2-jupyter.ipkg

idris2-python --build idris2-jupyter.ipkg

export PYTHONPATH="build/exec:$(pack libs-path)"
jupyter kernelspec install --user Idris2Jupyter/
