module Jupyter.IPyKernelInstance

import Python

%default total

export
data IPyKernelSocket : Type where [external]

export
PrimPythonType IPyKernelSocket where

export
data IPyKernelInstance : Type where [external]

export
PrimPythonType IPyKernelInstance where

%foreign "python: attrgetter(\"execution_count\"), operator"
prim__py_executionCount : IPyKernelInstance -> PrimIO PythonInteger

export
executionCount : HasIO io => IPyKernelInstance => io PythonInteger
executionCount @{_} @{ker} = primIO $ prim__py_executionCount ker

%foreign "python: attrgetter(\"iopub_socket\"), operator"
prim__py_ioPubSocket : IPyKernelInstance -> PrimIO IPyKernelSocket

export
ioPubSocket : HasIO io => IPyKernelInstance => io IPyKernelSocket
ioPubSocket @{_} @{ker} = primIO $ prim__py_ioPubSocket ker

%foreign "python: Kernel.send_response, ipykernel.kernelbase"
prim__py_sendResponse : IPyKernelInstance -> IPyKernelSocket -> StringUTF8 -> PythonDict -> PrimIO ()

export
sendResponse : HasIO io => IPyKernelInstance => IPyKernelSocket -> String -> PythonDict -> io ()
sendResponse @{_} @{ker} soc s d = primIO $ prim__py_sendResponse ker soc (toUTF8 s) d
