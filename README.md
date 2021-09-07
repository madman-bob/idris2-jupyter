# Idris2-Jupyter

A Jupyter Kernel for Idris 2.

## Installation

Ensure that the Idris 2 [Python backend](https://github.com/madman-bob/idris2-python)
is installed, in a sibling directory of this repository.

Then run:

```bash
make install
```

## Running notebooks

Run the notebook as usual, with the built `idris2-jupyter` module available to the Python module search path.

For example:

```bash
PYTHONPATH=build/exec/ jupyter notebook
```

Note that the cells use the Idris 2 REPL syntax, rather than the syntax used in `.idr` files.

### Importing packages

Additional packages may be made accessible using the
[`.ipkg` format](https://idris2.readthedocs.io/en/latest/tutorial/packages.html).
The `.ipkg` file will be found as though by the `--find-ipkg` flag, from the working directory.

## Plugins

There is a plugin system for displaying rich data responses.

A plugin is a `Type` in an Idris 2 library which implements the `Jupyter.Response` `Idris2Response` and `JupyterResponse` interfaces.
The `Idris2Response` interface attempts to interpret an Idris 2 REPL response as a rich response.
The `JupyterResponse` interface sends that rich response to a running Jupyter kernel.

### Installing plugins

To install a plugin, refer to that plugin's installation instructions.

To install a custom plugin, run `make add-plugin` with the variables `module`, `plugin`, and `packages` set;
then run `make install`.

The `plugin` variable is the name of the plugin `Type` to be used, contained in the `module` module.
The `packages` variable is a space separated list of packages that need to be imported to use that module.
This list of packages is the package defining the named module, and its dependencies, excluding the `python` and `jupyter` packages.

For example:

```bash
make add-plugin module="Some.Plugin.Module" plugin="PluginType" packages="some-package another-package"
```
