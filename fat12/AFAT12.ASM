.286
.model		tiny
include		macro.mac
code		segment
org		100h

;Find the "oldest" file in the root directory and display her name 
;and creation date.

start:

;read the root directory in array

read_disk 1d, 0, 2d, 14d, root_dir

mov si, offset root_dir
add si, 56d			;offset on creation date

mov ax, word ptr[si]

search_old:

add si, 32d

cmp byte ptr[si], 0
jz display

cmp byte ptr[si-24], 0E5h
jz search_old

cmp ax, word ptr[si]
ja it_oldest

jmp search_old

it_oldest:

;write creation date in variable

mov ax, word ptr[si]
mov date, ax

;write file name and extension in variables

sub si, 24d			
mov di, offset fname	
mov cx, 8d			
rep movsb			;write file name

mov cx, 3d
inc di
rep movsb			;write extension

add si, 13d

jmp search_old

;allocate day, month, year

display:

mov ax, date
mov bx, ax
mov dx, bx

and ax, 1111111000000000b
ror ax, 9d 			
add ax, 1980d			;year

and bx, 0000000111100000b	
ror bx, 5d			;month

and dx, 0000000000011111b	;day

push offset year+3
push ax
call ascii

push offset month+1
push bx
call ascii

push offset day+1
push dx
call ascii

print fname

outprog

;Hex in decimal ASCII procedure.
;Parameters:
;1. Offset
;2. Number
;Out:
;decimal ASCII code in memory

ascii		proc	uses ax dx bp bx di

mov bp, sp
mov ax, word ptr ss:[bp+12]
mov di, word ptr ss:[bp+14]
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

ascii		endp

root_dir	db	7200d dup(0)

fname		db	8d dup(20h), 9d
ext		db	3d dup(0), 9d
day		db	'00', '.'
month		db	'00', '.'
year		db	'    '
return		db	0Ah, 0Dh, 24h

date		dw	0

code		ends
end		start