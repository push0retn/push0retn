.286
.model		tiny
code		segment
org		100h
include		macro.mac

;The program display a chain of clusters by a given file. 
;File name input in program from keyboard.
;File name input format: name(8 bytes).extension(3 bytes)

start:

;read source directory from diskette

read_disk 1d, 0, 2d, 14d, dumpsource

;out on display input invite

print msg

;user input the filename

mov ah, 0Ah
mov dx, offset userin
int 21h

;divide userin array on file name and extension

mov si, offset userin+2
mov di, offset fname
mov cx, 8d

;write file name part in array

write_fname:

cmp byte ptr[si], '.'
jz skip_dot

movsb
loop write_fname

;write extension part in array

skip_dot:

inc si
add di, cx
mov cx, 3d
rep movsb

;translate letters in high register

mov si, offset fname
mov cx, 11d

in_high:

cmp byte ptr[si], 61h
jae low_letter
inc si

loop in_high
jmp search

low_letter:

sub byte ptr[si], 20h
inc si
loop in_high

;search file in source directory

search:

mov si, offset dumpsource
mov di, offset fname
add si, 32d

search_file:

mov cx, 11d

repe cmpsb		
jz file_find

add si, 32d
mov bx, 11d
sub bx, cx
sub si, bx
mov di, offset fname

jmp search_file

;file find, write first cluster of file in variable

file_find:

mov ax, word ptr[si+15]
mov firstcl, ax

;read the fat sector

read_disk 0, 0, 2d, 9d, dumpfat 

;search chain of clusters of file

print msg3
mov ax, firstcl
mov cx, 2d

search_chain:

push offset clusts+3
push ax
call ascii

push ax
print clusts
pop ax

mov bx, ax
shr bx, 1d
add ax, bx

mov si, offset dumpfat
add si, ax

mov ax, word ptr[si]
and ax, 0000111111111111b

cmp ax, 0FFFh
jz exit

loop search_chain

ror ax, 4d

cmp ax, 0FFFh
jz exit

cmp ax, 0
jz exit

cmp ah, 0FFh
jz exit

mov si, offset dumpfat
add si, ax
mov cx, 2d

jmp search_chain

exit:

outprog

;Hex in decimal ASCII proc.
;Parameters(stack):
;1. Offset of last byte in memory;
;2. Number.

ascii		proc	uses ax dx bp di

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

ascii		endp


dumpsource	db	7200d dup(0)		;dump of source directory
dumpfat		db	4608d dup(0)		;dump fat sector
userin		db	13d, 15d dup(24h)	;buffer for user input
fname		db	11d dup(20h), 0dh, 24h	;filename in fat12 format
firstcl		dw	0			;first cluster of file

;messages for user

msg		db	'Input filename and press ENTER', 0Ah, 0Dh
msg2		db	'(filename.extension)', 0Ah, 0Dh, 24h

;structure for out on display

msg3		db	0Ah, 'In clusters:', 0Dh, 0Ah, 24h
clusts		db	4d dup(0),9d, 24h

code		ends
end		start