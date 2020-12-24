############################## COMPILE VAR #####################################

CC			=	gcc
CFLAGS		=	-g -Wall -Wextra -Werror -fsanitize=address,undefined
HFLAGS		=	-include stdio.h -include stdlib.h
NAME		=	Grace

############################## SOURCES #########################################

SRC			=	Grace.c

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(SRC)
	$(CC) $(CFLAGS) $(HFLAGS) -o $@ $<

############################## CLEANUP #########################################

clean:
	rm -f Grace_kid.c

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
