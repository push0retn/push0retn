.286
.model	tiny
code	segment
org	100h

;9. Задано слово и массив из 16 чисел форматом слово. Каждому биту слова
;соответствует число из массива. Если бит в слове равен 1, то соответствующее слово из
;массива разделить на 10. Ненулевые остатки от деления поместить в новый массив и
;вывести на экран.

start:

mov si, offset array 
mov di, offset newarray
mov cl, len
mov bl, 10d

compare:

mov ax, num
shr ax, 1d
jc bit_eq_1
mov num, ax
add si, 2d
loop compare
jmp exit

bit_eq_1:

mov num, ax
mov ax, word ptr[si]
div bx
cmp dx, 0
jne inarray
add si, 2d
loop compare
jmp exit

inarray:

add dl, 30h
mov byte ptr[di], dl
mov byte ptr[di+1], 0Ah
mov byte ptr[di+2], 0Dh
add di, 3d
add si, 2d
xor dx, dx
loop compare

exit:

mov ah, 9d
mov dx, offset newarray
int 21h

mov ax, 4c00h
int 21h

num		dw	27931d
len		equ	16d	;count of bits in word
array		dw	65535d, 2142d, 5115d, 5166d, 333d, 13561d, 616d, 361d, 2151d
		dw	2151d, 155d, 1356d, 1366d, 13613d, 31d, 2145d
newarray	db	51d dup(24h)

code	ends
end	start