.286
.model	tiny
code	segment
org	100h

;Задана таблица:
;TAB 	DB 5, 2, 0, 9, 11, 16, 7
;		DB 5, 12, 7, 0, 8, 0, 9
;		DB 5, 0, 14, 6, 15, 9, 31
;		DB 13, 5, 18, 45, 3, 9, 45
;
;Числа больше 10 заменить на 9. Вывести на экран количество таких чисел в
;каждой строке и запомнить их в новый массив

start:

mov si, offset TAB
mov di, offset array
mov cl, strs
mov ah, 2d	;for int 21

search:

push cx
mov cl, cols

begin:

cmp byte ptr[si], 10d
ja above10
inc si
loop begin
jmp newstr

above10:

inc dl
mov al, byte ptr[si]
mov byte ptr[di], al
inc di
inc si
loop begin

newstr:

add dl, 30h
int 21h
mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h
xor dx, dx
pop cx
loop search

mov ax, 4c00h
int 21h

TAB	db	5d, 2d, 0, 9d, 11d, 16d, 7d
	db	5d, 12d, 7d, 0, 8d, 0, 9d
	db	5d, 0, 14d, 6d, 15d, 9d, 31d
	db	13d, 5d, 18d, 45d, 3d, 9d, 45d
strs	equ	4d	;count of strings in matrix
cols	equ	7d	;count of collumns in matrix
array	db	28 dup(24h)
	
code	ends
end	start