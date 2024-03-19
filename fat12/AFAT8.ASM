.286
.model		tiny
include		macro.mac
code		segment
org		100h

;Display list of files in root directory and numbers our first clusters.

start:

;read root directory

read_disk 1d, 0, 2d, 14d, root_dir

;write file name and extension in variables

mov si, offset root_dir
mov di, offset fname
add si, 32d

search_files:

cmp byte ptr[si], 0
jz exit

cmp si, 0E5h
jnz write_name

add si, 32d
jmp search_files

write_name:

mov cx, 11d
rep movsb

;write number of first cluster

write_cluster:

add di, 19d
mov ax, word ptr[si+15]

push di
push ax
call hex_ascii

;Display file

print fname

add si, 21d
mov di, offset fname

jmp search_files
			
exit:

outprog

;Hex in decimal ASCII procedure.
;Parameters(stack):
;1. Offset last byte in memory.
;2. Number.
;Out:
;Number in ASCII code in memory.

hex_ascii	proc	uses ax dx bp di

mov bp, sp
mov ax, word ptr es:[bp+10]
mov di, word ptr es:[bp+12]
mov bx, 0Ah
xor dx, dx

in_ascii:

cmp ax, 0
jz exitp

div bx
add dl, 30h
mov byte ptr[di], dl
dec di
xor dl, dl
jmp in_ascii

exitp:

ret 4

hex_ascii	endp

root_dir	db	7200d dup(0)

fname		db	8d dup(20h)
ext		db	3d dup(20h)
msg		db	9d, 'First cluster:', 9d
firstcl		db	4d dup(0), 0Ah, 0Dh, 24h

code		ends
end		start