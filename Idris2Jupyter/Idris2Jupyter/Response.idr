module Idris2Jupyter.Response

import Python

import Idris2Jupyter.IPyKernelInstance

||| How to send an object as a response to a running Jupyter kernel
public export
interface JupyterResponse a where
    sendResponse : IPyKernelInstance => a -> IO ()

export
JupyterResponse String where
    sendResponse response = sendResponse !ioPubSocket "stream" !(toPyDict [
        ("name", "stdout"),
        ("text", response)
        ])
