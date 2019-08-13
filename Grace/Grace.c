#define TEXT char*t[]={"#define TEXT char*t[]={","0}","#define PROGRAM int print_program(void){FILE*fp;if(!(fp=fopen(t[9],t[10])))return(1);char**w=t;fprintf(fp,t[0]);while(*w)fprintf(fp,t[7],34,*w++,34);fprintf(fp,t[8],t[1],10);w=t+2;while(*w)fprintf(fp,t[8],*w++,10);return(0);} void _start(void){print_program();exit(0);}","#include <stdio.h>","#include <stdlib.h>","/*","strings:","%c%s%c,","%s%c","Grace_kid.c","w","*/","TEXT;","PROGRAM",0}
#define PROGRAM int print_program(void){FILE*fp;if(!(fp=fopen(t[9],t[10])))return(1);char**w=t;fprintf(fp,t[0]);while(*w)fprintf(fp,t[7],34,*w++,34);fprintf(fp,t[8],t[1],10);w=t+2;while(*w)fprintf(fp,t[8],*w++,10);return(0);} void _start(void){print_program();exit(0);}
#include <stdio.h>
#include <stdlib.h>
/*
strings:
%c%s%c,
%s%c
Grace_kid.c
w
*/
TEXT;
PROGRAM
