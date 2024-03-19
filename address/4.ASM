.286
.model	tiny
code	segment
org	100h

;4. Задан массив из 40 слов. В каждом слове находятся два числа: одно в битах
;12, 11, 10, 9, 8, второе в битах 7, 6, 5, 4, 3, 2. Если бит 9 и бит 8 в первом числе
;совпадают с битами 3 и 2 второго числа, то поместить первое число в новый массив.

start:

mov si, offset array
mov di, offset newarray
mov cl, len

bits_operations:

mov ax, word ptr[si]
and ax, 1FFCh
ror al, 2d
push ax
and ax, 303h
cmp ah, al
je innewarray
pop ax
add si, 2d
loop bits_operations
jmp exit

innewarray:

pop ax
mov byte ptr[di], ah
inc di
add si, 2d
loop bits_operations

exit:

mov ax, 4c00h
int 21h

array		dw	8585d, 24444d, 21455d, 56644d, 21545d, 35212d, 23516d, 555d
		dw	2545d, 154d, 677d, 21454d, 3156d, 823d, 3156d, 6266d, 1355d
		dw	21545d, 6723d, 2155d, 31556d, 7323d, 5156d, 326d, 13566d
		dw	3616d, 3166d, 7353d, 6216d, 3525d, 1355d, 1551d, 51156d
		dw	6161d, 31566d, 136d, 1636d, 1366d, 787d, 3333d
len		equ	($-array)/2d	;count of array
newarray	db	40d dup(24h)

code	ends
end	start