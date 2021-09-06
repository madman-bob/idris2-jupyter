module Jupyter.IPythonResponse

import Python

import Jupyter.IPyKernelInstance
import Jupyter.Response

%default total

||| Defining this interface on a type represents a promise that the resultant
||| Python object implements the IPython _repr_mimebundle_ display method, as
||| described in
||| https://ipython.readthedocs.io/en/stable/config/integrating.html
public export
interface PythonType IO a => HasIPythonReprMimeBundle a where

%foreign "python: lambda obj: obj._repr_mimebundle_()"
prim__ipy_mime_bundle : PythonObject -> PrimIO PythonObject

%foreign "python: lambda bundle: bundle.__getitem__(0) if tuple.__instancecheck__(bundle) else bundle"
prim__ipy_mime_bundle_response_data : PythonObject -> PythonDict

%foreign "python: lambda bundle: bundle.__getitem__(1) if tuple.__instancecheck__(bundle) else {}"
prim__ipy_mime_bundle_response_metadata : PythonObject -> PythonDict

export
HasIPythonReprMimeBundle a => JupyterResponse a where
    sendResponse response = do
        pyResponse <- toPy response
        mimeBundle <- primIO $ prim__ipy_mime_bundle pyResponse

        let responseData = prim__ipy_mime_bundle_response_data mimeBundle
        let responseMetadata = prim__ipy_mime_bundle_response_metadata mimeBundle

        sendResponse !ioPubSocket "display_data" !(toPyDict [
            ("data", responseData),
            ("metadata", responseMetadata)
            ])
