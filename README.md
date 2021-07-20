# Idris2-Jupyter

A Jupyter Kernel for Idris 2.

## Installation

Build `Idris2-Jupyter` using the Idris 2
[Python backend](https://github.com/madman-bob/idris2-python).

```bash
idris2-python --build idris2-jupyter.ipkg
```

Add the `Idris2-Jupyter` kernelspec to Jupyter.

```bash
jupyter kernelspec install --user Idris2Jupyter/
```

## Running notebooks

Run the notebook as usual, with the built `idris2-jupyter` module available to the Python module search path.

For example:

```bash
PYTHONPATH=build/exec/ jupyter notebook
```

Note that the cells use the Idris 2 REPL syntax, rather than the syntax used in `.idr` files.
