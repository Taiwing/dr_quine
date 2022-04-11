# dr\_quine

A quine is a program that simply prints its own source code. This project
aims at implementing quine-like programs. It is a fun little code
challenge and also an introduction to self replicating code. They must be
implemented in the simplest way possible without taking data from the
outside (eg: you cannot simply read and print the source code).

<br />
<p align="center">
  <img src="https://github.com/Taiwing/dr_quine/blob/master/resources/infinite_mirrors.png?raw=true" alt="infinite mirrors"/>
</p>

## Setup

Each program of this project is implemented in three different languages.
In C, in ASM and in Rust. They all have their own makefile at the root of
their respective directory.

```shell
# clone it
git clone https://github.com/Taiwing/dr_quine
# make and run Colleen's C version
cd dr_quine/Colleen/C && make && ./Colleen
# make and run Grace's ASM version
cd ../../Grace/ASM && make && ./Grace
# make and run Sully's Rust version
cd ../../Sully/RUST && make && ./Sully
```

The C, ASM and Rust projects depend respectively on gcc, yasm and rustc
to compile and execute properly.

> To make the C version as short as possible some returns and types have been
> omitted in the code. It prints a lot of warnings but still compiles with gcc
> 9.4.0

## Colleen

This is a simple quine. The three versions will print their source code.

Running `./Colleen` in Colleen/C/ will print:

```C
char*t[]={
"char*t[]={",
"0};",
"#define W putchar",
"q(int*s){W(34);printf(s,0);W(34);W(44);W(10);};",
"p(int**z,int(*f)()){while(*z)f(*z++);}",
"main(){puts(*t);p(t,q);p(t+1,puts);}",
0};
#define W putchar
q(int*s){W(34);printf(s,0);W(34);W(44);W(10);};
p(int**z,int(*f)()){while(*z)f(*z++);}
main(){puts(*t);p(t,q);p(t+1,puts);}
```

## Grace

Like a quine but copies itself in an other file instead of printing.

## Sully

An integer is declared in the source code. It is set to five. On execution
Sully copies itself into a *Sully\_i.ext* file (where *i* is the value of
the integer and *ext* is the type of the file). It will then proceed to
compile the new file and execute it with an execve call. The new process
will do the same except that it will decrease the value of the integer.
This means that the entire operation is basically a loop of self
replicating programs.

## Development

At the root of the project there is a *templates/* directory. Since the
solution found to the quine problem is a simple array of strings that
stores the entire source code, it needs to be copied each time and
"stringified" which is very boring to do manually. So each quine
program is written without the data part (the file names are prefixed
with *TEMPLATE*).

When modifying a template the *set_source_code_str* script can be
executed to add the data part to the file and create the quine.

#### example:

```shell
cd templates/
# make some really useful modifications
vim TEMPLATE_Colleen.c
# create a new Colleen.c
./set_source_code_str TEMPLATE_Colleen.c
# move it to its directory
mv Colleen.c ../Colleen/C/
```
