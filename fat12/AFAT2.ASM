.286
.model	tiny
code	segment
org	100h
include	macro.mac

;Analyze the disk and displays the total number of files in the root 
;directory, the number of system files, the number of hidden files,
;the number of read-only files and the number of subdirectories.

start:

;read source directory in array

read_disk 1d, 0, 2d, 14d, source_dir

;search file attributes

mov si, offset source_dir
add si, 43d			;si on attributes

read_attr:

mov al, byte ptr[si]		;attributes in al

cmp byte ptr[si-11], 0E5h
jz next_file

cmp al, 0			;compare have or not file 
jz on_display

cmp al, 7d			;compare with system file attributes
jz sys_file

cmp al, 10h			;compare directory or not
jz directory

cmp al, 21h			;compare read only file or not			
jz readonly

cmp al, 22h			;compare hide file or not
jz hidden

cmp al, 20h			;compare with simply file
jz file

inc totalf

next_file:

add si, 32d
jmp read_attr

sys_file:

inc sysfile
inc totalf
add si, 32d
jmp read_attr

directory:

inc subdir
inc totalf
add si, 32d
jmp read_attr

readonly:

inc read_onlyf
inc totalf
add si, 32d
jmp read_attr

hidden:

inc hiddenf
inc totalf
add si, 32d
jmp read_attr

file:

inc totalf
add si, 32d
jmp read_attr

on_display:

xor ax, ax
mov si, offset totalf
mov al, byte ptr[si]
mov byte ptr[si], 0
add si, 2d

push si
push ax
call hex_ascii

mov si, offset hiddenf
mov al, byte ptr[si]
mov byte ptr[si], 0
add si, 2d

push si
push ax
call hex_ascii

mov si, offset read_onlyf
mov al, byte ptr[si]
mov byte ptr[si], 0
add si, 2d

push si
push ax
call hex_ascii

mov si, offset subdir
mov al, byte ptr[si]
mov byte ptr[si], 0
add si, 2d

push si
push ax
call hex_ascii

mov si, offset sysfile
mov al, byte ptr[si]
mov byte ptr[si], 0
add si, 2d

push si
push ax
call hex_ascii

mov ah, 9d
mov dx, offset msg1
int 21h

outprog				;terminate program

;Hex in decimal ASCII procedure.
;Parameters(stack):
;1. Offset of last byte in memory;
;2. Number.

hex_ascii	proc	uses ax dx bp di

mov bp, sp
mov ax, word ptr es:[bp+10]
mov di, word ptr es:[bp+12]
mov bx, 0Ah
xor dx, dx

in_ascii:

cmp ax, 0
je exitp

div bx
add dl, 30h
mov byte ptr es:[di], dl
dec di
xor dl, dl
jmp in_ascii

exitp:

ret 4

hex_ascii	endp

source_dir	db	7200d dup(0)				;diskette dump

msg1		db	'Total files: ', 9d, 9d
totalf		db	0, 0, 30h				;total files
msg2		db	0Ah, 0Dh, 'Hidden files:', 9d, 9d	
hiddenf		db	0, 0, 30h				;hidden files
msg3		db	0Ah, 0Dh, 'Read only files:', 9d
read_onlyf	db	0, 0, 30h				;read only files
msg4		db	0Ah, 0Dh, 'Directories:', 9d, 9d
subdir		db	0, 0, 30h				;subdirectory
msg5		db	0Ah, 0Dh, 'System files:', 9d, 9d 
sysfile		db	0, 0, 30h, 7d, 24h			;system file

code	ends
end	start