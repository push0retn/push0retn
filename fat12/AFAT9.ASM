.286
.model		tiny
include		macro.mac
code		segment
org		100h

;Program display list of files (without directories) of root directory,
;mark for files hide or open. If press C key hidden files opened and
;opened files hide on the disk.

start:

;read root directory from disk

read_disk 1d, 0, 2d, 14d, root_dir

;search files and display 

mov si, offset root_dir
add si, 32d
mov di, offset fname
mov bp, offset attr+1

;Compare attributes files

view_attr:

cmp byte ptr[si], 0
jz wait_key

cmp byte ptr[si], 0E5h
jz dir

cmp byte ptr[si+11], 10h
jz dir

cmp byte ptr[si+11], 20h
jz attr_A

cmp byte ptr[si+11], 3d
jz hide

cmp byte ptr[si+11], 7d
jz hide

;skip directory or file

dir:

add si, 32d
jmp view_attr

;Not archived file for attribute A
 
attr_A:

mov byte ptr[bp], 'A'

mov cx, 8d
rep movsb

inc di

mov cx, 3d
rep movsb

sub si, 11d
sub di, 12d

print fname

add si, 32d
jmp view_attr

;Hide file for attribute H

hide:

mov byte ptr[bp], 'H'

mov cx, 8d
rep movsb

inc di

mov cx, 3d
rep movsb

sub si, 11d
sub di, 12d

print fname

add si, 32d
jmp view_attr

;Wait press key

wait_key:

print msg

mov ah, 1d
int 21h

mov bl, al

print return

mov al,bl

cmp al, 78h
jz exit

cmp al, 63h
jz change_attributes

jmp wait_key

;Change attribute A on H and attribute H on A

change_attributes:

mov si, offset root_dir
add si, 32d

change:

cmp byte ptr[si], 0E5h
jz skip_file

cmp byte ptr[si], 0
jz write_diskette

cmp byte ptr[si+11], 3d
jz change_H

cmp byte ptr[si+11], 7d
jz change_H

cmp byte ptr[si+11], 20h
jz change_A

;skip file

skip_file:

add si, 32d
jmp change

;Change attribute H on A

change_H:

mov byte ptr[si+11], 20h
add si, 32d
jmp change

;Change attribute A on H

change_A:

mov byte ptr[si+11], 7d
add si, 32d
jmp change

;Write changes on diskette

write_diskette:

write_disk 1d, 0, 2d, 14d, root_dir
jmp start

exit:

outprog

root_dir	db	7200d dup(0)

fname		db	8d dup(20h), 9d
ext		db	3d dup(0)
attr		db	9d, 0, 0Ah, 0Dh, 24h

msg		db	'Press X for exit', 0Ah, 0Dh
		db	'Press C for change H and A attributes of files'
return		db	0Ah, 0Dh, 24h

code		ends
end		start