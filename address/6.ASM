.286
.model	tiny
code	segment
org	100h

;Задана таблица:
;TABL 	DB 0, 2, 4, 9, 0, 12, 8
;		DB 5, 12, 7, 0, 8, 0, 5
;		DB 0, 5, 14, 6, 15, 9, 0
;		DB 13, 5, 18, 45, 3, 9, 11
;Подсчитать количество нулей в каждой строке и запомнить их в массив.
;Заменить нули на число FFH. Выведите количество нулей в каждой строке на экран.
;Если нулей в строке не обнаружено, то вывести на экран символ ?.

start:

mov si, offset TABL
mov cl, strs

search_nulls:

push cx
mov cl, col

search:

mov al, byte ptr[si]
cmp al, 0
je addnull
inc si
loop search
jmp compare

addnull:

mov byte ptr[si], 0FFh
inc dl
inc si
loop search

compare:

cmp dl, 0d
jne ondisp
mov ah, 2d
mov dl, '?'
int 21h
mov dl, 0dh
int 21h
mov dl, 0ah
int 21h
xor dx, dx
pop cx
loop search_nulls
jmp exit

ondisp:

mov ah, 2d
add dl, 30h
int 21h
mov dl, 0Dh
int 21h
mov dl, 0Ah
int 21h
xor dx, dx
pop cx
loop search_nulls

exit:

mov ax, 4c00h
int 21h

TABL	db	0, 2d, 4d, 9d, 0, 12d, 8d
	db	5d, 12d, 7d, 0, 8d, 0, 5d
	db	0, 5d, 14d, 6d, 15d, 9d, 0
	db	13d, 5d, 18d, 45d, 3d, 9d, 11d
strs	equ	4d	;count of strings
col	equ	7d	;collumns of matrix

code	ends
end	start