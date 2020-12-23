section .data
lpCnt dq 16
sum dq 0
SYS_exit equ 60

section .text
global _start

_start:
	mov rcx, [lpCnt]
	mov rax, 0
loopStart:
	add [sum], rax
	add rax, 2
	dec rcx
	cmp rcx, 0
	jne loopStart
afterLoop:
	mov rax, [sum]
last:
	mov rax, SYS_exit
	mov rdi, [sum] ;return sum to show it (printing is hard...)
	syscall
