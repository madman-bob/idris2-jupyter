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
