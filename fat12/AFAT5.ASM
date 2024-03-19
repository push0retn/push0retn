.286
.model		tiny
code		segment
include		macro.mac
org		100h

;Find the largest file in the root directory and displays
;its name and size in kilobytes.

start:

;read source directory in array

read_disk 1d, 0, 2d, 14d, source_dir

;search largest file

mov si, offset source_dir
add si, 32d
mov di, offset bigfile
mov bp, offset sizefile

mov cx, 11d
rep movsb

;write first file name and file size

mov ax, word ptr[si+16]
mov word ptr[bp], ax
mov ax, word ptr[si+18]
mov word ptr[bp+2], ax

search_largest:

add si, 21d

cmp byte ptr[si], 0
jz out_size

cmp byte ptr[si], 0E5h
jz below

mov ax, word ptr[bp]

cmp ax, word ptr[si+28]
jb largest

cmp ax, word ptr[si+28]
jnz below

mov ax, word ptr[bp+2]

cmp ax, word ptr[si+30]
jb largest

jmp search_largest

largest:

mov di, offset bigfile
mov cx, 11d
rep movsb

mov ax, word ptr[si+16]
mov word ptr[bp], ax
mov ax, word ptr[si+18]
mov word ptr[bp], ax

jmp search_largest

below:

add si, 11d
jmp search_largest

out_size:

;out on display 2 part of size

mov ax, word ptr[bp+2]

shr ax, 10d
push offset msg+18
push ax
call hex_ascii

mov ax, word ptr[bp]

shr ax, 10d
push di
push ax
call hex_ascii

exit:

print bigfile
print msg

outprog

;Hex in decimal ASCII procedure.
;Parameters(stack):
;1. Offset of last byte in memory.
;2. Number.

hex_ascii	proc	uses bp ax dx

mov bp, sp
mov ax, word ptr es:[bp+8]
mov di, word ptr es:[bp+10]
mov bx, 0Ah
xor dx, dx

in_ascii:

cmp ax, 0
je exitp

div bx
add dl, 30h
mov byte ptr[di], dl
dec di
xor dl, dl
jmp in_ascii

exitp:

ret 4

hex_ascii	endp

source_dir	db	7200d dup(0)		;source directory
bigfile		db	11d dup(20h), 24h	;biggest file
sizefile	dd	0			;size of biggest file

msg		db	0Ah, 0Dh, 'File size:', 9d, 6d dup(0), ' kb', 24h

code		ends
end		start