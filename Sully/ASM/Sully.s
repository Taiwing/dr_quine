;mandatory single comment ;)

section .text
	global _start

;_start:
;	mov rdi, FILE_NAME
	call openOutputFile
	mov [fd], rax
;	mov rdi, txt
;	mov rsi, TXT_LINE_COUNT
	call printRawText
;	mov rdi, txt
;	mov rsi, TXT_LINE_COUNT
	call printQuotedText
	call closeOutputFile
_start: ;TEMP
	cmp qword [INTEGER], 0x0
	je end
	cmp qword [START], 0x0
	je getIntegerString
	dec qword [INTEGER]
getIntegerString:
	mov rdi, [INTEGER]
	call getdec
	mov rdi, rax
	call buildFileNames
	mov rdi, execName
	call putendl
	mov rdi, sourceName
	call putendl
end:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall

buildFileNames:
	mov r11, rdi
buildExecName:
	mov rdi, execName
	mov rsi, FILE_RADIX
	call strcpy
	mov rsi, r11
	call strcat
buildSourceName:
	mov rdi, sourceName
	mov rsi, execName
	call strcpy
	mov rsi, FILE_SUFFIX
	call strcat
	ret

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

getdec:
	mov r10, 0x0
	mov rdx, 0x0
	mov rax, rdi
pushDigit:
	mov rbx, 10
	cqo
	xor rdx, rdx
	div rbx
	mov r11, rdx
	add r11, '0'
	push r11
	inc r10
	cmp rax, 0
	jne pushDigit
	mov rcx, r10
popDigit:
	pop rax
	mov r11, r10
	sub r11, rcx
	mov [decbuf+r11], rax
	loop popDigit
	mov [decbuf+r10], byte 0x0
	mov rax, decbuf
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

strcpy:
	mov rax, 0xffffffffffffffff
whileChars:
	inc rax
	mov r10b, byte [rsi+rax]
	mov byte [rdi+rax], r10b
	cmp r10b, 0x0
	jne whileChars
	mov rax, rdi
	ret

strcat:
	call strlen
	mov rbx, rdi
	add rdi, rax
	call strcpy
	mov rax, rbx
	ret

segment .bss
ptr resq 0x1
index resq 0x1
fd resq 0x1
buf resq 0x1
len resq 0x1
loopCnt resq 0x1
decbuf resb 0x20
dest resq 0x1
src resq 0x1
execName resb 0x30
sourceName resb 0x30

section .data
FILE_RADIX db 'Sully_', 0x0
FILE_SUFFIX db '.s', 0x0
SYS_exit equ 0x3c
SYS_write equ 0x1
SYS_creat equ 0x55
SYS_close equ 0x3
EXIT_SUCCESS equ 0x0
EXIT_FAILURE equ 0x1
ENDL db 0xa
LINE_START db 'db ', 0x22, 0x0
LINE_END db 0x22, ', 0x0', 0x0
OPEN_ERROR_STRING db 'error: could not open/create file', 0x0
START dq 0x0
INTEGER dq 5
