char*t[]={
"char a[]={'c','h','a','r','*','t','[',']','=','{',0,'0','}',';',0};",
"#include<stdio.h>/**/",
"#define w putchar",
"int q(char*s){w(34);printf(s);w(34);w(44);w(10);return 0;};",
"void p(char**z,int(*f)()){while(*z)f(*z++);}",
"int main(){/**/puts(a);p(t,q);puts(a+11);p(t,puts);}",
0};
char a[]={'c','h','a','r','*','t','[',']','=','{',0,'0','}',';',0};
#include<stdio.h>/**/
#define w putchar
int q(char*s){w(34);printf(s);w(34);w(44);w(10);return 0;};
void p(char**z,int(*f)()){while(*z)f(*z++);}
int main(){/**/puts(a);p(t,q);puts(a+11);p(t,puts);}
