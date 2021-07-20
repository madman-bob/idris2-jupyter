module Idris2Jupyter.Pexpect

import Python

export
data Process : Type where [external]

%foreign "python: spawnu, pexpect"
prim__py_spawn : StringUTF8 -> PrimIO Process

export
spawn : HasIO io => StringUTF8 -> io Process
spawn = primIO . prim__py_spawn

%foreign "python: spawn.expect, pexpect"
prim__py_expect : Process -> StringUTF8 -> PrimIO Int

export
expect : HasIO io => Process -> StringUTF8 -> io Int
expect process re = primIO $ prim__py_expect process re

%foreign "python: attrgetter(\"before\"), operator"
prim__py_before : Process -> PrimIO StringUTF8

export
before : HasIO io => Process -> io StringUTF8
before = primIO . prim__py_before

%foreign "python: spawn.sendline, pexpect"
prim__py_sendLine : Process -> StringUTF8 -> PrimIO Int

export
sendLine : HasIO io => Process -> StringUTF8 -> io Int
sendLine process line = primIO $ prim__py_sendLine process line
