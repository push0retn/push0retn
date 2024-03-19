.286
.model	tiny
code	segment
org	100h

;7. Задан массив из 50 байтов. Первый байт содержит следующую информацию:
;биты 7, 6, 5, 4, 3 содержат число, означающее реальное количество элементов массива,
;которое необходимо обработать, во втором байте: биты 7, 6, 5 - константу С1, биты 4,
;3, 2, 1, 0 - константу С2. Если числа массива (начиная с третьего) больше 230,
;умножить его на С1, иначе на С2. Все произведения (слова!) поместить в новый массив.

start:

mov si, offset array+2
mov di, offset newarray

;write constants and count elements of array

mov cl, byte ptr[si-2]
mov al, byte ptr[si-1] 
shr cl, 3d
and al, 0EFh
rol ax, 3d
ror al, 3d
mov c1, ah
mov c2, al
xor ax, ax

;pass through the array

search:

mov al, byte ptr[si]
cmp al, 230d
ja mulc2
mov bl, c1
mul bl
mov word ptr[di], ax
xor ax, ax
add di, 2d
inc si
loop search
jmp exit

mulc2:

mov bl, c2
mul bl
mov word ptr[di], ax
add di, 2d
inc si
loop search

exit:

mov ax, 4C00h
int 21h

array		db	94d, 241d, 33d, 51d, 244d, 54d, 12d, 35d ,246d, 66d 
		db	77d, 42d, 254d, 45d, 215d, 64d, 11d, 34d, 35d, 11d
		db	43d, 54d, 64d, 14d, 231d, 12d, 123d, 215d, 77d, 88d
		db	99d, 111d, 222d, 234d, 123d, 132d, 231, 213d, 122d, 212d
		db	11d, 22d, 33d, 44d, 55d, 66d, 22d, 33d, 12d, 13d

C1		db	?
C2		db	?
newarray	dw	47d dup(24h)

code	ends
end	start