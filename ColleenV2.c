char*t[]={
"char a[]={'c','h','a','r','*','t','[',']','=','{',0,'0','}',';',0};",
"#include<stdio.h>/**/",
"int q(char*s){putchar(34);printf(s);putchar(34);putchar(44);putchar(10);return 0;};",
"void p(char**w,int(*f)()){while(*w)f(*w++);}",
"int main(){/**/puts(a);p(t,q);puts(a+11);p(t,puts);}",
0};
char a[]={'c','h','a','r','*','t','[',']','=','{',0,'0','}',';',0};
#include<stdio.h>/**/
int q(char*s){putchar(34);printf(s);putchar(34);putchar(44);putchar(10);return 0;};
void p(char**w,int(*f)()){while(*w)f(*w++);}
int main(){/**/puts(a);p(t,q);puts(a+11);p(t,puts);}
