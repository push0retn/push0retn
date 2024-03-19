.286
.model		tiny
code		segment
include		macro.mac
org		100h

;Search file in root directory and displays the number of its initial cluster.
;File name input from the keyboard.

start:

;read root directory in array

read_disk 1d, 0, 2d, 14d, root_dir

print msg

;user input file name and extension

mov ah, 0Ah
mov dx, offset userin
int 21h

;allocate file name and extension

mov si, offset userin+2
mov di, offset fname
mov cx, 8d

write_fname:

cmp byte ptr[si], '.'
jz write_ext
movsb
loop write_fname

write_ext:

inc si
add di, cx
mov cx, 3d
rep movsb

;search file in root directory

mov si, offset root_dir
mov di, offset fname
add si, 32d

search_file:

mov cx, 11d
repe cmpsb

cmp cx, 0
jz file_find

sub si, cx
add si, 32d

jmp search_file

;find first cluster 

file_find:

add si, 14d
mov al, byte ptr[si]
xor ah, ah

push offset msg2+28
push ax
call hex_ascii

print msg2

mov ax, 4c00h
int 21h

hex_ascii	proc	uses bp ax dx bx

mov bp, sp
mov ax, word ptr[bp+10]
mov di, word ptr[bp+12]
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

root_dir	db	7200d dup(0)		;root directory
userin		db	12d, 13d dup(0)		;array for user input
fname		db	11d dup(0)		;file name
firstcl		db	0

;messages for user

msg		db	'Input filename and extension(name.extension)', 0Ah, 0Dh, 24h
msg2		db	0Ah, 0Dh,'First cluster of file:     ', 24h

code		ends
end		start