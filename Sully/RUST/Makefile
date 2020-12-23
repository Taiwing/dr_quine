############################## COMPILE VAR #####################################

RC			=	rustc
RCFLAGS		=	
NAME		=	Sully

############################## SOURCES #########################################

SRC			=	Sully.rs

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(SRC)
	$(RC) $(RCFLAGS) $<

############################## CLEANUP #########################################

clean:
	rm -f Sully_*

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
