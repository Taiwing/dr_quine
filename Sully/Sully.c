int i = 5;
char*src[]={
"char*src[]={",
"0};",
"/*",
"strings: (lol)",
"%s%d%s",
"%s%d;%c",
"int i = ",
"Sully.c",
"Sully_",
".c",
"w",
"asprintf: could not create file '%s%d%s'%c",
"fopen: could not open file '%s'%c",
"write_file: could not write file '%s'%c",
"gcc -Wall -Wextra -Werror %s -o %.*s",
"asprintf: could not create compile command%c",
"error: failed to run compile command '%s'%c",
"execve: failed to run child file '%s'%c",
"*/",
"",
"#define PRINTNAMEF			4",
"#define PRINTXF				5",
"#define INTLINE				6",
"#define START_NAME			7",
"#define BASE_NAME			8",
"#define NAME_EXTENSION			9",
"#define OPEN_MODE			10",
"#define ERROR_COULDNT_CREATE_FILE_NAME	11",
"#define ERROR_COULDNT_OPEN_FILE		12",
"#define ERROR_COULDNT_WRITE_FILE	13",
"#define COMPCMDF			14",
"#define ERROR_COULDNT_CREATE_COMPCMD	15",
"#define FAILED_TO_RUN_COMPCMD		16",
"#define ERROR_FAILED_TO_RUN_CHILD_FILE	17",
"",
"#define _GNU_SOURCE //for asprintf",
"#include <stdio.h>",
"#include <unistd.h>",
"#include <string.h>",
"#include <stdlib.h>",
"",
"int	fputendl(char *s, FILE *fp)",
"{",
"	if (fputs(s, fp) == EOF || fputc(10, fp) == EOF)",
"		return (1);",
"	return (0);",
"}",
"",
"int	quotify(char *s, FILE *fp)",
"{",
"	if (fputc(34, fp) == EOF || fputs(s, fp) == EOF",
"		|| fputc(34, fp) == EOF || fputc(44, fp) == EOF",
"		|| fputc(10, fp) == EOF)",
"		return (1);",
"	return (0);",
"};",
"",
"int	print_src(char**ptr, int(*f)(), FILE *fp)",
"{",
"	while(*ptr && !f(*ptr++, fp));",
"	return (!!*ptr);",
"}",
"",
"int	fprint_x(int x, FILE *fp)",
"{",
"	if (fprintf(fp, src[PRINTXF], src[INTLINE], x, 10) == -1)",
"		return (1);",
"	return (0);",
"}",
"",
"char	*write_file(int x)",
"{",
"	FILE	*fp;",
"	char	*file_name;",
"",
"	file_name = NULL;",
"	if (asprintf(&file_name, src[PRINTNAMEF], src[BASE_NAME], x, src[NAME_EXTENSION]) == -1)",
"	{",
"		dprintf(2, src[ERROR_COULDNT_CREATE_FILE_NAME],",
"			src[BASE_NAME], x, src[NAME_EXTENSION], 10);",
"		return (NULL);",
"	}",
"	if (!(fp = fopen(file_name, src[OPEN_MODE])))",
"	{",
"		dprintf(2, src[ERROR_COULDNT_OPEN_FILE], file_name, 10);",
"		free(file_name);",
"		return (NULL);",
"	}",
"	if (fprint_x(x, fp) || fputendl(src[0], fp)",
"		|| print_src(src, quotify, fp)",
"		|| print_src(src + 1, fputendl, fp))",
"	{",
"		dprintf(2, src[ERROR_COULDNT_WRITE_FILE], file_name, 10);",
"		free(file_name);",
"		return (NULL);",
"	}",
"	fclose(fp);",
"	return (file_name);",
"}",
"",
"char	*build_compile_command(char *file_name)",
"{",
"	char	*compile_command;",
"",
"	compile_command = NULL;",
"	if (asprintf(&compile_command, src[COMPCMDF], file_name,",
"		strlen(file_name) - 2, file_name) == -1)",
"	{",
"		dprintf(2, src[ERROR_COULDNT_CREATE_COMPCMD], 10);",
"		free(file_name);",
"		return (NULL);",
"	}",
"	return (compile_command);",
"}",
"",
"int	exec_file(char *file_name, char **env)",
"{",
"	file_name[strlen(file_name) - 2] = 0;",
"	if (execve(file_name, (char *[2]){file_name, NULL}, env) == -1)",
"	{",
"		dprintf(2, src[ERROR_FAILED_TO_RUN_CHILD_FILE], file_name, 10);",
"		free(file_name);",
"		return (EXIT_FAILURE);",
"	}",
"	return (EXIT_SUCCESS);",
"}",
"",
"int	main(int argc, char **argv, char **env)",
"{",
"	char	*file_name;",
"	char	*compile_command;",
"",
"	(void)argc;",
"	(void)argv;",
"	if (strcmp(__FILE__, src[START_NAME]))",
"		--i;",
"	if (i < 0)",
"		return (EXIT_SUCCESS);",
"	if (!(file_name = write_file(i)))",
"		return (EXIT_FAILURE);",
"	if (!(compile_command = build_compile_command(file_name)))",
"		return (EXIT_FAILURE);",
"	if (system(compile_command))",
"	{",
"		dprintf(2, src[FAILED_TO_RUN_COMPCMD], compile_command, 10);",
"		free(file_name);",
"		free(compile_command);",
"		return (EXIT_FAILURE);",
"	}",
"	free(compile_command);",
"	if (i && exec_file(file_name, env))",
"		return (EXIT_FAILURE);",
"	free(file_name);",
"	return (EXIT_SUCCESS);",
"}",
0};
/*
strings: (lol)
%s%d%s
%s%d;%c
int i = 
Sully.c
Sully_
.c
w
asprintf: could not create file '%s%d%s'%c
fopen: could not open file '%s'%c
write_file: could not write file '%s'%c
gcc -Wall -Wextra -Werror %s -o %.*s
asprintf: could not create compile command%c
error: failed to run compile command '%s'%c
execve: failed to run child file '%s'%c
*/

#define PRINTNAMEF			4
#define PRINTXF				5
#define INTLINE				6
#define START_NAME			7
#define BASE_NAME			8
#define NAME_EXTENSION			9
#define OPEN_MODE			10
#define ERROR_COULDNT_CREATE_FILE_NAME	11
#define ERROR_COULDNT_OPEN_FILE		12
#define ERROR_COULDNT_WRITE_FILE	13
#define COMPCMDF			14
#define ERROR_COULDNT_CREATE_COMPCMD	15
#define FAILED_TO_RUN_COMPCMD		16
#define ERROR_FAILED_TO_RUN_CHILD_FILE	17

#define _GNU_SOURCE //for asprintf
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

int	fputendl(char *s, FILE *fp)
{
	if (fputs(s, fp) == EOF || fputc(10, fp) == EOF)
		return (1);
	return (0);
}

int	quotify(char *s, FILE *fp)
{
	if (fputc(34, fp) == EOF || fputs(s, fp) == EOF
		|| fputc(34, fp) == EOF || fputc(44, fp) == EOF
		|| fputc(10, fp) == EOF)
		return (1);
	return (0);
};

int	print_src(char**ptr, int(*f)(), FILE *fp)
{
	while(*ptr && !f(*ptr++, fp));
	return (!!*ptr);
}

int	fprint_x(int x, FILE *fp)
{
	if (fprintf(fp, src[PRINTXF], src[INTLINE], x, 10) == -1)
		return (1);
	return (0);
}

char	*write_file(int x)
{
	FILE	*fp;
	char	*file_name;

	file_name = NULL;
	if (asprintf(&file_name, src[PRINTNAMEF], src[BASE_NAME], x, src[NAME_EXTENSION]) == -1)
	{
		dprintf(2, src[ERROR_COULDNT_CREATE_FILE_NAME],
			src[BASE_NAME], x, src[NAME_EXTENSION], 10);
		return (NULL);
	}
	if (!(fp = fopen(file_name, src[OPEN_MODE])))
	{
		dprintf(2, src[ERROR_COULDNT_OPEN_FILE], file_name, 10);
		free(file_name);
		return (NULL);
	}
	if (fprint_x(x, fp) || fputendl(src[0], fp)
		|| print_src(src, quotify, fp)
		|| print_src(src + 1, fputendl, fp))
	{
		dprintf(2, src[ERROR_COULDNT_WRITE_FILE], file_name, 10);
		free(file_name);
		return (NULL);
	}
	fclose(fp);
	return (file_name);
}

char	*build_compile_command(char *file_name)
{
	char	*compile_command;

	compile_command = NULL;
	if (asprintf(&compile_command, src[COMPCMDF], file_name,
		strlen(file_name) - 2, file_name) == -1)
	{
		dprintf(2, src[ERROR_COULDNT_CREATE_COMPCMD], 10);
		free(file_name);
		return (NULL);
	}
	return (compile_command);
}

int	exec_file(char *file_name, char **env)
{
	file_name[strlen(file_name) - 2] = 0;
	if (execve(file_name, (char *[2]){file_name, NULL}, env) == -1)
	{
		dprintf(2, src[ERROR_FAILED_TO_RUN_CHILD_FILE], file_name, 10);
		free(file_name);
		return (EXIT_FAILURE);
	}
	return (EXIT_SUCCESS);
}

int	main(int argc, char **argv, char **env)
{
	char	*file_name;
	char	*compile_command;

	(void)argc;
	(void)argv;
	if (strcmp(__FILE__, src[START_NAME]))
		--i;
	if (i < 0)
		return (EXIT_SUCCESS);
	if (!(file_name = write_file(i)))
		return (EXIT_FAILURE);
	if (!(compile_command = build_compile_command(file_name)))
		return (EXIT_FAILURE);
	if (system(compile_command))
	{
		dprintf(2, src[FAILED_TO_RUN_COMPCMD], compile_command, 10);
		free(file_name);
		free(compile_command);
		return (EXIT_FAILURE);
	}
	free(compile_command);
	if (i && exec_file(file_name, env))
		return (EXIT_FAILURE);
	free(file_name);
	return (EXIT_SUCCESS);
}
