module Idris2Jupyter.CommandLineInterface

import Python

import Idris2Jupyter.Pexpect

export
record CommandLineInterface where
    constructor MkCommandLineInterface
    process : Process
    prompt : String

export
start : HasIO io => (cli : String) -> (prompt : String) -> io (CommandLineInterface, String)
start cli prompt = do
    process <- spawn cli
    _ <- expect process prompt
    preamble <- before process
    pure (MkCommandLineInterface process prompt, preamble)

export
run : HasIO io => CommandLineInterface -> (cmd : String) -> io String
run (MkCommandLineInterface process prompt) cmd = do
    _ <- sendLine process cmd
    _ <- expect process prompt
    before process
