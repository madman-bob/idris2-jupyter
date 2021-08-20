.PHONY: idris2-jupyter install clean uninstall

idris2-python = cd ../idris2-python && ./build/exec/idris2-python

idris2-jupyter: build/exec/idris2-jupyter

build/exec/idris2-jupyter: idris2-jupyter.ipkg Idris2Jupyter/* Idris2Jupyter/*/*
	$(idris2-python) --build ../idris2-jupyter/idris2-jupyter.ipkg

install: idris2-jupyter
	jupyter kernelspec install --user Idris2Jupyter/

clean:
	rm -rf build

uninstall:
	jupyter kernelspec uninstall idris2jupyter
