.PHONY: jupyter-bindings idris2-jupyter install clean uninstall

idris2-python = cd ../idris2-python && ./build/exec/idris2-python

jupyter-bindings: build/ttc/Jupyter

build/ttc/Jupyter: jupyter-bindings.ipkg JupyterBindings/* JupyterBindings/*/*
	$(idris2-python) --install ../idris2-jupyter/jupyter-bindings.ipkg

idris2-jupyter: build/exec/idris2-jupyter

build/exec/idris2-jupyter: idris2-jupyter.ipkg jupyter-bindings Idris2Jupyter/*
	$(idris2-python) --build ../idris2-jupyter/idris2-jupyter.ipkg

install: idris2-jupyter
	jupyter kernelspec install --user Idris2Jupyter/

clean:
	rm -rf build

uninstall:
	jupyter kernelspec uninstall idris2jupyter
