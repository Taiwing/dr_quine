############################## COMPILE VAR #####################################

CC			=	gcc
HFLAGS		=	-include stdio.h
NAME		=	Colleen

############################## SOURCES #########################################

SRC			=	Colleen.c

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(SRC)
	$(CC) $(HFLAGS) -o $@ $<

############################## CLEANUP #########################################

clean:

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
