section .text
	global _start

_start:
	cmp qword [INTEGER], 0x0
	je end
	mov rdi, CURRENT_FILE_NAME
	mov rsi, FIRST_FILE_NAME
	call strcmp
	cmp rax, 0x0
	je getIntegerString
	dec qword [INTEGER]
getIntegerString:
	mov rdi, [INTEGER]
	call getdec
	mov rdi, rax
	call buildFileNames
	call createSourceFile
	call buildCommand
	call execCommand
end:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall

buildCommand:
	mov rdi, command
	mov rsi, COMPILE_COMMAND1
	call strcpy
	mov rsi, sourceName
	call strcat
	mov rsi, COMPILE_COMMAND2
	call strcat
	mov rsi, execName
	call strcat
	mov rsi, COMPILE_COMMAND3
	call strcat
	mov rsi, execName
	call strcat
	mov rsi, COMPILE_COMMAND4
	call strcat
	mov rsi, execName
	call strcat
	mov rsi, COMPILE_COMMAND5
	call strcat
	cmp qword [INTEGER], 0x0
	je returnCommand
	mov rsi, EXEC_COMMAND1
	call strcat
	mov rsi, execName
	call strcat
returnCommand:
	ret

execCommand:
addArgs:
	xor rax, rax
	push rax
	push command
	push SECOND_ARG
	push FIRST_ARG
	mov rdi, SHELL_PATH_NAME
	mov rsi, rsp
	xor rdx, rdx
execve:
	mov rax, SYS_execve
	syscall
	mov rdi, EXEC_ERROR_STRING
	mov qword [fd], 0x2
	call putendl
	mov rax, SYS_exit
	mov rdi, EXIT_FAILURE
	syscall
	ret

createSourceFile:
	mov rdi, sourceName
	call openOutputFile
	mov [fd], rax
	mov rdi, txt
	mov rsi, TXT_LINE_COUNT
	call printRawText
	mov rdi, txt
	mov rsi, TXT_LINE_COUNT
	call printQuotedText
	mov rdi, INTEGER_DECL
	call putstr
	mov rdi, decbuf
	call putendl
	call closeOutputFile
	ret

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

strcmp:
	mov rbx, 0xffffffffffffffff
whileEqualAndNotZero:
	inc rbx
	mov r10b, byte [rdi+rbx]
	mov r11b, byte [rsi+rbx]
	mov al, r10b
	sub al, r11b
	cmp r10b, 0x0
	je returnDiff
	cmp r11b, 0x0
	je returnDiff
	cmp al, 0x0
	je whileEqualAndNotZero
returnDiff:
	ret

segment .bss
ptr resq 0x1
index resq 0x1
fd resq 0x1
buf resq 0x1
len resq 0x1
loopCnt resq 0x1
decbuf resb 0x20
execName resb 0x30
sourceName resb 0x30
command resb 0x108

section .data
CURRENT_FILE_NAME db __FILE__, 0x0
FIRST_FILE_NAME db 'Sully.s', 0x0
FILE_RADIX db 'Sully_', 0x0
FILE_SUFFIX db '.s', 0x0
SYS_exit equ 0x3c
SYS_write equ 0x1
SYS_creat equ 0x55
SYS_close equ 0x3
SYS_execve equ 0x3b
SHELL_PATH_NAME db '/bin/sh', 0x0
SECOND_ARG db '-c', 0x0
FIRST_ARG db 'sh', 0x0
COMPILE_COMMAND1 db 'yasm -f elf64 ', 0x0
COMPILE_COMMAND2 db ' && ld -m elf_x86_64 -s -o ', 0x0
COMPILE_COMMAND3 db ' ', 0x0
COMPILE_COMMAND4 db '.o && rm -f ', 0x0
COMPILE_COMMAND5 db '.o', 0x0
EXEC_COMMAND1 db ' && ./', 0x0
EXIT_SUCCESS equ 0x0
EXIT_FAILURE equ 0x1
ENDL db 0xa
LINE_START db 'db ', 0x22, 0x0
LINE_END db 0x22, ', 0x0', 0x0
OPEN_ERROR_STRING db 'error: could not open/create file', 0x0
EXEC_ERROR_STRING db 'error: could not execute script', 0x0
INTEGER_DECL db 'INTEGER dq ', 0x0
TXT_LINE_COUNT equ 0x12C
txt:
db "section .text", 0x0
db "	global _start", 0x0
db "", 0x0
db "_start:", 0x0
db "	cmp qword [INTEGER], 0x0", 0x0
db "	je end", 0x0
db "	mov rdi, CURRENT_FILE_NAME", 0x0
db "	mov rsi, FIRST_FILE_NAME", 0x0
db "	call strcmp", 0x0
db "	cmp rax, 0x0", 0x0
db "	je getIntegerString", 0x0
db "	dec qword [INTEGER]", 0x0
db "getIntegerString:", 0x0
db "	mov rdi, [INTEGER]", 0x0
db "	call getdec", 0x0
db "	mov rdi, rax", 0x0
db "	call buildFileNames", 0x0
db "	call createSourceFile", 0x0
db "	call buildCommand", 0x0
db "	call execCommand", 0x0
db "end:", 0x0
db "	mov rax, SYS_exit", 0x0
db "	mov rdi, EXIT_SUCCESS", 0x0
db "	syscall", 0x0
db "", 0x0
db "buildCommand:", 0x0
db "	mov rdi, command", 0x0
db "	mov rsi, COMPILE_COMMAND1", 0x0
db "	call strcpy", 0x0
db "	mov rsi, sourceName", 0x0
db "	call strcat", 0x0
db "	mov rsi, COMPILE_COMMAND2", 0x0
db "	call strcat", 0x0
db "	mov rsi, execName", 0x0
db "	call strcat", 0x0
db "	mov rsi, COMPILE_COMMAND3", 0x0
db "	call strcat", 0x0
db "	mov rsi, execName", 0x0
db "	call strcat", 0x0
db "	mov rsi, COMPILE_COMMAND4", 0x0
db "	call strcat", 0x0
db "	mov rsi, execName", 0x0
db "	call strcat", 0x0
db "	mov rsi, COMPILE_COMMAND5", 0x0
db "	call strcat", 0x0
db "	cmp qword [INTEGER], 0x0", 0x0
db "	je returnCommand", 0x0
db "	mov rsi, EXEC_COMMAND1", 0x0
db "	call strcat", 0x0
db "	mov rsi, execName", 0x0
db "	call strcat", 0x0
db "returnCommand:", 0x0
db "	ret", 0x0
db "", 0x0
db "execCommand:", 0x0
db "addArgs:", 0x0
db "	xor rax, rax", 0x0
db "	push rax", 0x0
db "	push command", 0x0
db "	push SECOND_ARG", 0x0
db "	push FIRST_ARG", 0x0
db "	mov rdi, SHELL_PATH_NAME", 0x0
db "	mov rsi, rsp", 0x0
db "	xor rdx, rdx", 0x0
db "execve:", 0x0
db "	mov rax, SYS_execve", 0x0
db "	syscall", 0x0
db "	mov rdi, EXEC_ERROR_STRING", 0x0
db "	mov qword [fd], 0x2", 0x0
db "	call putendl", 0x0
db "	mov rax, SYS_exit", 0x0
db "	mov rdi, EXIT_FAILURE", 0x0
db "	syscall", 0x0
db "	ret", 0x0
db "", 0x0
db "createSourceFile:", 0x0
db "	mov rdi, sourceName", 0x0
db "	call openOutputFile", 0x0
db "	mov [fd], rax", 0x0
db "	mov rdi, txt", 0x0
db "	mov rsi, TXT_LINE_COUNT", 0x0
db "	call printRawText", 0x0
db "	mov rdi, txt", 0x0
db "	mov rsi, TXT_LINE_COUNT", 0x0
db "	call printQuotedText", 0x0
db "	mov rdi, INTEGER_DECL", 0x0
db "	call putstr", 0x0
db "	mov rdi, decbuf", 0x0
db "	call putendl", 0x0
db "	call closeOutputFile", 0x0
db "	ret", 0x0
db "", 0x0
db "buildFileNames:", 0x0
db "	mov r11, rdi", 0x0
db "buildExecName:", 0x0
db "	mov rdi, execName", 0x0
db "	mov rsi, FILE_RADIX", 0x0
db "	call strcpy", 0x0
db "	mov rsi, r11", 0x0
db "	call strcat", 0x0
db "buildSourceName:", 0x0
db "	mov rdi, sourceName", 0x0
db "	mov rsi, execName", 0x0
db "	call strcpy", 0x0
db "	mov rsi, FILE_SUFFIX", 0x0
db "	call strcat", 0x0
db "	ret", 0x0
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
db "getdec:", 0x0
db "	mov r10, 0x0", 0x0
db "	mov rdx, 0x0", 0x0
db "	mov rax, rdi", 0x0
db "pushDigit:", 0x0
db "	mov rbx, 10", 0x0
db "	cqo", 0x0
db "	xor rdx, rdx", 0x0
db "	div rbx", 0x0
db "	mov r11, rdx", 0x0
db "	add r11, '0'", 0x0
db "	push r11", 0x0
db "	inc r10", 0x0
db "	cmp rax, 0", 0x0
db "	jne pushDigit", 0x0
db "	mov rcx, r10", 0x0
db "popDigit:", 0x0
db "	pop rax", 0x0
db "	mov r11, r10", 0x0
db "	sub r11, rcx", 0x0
db "	mov [decbuf+r11], rax", 0x0
db "	loop popDigit", 0x0
db "	mov [decbuf+r10], byte 0x0", 0x0
db "	mov rax, decbuf", 0x0
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
db "strcpy:", 0x0
db "	mov rax, 0xffffffffffffffff", 0x0
db "whileChars:", 0x0
db "	inc rax", 0x0
db "	mov r10b, byte [rsi+rax]", 0x0
db "	mov byte [rdi+rax], r10b", 0x0
db "	cmp r10b, 0x0", 0x0
db "	jne whileChars", 0x0
db "	mov rax, rdi", 0x0
db "	ret", 0x0
db "", 0x0
db "strcat:", 0x0
db "	call strlen", 0x0
db "	mov rbx, rdi", 0x0
db "	add rdi, rax", 0x0
db "	call strcpy", 0x0
db "	mov rax, rbx", 0x0
db "	ret", 0x0
db "", 0x0
db "strcmp:", 0x0
db "	mov rbx, 0xffffffffffffffff", 0x0
db "whileEqualAndNotZero:", 0x0
db "	inc rbx", 0x0
db "	mov r10b, byte [rdi+rbx]", 0x0
db "	mov r11b, byte [rsi+rbx]", 0x0
db "	mov al, r10b", 0x0
db "	sub al, r11b", 0x0
db "	cmp r10b, 0x0", 0x0
db "	je returnDiff", 0x0
db "	cmp r11b, 0x0", 0x0
db "	je returnDiff", 0x0
db "	cmp al, 0x0", 0x0
db "	je whileEqualAndNotZero", 0x0
db "returnDiff:", 0x0
db "	ret", 0x0
db "", 0x0
db "segment .bss", 0x0
db "ptr resq 0x1", 0x0
db "index resq 0x1", 0x0
db "fd resq 0x1", 0x0
db "buf resq 0x1", 0x0
db "len resq 0x1", 0x0
db "loopCnt resq 0x1", 0x0
db "decbuf resb 0x20", 0x0
db "execName resb 0x30", 0x0
db "sourceName resb 0x30", 0x0
db "command resb 0x108", 0x0
db "", 0x0
db "section .data", 0x0
db "CURRENT_FILE_NAME db __FILE__, 0x0", 0x0
db "FIRST_FILE_NAME db 'Sully.s', 0x0", 0x0
db "FILE_RADIX db 'Sully_', 0x0", 0x0
db "FILE_SUFFIX db '.s', 0x0", 0x0
db "SYS_exit equ 0x3c", 0x0
db "SYS_write equ 0x1", 0x0
db "SYS_creat equ 0x55", 0x0
db "SYS_close equ 0x3", 0x0
db "SYS_execve equ 0x3b", 0x0
db "SHELL_PATH_NAME db '/bin/sh', 0x0", 0x0
db "SECOND_ARG db '-c', 0x0", 0x0
db "FIRST_ARG db 'sh', 0x0", 0x0
db "COMPILE_COMMAND1 db 'yasm -f elf64 ', 0x0", 0x0
db "COMPILE_COMMAND2 db ' && ld -m elf_x86_64 -s -o ', 0x0", 0x0
db "COMPILE_COMMAND3 db ' ', 0x0", 0x0
db "COMPILE_COMMAND4 db '.o && rm -f ', 0x0", 0x0
db "COMPILE_COMMAND5 db '.o', 0x0", 0x0
db "EXEC_COMMAND1 db ' && ./', 0x0", 0x0
db "EXIT_SUCCESS equ 0x0", 0x0
db "EXIT_FAILURE equ 0x1", 0x0
db "ENDL db 0xa", 0x0
db "LINE_START db 'db ', 0x22, 0x0", 0x0
db "LINE_END db 0x22, ', 0x0', 0x0", 0x0
db "OPEN_ERROR_STRING db 'error: could not open/create file', 0x0", 0x0
db "EXEC_ERROR_STRING db 'error: could not execute script', 0x0", 0x0
db "INTEGER_DECL db 'INTEGER dq ', 0x0", 0x0
db "TXT_LINE_COUNT equ 0x12C", 0x0
db "txt:", 0x0
INTEGER dq 5
