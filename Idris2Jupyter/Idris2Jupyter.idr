module Idris2Jupyter

import Python

import Idris2Jupyter.CommandLineInterface
import Idris2Jupyter.IPyKernel

export
doExecute : (idris2 : CommandLineInterface)
         -> (ker : IPyKernelInstance)
         => (code : StringUTF8)
         -> (silent : Bool)
         -> (storeHistory : Bool)
         -> (userExpressions : PythonDict)
         -> (allowStdin : Bool)
         -> IO PythonDict
doExecute idris2 code silent storeHistory userExpressions allowStdin = do
    response <- run idris2 code

    if not silent
        then sendResponse !ioPubSocket "stream" !(toPyDict [
            ("name", "stdout"),
            ("text", response)
            ])
        else pure ()

    toPyDict [
        ("status", "ok"),
        ("execution_count", !executionCount)
        ]

main : IO ()
main = do
    (idris2, preamble) <- start "idris2" "Main> "

    launch (MkIPyKernel
        "Idris2Kernel"
        "0"
        preamble
        (MkLanguageInfo "text/x-idris" "idris2" ".idr")
        (doExecute idris2)
      )
