char*src[]={
"char*src[]={",
"0};",
"/*",
"strings: (lol)",
"Grace_kid.c",
"w",
"*/",
"#include <stdio.h>",
"#include <string.h>",
"#define MAIN int main(){return pseudo_main();}",
"",
"void	fputendl(char *s, FILE *fp)",
"{",
"	fputs(s, fp);",
"	fputc(10, fp);",
"}",
"",
"void	quotify(char *s, FILE *fp)",
"{",
"	fputc(34, fp);",
"	fputs(s, fp);",
"	fputc(34, fp);",
"	fputc(44, fp);",
"	fputc(10, fp);",
"};",
"",
"void print_src(char**ptr, void(*f)(), FILE *fp)",
"{",
"	while(*ptr)",
"		f(*ptr++, fp);",
"}",
"",
"int pseudo_main()",
"{",
"	FILE	*fp;",
"",
"	if (!(fp = fopen(src[4], src[5])))",
"		return (1);",
"	fputendl(*src, fp);",
"	print_src(src, quotify, fp);",
"	print_src(src + 1, fputendl, fp);",
"	fclose(fp);",
"	return (0);",
"}",
"",
"MAIN",
0};
/*
strings: (lol)
Grace_kid.c
w
*/
#include <stdio.h>
#include <string.h>
#define MAIN int main(){return pseudo_main();}

void	fputendl(char *s, FILE *fp)
{
	fputs(s, fp);
	fputc(10, fp);
}

void	quotify(char *s, FILE *fp)
{
	fputc(34, fp);
	fputs(s, fp);
	fputc(34, fp);
	fputc(44, fp);
	fputc(10, fp);
};

void print_src(char**ptr, void(*f)(), FILE *fp)
{
	while(*ptr)
		f(*ptr++, fp);
}

int pseudo_main()
{
	FILE	*fp;

	if (!(fp = fopen(src[4], src[5])))
		return (1);
	fputendl(*src, fp);
	print_src(src, quotify, fp);
	print_src(src + 1, fputendl, fp);
	fclose(fp);
	return (0);
}

MAIN
