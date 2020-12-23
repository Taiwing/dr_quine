############################## COMPILE VAR #####################################

RC			=	rustc
RCFLAGS		=	
NAME		=	Grace

############################## SOURCES #########################################

SRC			=	Grace.rs

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(SRC)
	$(RC) $(RCFLAGS) $<

############################## CLEANUP #########################################

clean:
	rm -f Grace_kid.rs

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
