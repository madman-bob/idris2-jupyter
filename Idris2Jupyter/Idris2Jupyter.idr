module Idris2Jupyter

import Python

import Jupyter
import Jupyter.CommandLineInterface
import Jupyter.Plugins

import Idris2Jupyter.InstalledPlugins

%default total

export
doExecute : (idris2 : CommandLineInterface)
         -> (ker : IPyKernelInstance)
         => (code : String)
         -> (silent : Bool)
         -> (storeHistory : Bool)
         -> (userExpressions : PythonDict)
         -> (allowStdin : Bool)
         -> IO PythonDict
doExecute idris2 code silent storeHistory userExpressions allowStdin = do
    rawResponse <- run idris2 code

    if not silent
        then do
            Evidence _ (_, richResponse) <- parseResponse InstalledPlugins rawResponse
            sendResponse richResponse
        else pure ()

    toPyDict [
        ("status", "ok"),
        ("execution_count", !executionCount)
        ]

main : IO ()
main = do
    (idris2, preamble) <- start "idris2 --find-ipkg --ignore-missing-ipkg" "Main> "

    launch (MkIPyKernel
        "Idris2Kernel"
        "0"
        preamble
        (MkLanguageInfo "text/x-idris" "idris2" ".idr")
        (doExecute idris2)
      )
