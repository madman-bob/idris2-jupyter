.PHONY: jupyter-bindings idris2-jupyter add-plugin install clean uninstall

idris2-python = cd ../idris2-python && ./build/exec/idris2-python

jupyter-bindings: build/ttc/Jupyter

build/ttc/Jupyter: jupyter-bindings.ipkg JupyterBindings/* JupyterBindings/*/*
	$(idris2-python) --install ../idris2-jupyter/jupyter-bindings.ipkg

idris2-jupyter: build/exec/idris2-jupyter

build/exec/idris2-jupyter: idris2-jupyter.ipkg jupyter-bindings Idris2Jupyter/* Idris2Jupyter/*/*
	$(idris2-python) --build ../idris2-jupyter/idris2-jupyter.ipkg

define ensure_line
	grep -qxFs "$(2)" "$(1)" || echo "$(2)" >> "$(1)"
endef

add-plugin:
	$(call ensure_line,plugins.txt,$$module $$plugin $$packages)

define format_plugins
	sed -En "s/^([[:alnum:].]+) ([[:alnum:].]+)(( [[:alnum:]-]+)*)$$/$(1)/p" plugins.txt
endef

idris2-jupyter.ipkg: plugins.txt
	git checkout idris2-jupyter.ipkg
	sed -Ei "s/^(depends = python, jupyter)$$/\\1$$($(call format_plugins,\\3) | sed -E "s/ /\\n /g" | sort | uniq | paste -sd, -)/" idris2-jupyter.ipkg

Idris2Jupyter/Idris2Jupyter/InstalledPlugins.idr: plugins.txt
	git checkout Idris2Jupyter/Idris2Jupyter/InstalledPlugins.idr
	sed -Ei "s/^(-- Plugin imports)$$/\\1\n$$($(call format_plugins,import \\1) | paste -sd, - | sed 's/,/\\n/')/" Idris2Jupyter/Idris2Jupyter/InstalledPlugins.idr
	sed -Ei "s/^(InstalledPlugins = )\\[\\]$$/\\1[$$($(call format_plugins,\\1.\\2) | paste -sd, -)]/" Idris2Jupyter/Idris2Jupyter/InstalledPlugins.idr

install: idris2-jupyter
	jupyter kernelspec install --user Idris2Jupyter/

clean:
	$(RM) -r build
	git checkout idris2-jupyter.ipkg Idris2Jupyter/Idris2Jupyter/InstalledPlugins.idr plugins.txt

uninstall:
	jupyter kernelspec uninstall idris2jupyter
