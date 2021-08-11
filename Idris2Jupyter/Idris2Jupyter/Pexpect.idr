module Idris2Jupyter.Pexpect

import Python

export
data Process : Type where [external]

%foreign "python: spawnu, pexpect"
prim__py_spawn : StringUTF8 -> PrimIO Process

export
spawn : HasIO io => String -> io Process
spawn cmd = primIO $ prim__py_spawn $ toUTF8 cmd

%foreign "python: spawn.expect, pexpect"
prim__py_expect : Process -> StringUTF8 -> PrimIO Int

export
expect : HasIO io => Process -> String -> io Int
expect process re = primIO $ prim__py_expect process $ toUTF8 re

%foreign "python: attrgetter(\"before\"), operator"
prim__py_before : Process -> PrimIO StringUTF8

export
before : HasIO io => Process -> io String
before process = map fromUTF8 $ primIO $ prim__py_before process

%foreign "python: spawn.sendline, pexpect"
prim__py_sendLine : Process -> StringUTF8 -> PrimIO Int

export
sendLine : HasIO io => Process -> String -> io Int
sendLine process line = primIO $ prim__py_sendLine process (toUTF8 line)
