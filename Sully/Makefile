############################## COMPILE VAR #####################################

CC			=	gcc
CFLAGS		=	-g -Wall -Wextra -Werror -fsanitize=address,undefined
NAME		=	Sully

############################## SOURCES #########################################

SRC			=	Sully.c

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(SRC)
	$(CC) $(CFLAGS) $(HFLAGS) -o $@ $<

############################## CLEANUP #########################################

clean:
	rm -f Sully_*

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
