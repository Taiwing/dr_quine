############################## COMPILE VAR #####################################

AC			=	yasm
ACFLAGS		=	-Worphan-labels -g dwarf2 -f elf64
AL			=	ld
ALFLAGS		=	-g -m elf_x86_64 -s
NAME		=	Sully

############################## SOURCES #########################################

SRC			=	Sully.s
OBJ			=	Sully.o

############################## BUILD ###########################################

all: $(NAME)

$(NAME): $(OBJ)
	$(AL) $(ALFLAGS) -o $@ $<

%.o: %.s
	$(AC) $(ACFLAGS) $<

############################## CLEANUP #########################################

clean:
	rm -f Sully_*
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
