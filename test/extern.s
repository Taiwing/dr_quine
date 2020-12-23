	global main
	extern puts

section .text
main:
	mov rdi, string
	call puts
	ret
string:
	db 'Yoyoyo', 0x0
