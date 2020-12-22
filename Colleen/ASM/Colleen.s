section .text
	global _start

_start:
	mov rdi, msg1
	call putendl
	mov rdi, msg2
	call putendl
	mov rdi, msg3
	call putendl
	mov rdi, msg4
	call putendl
	mov rdi, 32
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, 0
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, 1
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, 15
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, 16
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, 0xffffffffffffffff
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, test1
	call putendl
	movzx rdi, byte [_start+0x0]
	call gethex
	mov rdi, rax
	call putendl
	movzx rdi, byte [_start+0x1]
	call gethex
	mov rdi, rax
	call putendl
	movzx rdi, byte [_start+0x2]
	call gethex
	mov rdi, rax
	call putendl
	movzx rdi, byte [_start+0x3]
	call gethex
	mov rdi, rax
	call putendl
	mov rdi, test2
	call putendl
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall

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

;proc gethex - get hexadecimal representation of number
gethex:
	mov r10, 0x0
pushDigit:
	mov rax, rdi
	and rax, 0xf
	movzx r11, byte [hexdigits+rax]
	push r11
	inc r10
	shr rdi, 0x4
	cmp rdi, 0x0
	jne pushDigit
	mov rcx, r10
popDigit:
	pop rax
	mov r11, r10
	sub r11, rcx
	mov [hexbuf+r11+0x2], rax
	loop popDigit
	mov [hexbuf+r10+0x2], byte 0x0
	mov rax, hexbuf
	ret

section .data
SYS_exit equ 0x3c
SYS_write equ 0x1
EXIT_SUCCESS equ 0x0
msg1 db "firstMessage", 0x0
msg2 db "secondMessage", 0x0
msg3 db "YES WE DID IT", 0x0
msg4 db "	YES WE DID IT AGAIN 1234", 0x0
endl db 0xa
hexdigits db "0123456789abcdef"
hexbuf db "0x00000000000000000", 0x0
test1 db "read the first 4 bytes of the program:", 0x0
test2 db "this is the first part", 0xa
db "this should be just after", 0x0

segment .bss
fd resq 0x1
buf resq 0x1
len resq 0x1
