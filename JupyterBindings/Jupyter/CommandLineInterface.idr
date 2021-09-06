module Jupyter.CommandLineInterface

import Python

%default total

export
data CommandLineInterface : Type where [external]

%foreign "python: REPLWrapper, pexpect.replwrap"
prim__cli_start : StringUTF8 -> StringUTF8 -> PythonObject -> PrimIO CommandLineInterface

%foreign "python: lambda repl: repl.child.before"
prim__cli_preamble : CommandLineInterface -> PrimIO StringUTF8

export
start : HasIO io => (cli : String) -> (prompt : String) -> io (CommandLineInterface, String)
start cli prompt = do
    cli <- primIO $ prim__cli_start (toUTF8 cli) (toUTF8 prompt) !(toPy ())
    preamble <- primIO $ prim__cli_preamble cli
    pure (cli, fromUTF8 preamble)

%foreign "python: REPLWrapper.run_command, pexpect.replwrap"
prim__cli_run : CommandLineInterface -> StringUTF8 -> PrimIO StringUTF8

export
run : HasIO io => CommandLineInterface -> (cmd : String) -> io String
run cli cmd = map fromUTF8 $ primIO $ prim__cli_run cli (toUTF8 cmd)
