# dr\_quine

A quine is a program that simply prints its own source code. This project
aims at implementing quine-like programs. It is a fun little code
challenge and also an introduction to self replicating code. They must be
implemented in the simplest way possible without taking data from the
outside (eg: you cannot simply read and print the source code).

## Setup

Each program of this project is implemented in three different languages.
In C, in ASM and in Rust. They all have their own makefile at the root of
their respective directory.

#### examples:

```shell
cd Colleen/C && make && ./Colleen
cd Grace/ASM && make && ./Grace
cd Sully/RUST && make && ./Sully
```

The C, ASM and Rust projects depend respectively on gcc, yasm and rustc
to compile and execute properly.

## Colleen

This is a simple quine. The three versions will print their source code.

## Grace

Like a quine but copies itself in an other file instead of printing.

## Sully

An integer isdeclared in the source code. It is set to five. On execution
Sully copies itself into a *Sully\_i.ext* file (where *i* is the value of
the integer and *ext* is the type of the file). It will then proceed to
compile the new file and execute it with an execve call. The new process
will do the same except that it will decrease the value of the integer.
This means that the entire operation is basically a loop of self
replicating programs.

