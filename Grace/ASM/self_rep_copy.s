;mandatory single comment ;)
%macro startProgram 0
	global _start
%endmacro
%macro useless_macro_1 0
%endmacro
%macro useless_macro_2 0
%endmacro

section .text
	startProgram

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
TXT_LINE_COUNT equ 0x8A
txt:
db ";mandatory single comment ;)", 0x0
db "%macro startProgram 0", 0x0
db "	global _start", 0x0
db "%endmacro", 0x0
db "%macro useless_macro_1 0", 0x0
db "%endmacro", 0x0
db "%macro useless_macro_2 0", 0x0
db "%endmacro", 0x0
db "", 0x0
db "section .text", 0x0
db "	startProgram", 0x0
db "", 0x0
db "_start:", 0x0
db "	mov rdi, FILE_NAME", 0x0
db "	call openOutputFile", 0x0
db "	mov [fd], rax", 0x0
db "	mov rdi, txt", 0x0
db "	mov rsi, TXT_LINE_COUNT", 0x0
db "	call printRawText", 0x0
db "	mov rdi, txt", 0x0
db "	mov rsi, TXT_LINE_COUNT", 0x0
db "	call printQuotedText", 0x0
db "	call closeOutputFile", 0x0
db "	mov rax, SYS_exit", 0x0
db "	mov rdi, EXIT_SUCCESS", 0x0
db "	syscall", 0x0
db "", 0x0
db "openOutputFile:", 0x0
db "	mov rax, SYS_creat", 0x0
db "	mov rsi, 00664q", 0x0
db "	syscall", 0x0
db "	cmp rax, 0x0", 0x0
db "	jl openError", 0x0
db "	ret", 0x0
db "", 0x0
db "closeOutputFile:", 0x0
db "	mov rax, SYS_close", 0x0
db "	mov rdi, [fd]", 0x0
db "	syscall", 0x0
db "	ret", 0x0
db "", 0x0
db "openError:", 0x0
db "	mov rdi, OPEN_ERROR_STRING", 0x0
db "	mov qword [fd], 0x2", 0x0
db "	call putendl", 0x0
db "	mov rax, SYS_exit", 0x0
db "	mov rdi, EXIT_FAILURE", 0x0
db "	syscall", 0x0
db "", 0x0
db "printRawText:", 0x0
db "	mov qword [ptr], rdi", 0x0
db "	mov qword [loopCnt], rsi", 0x0
db "printRawLine:", 0x0
db "	mov rdi, [ptr]", 0x0
db "	call strlen", 0x0
db "	mov [index], rax", 0x0
db "	call putendl", 0x0
db "	mov r11, [index]", 0x0
db "	add [ptr], r11", 0x0
db "	add qword [ptr], 0x1", 0x0
db "	dec qword [loopCnt]", 0x0
db "	cmp qword [loopCnt], 0x0", 0x0
db "	jne printRawLine", 0x0
db "	ret", 0x0
db "", 0x0
db "printQuotedText:", 0x0
db "	mov qword [ptr], rdi", 0x0
db "	mov qword [loopCnt], rsi", 0x0
db "printQuotedLine:", 0x0
db "	mov rdi, LINE_START", 0x0
db "	call putstr", 0x0
db "	mov rdi, [ptr]", 0x0
db "	call strlen", 0x0
db "	mov [index], rax", 0x0
db "	call putstr", 0x0
db "	mov rdi, LINE_END", 0x0
db "	call putendl", 0x0
db "	mov r11, [index]", 0x0
db "	add [ptr], r11", 0x0
db "	add qword [ptr], 0x1", 0x0
db "	dec qword [loopCnt]", 0x0
db "	cmp qword [loopCnt], 0x0", 0x0
db "	jne printQuotedLine", 0x0
db "	ret", 0x0
db "", 0x0
db "write:", 0x0
db "	mov rax, SYS_write", 0x0
db "	mov rdi, [fd]", 0x0
db "	mov rsi, [buf]", 0x0
db "	mov rdx, [len]", 0x0
db "	syscall", 0x0
db "	ret", 0x0
db "", 0x0
db "strlen:", 0x0
db "	mov rax, 0xffffffffffffffff", 0x0
db "whileNotZero:", 0x0
db "	inc rax", 0x0
db "	movzx r10, byte [rdi+rax]", 0x0
db "	cmp r10, 0x0", 0x0
db "	jne whileNotZero", 0x0
db "	ret", 0x0
db "", 0x0
db "putstr:", 0x0
db "	call strlen", 0x0
db "	mov [buf], rdi", 0x0
db "	mov [len], rax", 0x0
db "	call write", 0x0
db "	ret", 0x0
db "", 0x0
db "putendl:", 0x0
db "	call putstr", 0x0
db "	mov qword [buf], ENDL", 0x0
db "	mov byte [len], 0x1", 0x0
db "	call write", 0x0
db "	ret", 0x0
db "", 0x0
db "segment .bss", 0x0
db "ptr resq 0x1", 0x0
db "index resq 0x1", 0x0
db "fd resq 0x1", 0x0
db "buf resq 0x1", 0x0
db "len resq 0x1", 0x0
db "loopCnt resq 0x1", 0x0
db "", 0x0
db "section .data", 0x0
db "SYS_exit equ 0x3c", 0x0
db "SYS_write equ 0x1", 0x0
db "SYS_creat equ 0x55", 0x0
db "SYS_close equ 0x3", 0x0
db "EXIT_SUCCESS equ 0x0", 0x0
db "EXIT_FAILURE equ 0x1", 0x0
db "ENDL db 0xa", 0x0
db "LINE_START db 'db ', 0x22, 0x0", 0x0
db "LINE_END db 0x22, ', 0x0', 0x0", 0x0
db "FILE_NAME db 'Grace_kid.s', 0x0", 0x0
db "OPEN_ERROR_STRING db 'error: could not open/create file', 0x0", 0x0
db "TXT_LINE_COUNT equ 0x8A", 0x0
db "txt:", 0x0
