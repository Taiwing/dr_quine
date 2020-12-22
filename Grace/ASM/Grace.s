section .text
	global _start

;mandatory single comment ;)
%define useless_define_1 0
%define useless_define_2 0
%define useless_define_3 0

_start:
	mov rdi, FILE_NAME
	call openOutputFile
	mov [fd], rax
	mov rdi, txt
	mov rsi, TXT_LINE_COUNT
	call printRawText
	mov rdi, txt
	mov rsi, TXT_LINE_COUNT
	call printQuotedText
	call closeOutputFile
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall

openOutputFile:
	mov rax, SYS_creat
	mov rsi, 00664q
	syscall
	cmp rax, 0x0
	jl openError
	ret

closeOutputFile:
	mov rax, SYS_close
	mov rdi, [fd]
	syscall
	ret

openError:
	mov rdi, OPEN_ERROR_STRING
	mov qword [fd], 0x2
	call putendl
	mov rax, SYS_exit
	mov rdi, EXIT_FAILURE
	syscall

printRawText:
	mov qword [ptr], rdi
	mov qword [loopCnt], rsi
printRawLine:
	mov rdi, [ptr]
	call strlen
	mov [index], rax
	call putendl
	mov r11, [index]
	add [ptr], r11
	add qword [ptr], 0x1
	dec qword [loopCnt]
	cmp qword [loopCnt], 0x0
	jne printRawLine
	ret

printQuotedText:
	mov qword [ptr], rdi
	mov qword [loopCnt], rsi
printQuotedLine:
	mov rdi, LINE_START
	call putstr
	mov rdi, [ptr]
	call strlen
	mov [index], rax
	call putstr
	mov rdi, LINE_END
	call putendl
	mov r11, [index]
	add [ptr], r11
	add qword [ptr], 0x1
	dec qword [loopCnt]
	cmp qword [loopCnt], 0x0
	jne printQuotedLine
	ret

write:
	mov rax, SYS_write
	mov rdi, [fd]
	mov rsi, [buf]
	mov rdx, [len]
	syscall
	ret

strlen:
	mov rax, 0xffffffffffffffff
whileNotZero:
	inc rax
	movzx r10, byte [rdi+rax]
	cmp r10, 0x0
	jne whileNotZero
	ret

putstr:
	call strlen
	mov [buf], rdi
	mov [len], rax
	call write
	ret

putendl:
	call putstr
	mov qword [buf], ENDL
	mov byte [len], 0x1
	call write
	ret

segment .bss
ptr resq 0x1
index resq 0x1
fd resq 0x1
buf resq 0x1
len resq 0x1
loopCnt resq 0x1

section .data
SYS_exit equ 0x3c
SYS_write equ 0x1
SYS_creat equ 0x55
SYS_close equ 0x3
EXIT_SUCCESS equ 0x0
EXIT_FAILURE equ 0x1
ENDL db 0xa
LINE_START db 'db ', 0x22, 0x0
LINE_END db 0x22, ', 0x0', 0x0
FILE_NAME db 'Grace_kid.s', 0x0
OPEN_ERROR_STRING db 'error: could not open/create file', 0x0
