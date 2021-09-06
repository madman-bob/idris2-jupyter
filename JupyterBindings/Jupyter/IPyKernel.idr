module Jupyter.IPyKernel

import Python

import public Jupyter.IPyKernelInstance

%default total

public export
record LanguageInfo where
    constructor MkLanguageInfo
    mimetype : String
    name : String
    fileExtension : String

export
HasIO io => PythonType io LanguageInfo where
    toPy (MkLanguageInfo mimetype name fileExtension) = toPyDict [
        ("mimetype", mimetype),
        ("name", name),
        ("file_extension", fileExtension)
        ] >>= toPy

-- Bit of a hack, because we want the class, not the instance
%foreign "python: Kernel and (lambda: ipykernel.kernelbase.Kernel), ipykernel.kernelbase"
prim__IPyKernelBase : PrimIO PythonClass

IPyKernelBase : HasIO io => io PythonClass
IPyKernelBase = primIO prim__IPyKernelBase

public export
record IPyKernel where
    constructor MkIPyKernel
    kernelName : String
    kernelVersion : String
    banner : String
    languageInfo : LanguageInfo
    doExecute : (ker : IPyKernelInstance)
             => (code : String)
             -> (silent : Bool)
             -> (storeHistory : Bool)
             -> (userExpressions : PythonDict)
             -> (allowStdin : Bool)
             -> IO PythonDict

wrapDoExecute : (doExecute : (ker : IPyKernelInstance)
                          => (code : String)
                          -> (silent : Bool)
                          -> (storeHistory : Bool)
                          -> (userExpressions : PythonDict)
                          -> (allowStdin : Bool)
                          -> IO PythonDict)
             -> (ker : IPyKernelInstance)
             -> (code : StringUTF8)
             -> (silent : PythonBool)
             -> (storeHistory : PythonBool)
             -> (userExpressions : PythonDict)
             -> (allowStdin : PythonBool)
             -> PrimIO PythonDict
wrapDoExecute doExecute ker code silent storeHistory userExpressions allowStdin =
    toPrimIO $ do doExecute @{ker} (fromUTF8 code) !(isTruthy silent) !(isTruthy storeHistory) userExpressions !(isTruthy allowStdin)

export
toPyClass : HasIO io => IPyKernel -> io PythonClass
toPyClass (MkIPyKernel kernelName kernelVersion banner languageInfo doExecute) = liftIO $ do
    d <- toPyDict [
        ("implementation", kernelName),
        ("implementation_version", kernelVersion),
        ("banner", banner),
        ("language_info", languageInfo),
        ("do_execute", wrapDoExecute doExecute)
        ]
    subclass (toUTF8 kernelName) [!IPyKernelBase] d

export
HasIO io => PythonType io IPyKernel where
    toPy = toPyClass >=> toPy

%foreign "python: IPKernelApp and (lambda ker: ipykernel.kernelapp.IPKernelApp.launch_instance(kernel_class=ker)), ipykernel.kernelapp"
prim__py_launch_ipykernel : PythonClass -> PrimIO ()

export
launch : HasIO io => IPyKernel -> io ()
launch ker = primIO $ prim__py_launch_ipykernel !(toPyClass ker)
