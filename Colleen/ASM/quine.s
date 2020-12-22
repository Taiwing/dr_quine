section .text
	global _start

_start:
	mov rdi, txt
	mov rsi, TXT_LINE_COUNT
	call printRawText
	mov rdi, txt
	mov rsi, TXT_LINE_COUNT
	call printQuotedText
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall

;proc printRawText - write Raw code to stdout
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

;proc printQuotedText - write formated code to stdout
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

;proc write - write buf of len to fd
write:
	mov rax, SYS_write
	mov rdi, [fd]
	mov rsi, [buf]
	mov rdx, [len]
	syscall
	ret

;proc strlen - get length of string
strlen:
	mov rax, 0xffffffffffffffff
whileNotZero:
	inc rax
	movzx r10, byte [rdi+rax]
	cmp r10, 0x0
	jne whileNotZero
	ret

;proc putstr - print string
putstr:
	call strlen
	mov byte [fd], 0x1
	mov [buf], rdi
	mov [len], rax
	call write
	ret

;proc putendl - print string with a new line at the end
putendl:
	call putstr
	mov byte [fd], 0x1
	mov qword [buf], endl
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
EXIT_SUCCESS equ 0x0
endl db 0xa
LINE_START db 'db ', 0x22, 0x0
LINE_END db 0x22, ', 0x0', 0x0
