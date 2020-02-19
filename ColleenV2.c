char*t[]={
"char*t[]={",
"0};",
"#include<stdio.h>/**/",
"#define W putchar",
"int q(char*s){W(34);printf(s);W(34);W(44);W(10);return 0;};",
"void p(char**z,int(*f)()){while(*z)f(*z++);}",
"int main(){/**/puts(*t);p(t,q);p(t+1,puts);}",
0};
#include<stdio.h>/**/
#define W putchar
int q(char*s){W(34);printf(s);W(34);W(44);W(10);return 0;};
void p(char**z,int(*f)()){while(*z)f(*z++);}
int main(){/**/puts(*t);p(t,q);p(t+1,puts);}
