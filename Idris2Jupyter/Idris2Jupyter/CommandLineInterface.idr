module Idris2Jupyter.CommandLineInterface

import Python

import Idris2Jupyter.Pexpect

export
record CommandLineInterface where
    constructor MkCommandLineInterface
    process : Process
    prompt : StringUTF8

export
start : HasIO io => (cli : StringUTF8) -> (prompt : StringUTF8) -> io (CommandLineInterface, StringUTF8)
start cli prompt = do
    process <- spawn cli
    _ <- expect process prompt
    preamble <- before process
    pure (MkCommandLineInterface process prompt, preamble)

export
run : HasIO io => CommandLineInterface -> (cmd : StringUTF8) -> io StringUTF8
run (MkCommandLineInterface process prompt) cmd = do
    _ <- sendLine process cmd
    _ <- expect process prompt
    before process
