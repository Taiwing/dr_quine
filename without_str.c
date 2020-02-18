#include <string.h>
#include <unistd.h>

const char	g_vtab = 9;
const char	g_dquote = 34;
const char	g_backsl = 92;
const char 	g_newline = 10;
const char	g_comma = ',';

const char	g_name_of_source_code[] = {
	'c','o','n','s','t',' ','c','h','a','r',g_vtab,'*','g','_','s','o','u','r','c','e','_','c','o','d','e','[',']',' ','=',' ','{'
};

const char	g_newlinestr[] = {g_backsl,'n'};

const char	g_nullstr[] = {g_vtab,'0',g_newline,'}',';'};

void		print_str_source(void)
{

	char	**ptr;

	ptr = (char **)g_source_code;
	write(1, g_name_of_source_code, sizeof(g_name_of_source_code));
	write(1, &g_newline, 1);
	while (*ptr)
	{
		write(1, &g_vtab, 1);
		write(1, &g_dquote, 1);
		write(1, *ptr, strlen(*ptr) - 1);
		write(1, g_newlinestr, sizeof(g_newlinestr));
		write(1, &g_dquote, 1);
		write(1, &g_comma, 1);
		write(1, &g_newline, 1);
		++ptr;
	}
	write(1, &g_nullstr, sizeof(g_nullstr));
	write(1, &g_newline, 1);
}

void		print_raw_source(void)
{
	char	**ptr;

	ptr = (char **)g_source_code;
	while (*ptr)
	{
		write(1, *ptr, strlen(*ptr));
		++ptr;
	}
}

int		main(void)
{
	/*Hello, I am a really useful comment*/
	print_str_source();
	print_raw_source();
	return (0);
}
/*Hello, I am an other really useful comment*/
