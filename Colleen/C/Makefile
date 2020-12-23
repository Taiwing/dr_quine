############################## COMPILE VAR #####################################

CC			=	gcc
CFLAGS		=	-g -Wall -Wextra -Werror -fsanitize=address,undefined
NAME		=	Colleen

############################## SOURCES #########################################

SRC			=	Colleen.c

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(SRC)
	$(CC) $(CFLAGS) $(HFLAGS) -o $@ $<

############################## CLEANUP #########################################

clean:

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
