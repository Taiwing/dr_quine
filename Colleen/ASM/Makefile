############################## COMPILE VAR #####################################

AC			=	yasm
ACFLAGS		=	-Worphan-labels -g dwarf2 -f elf64
AL			=	ld
ALFLAGS		=	-g -m elf_x86_64 -s
NAME		=	Colleen

############################## SOURCES #########################################

SRC			=	Colleen.s
OBJ			=	Colleen.o

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(OBJ)
	$(AL) $(ALFLAGS) -o $@ $<

%.o: %.s
	$(AC) $(ACFLAGS) $<

############################## CLEANUP #########################################

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
