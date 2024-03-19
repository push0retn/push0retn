.286
.model	tiny
code	segment
org	100h

;8. Задан массив из 40 слов. В каждом слове находятся два числа: одно в битах
;14, 13, 12, 11,10, второе в битах 8, 7, 6, 5, 4. Если бит 11 и бит 10 в первом числе
;совпадают с битами 5 и 4 второго числа, то числа поместить в два разных массива.

start:

mov si, offset array
mov di, offset newarray
mov bp, offset newarray2
mov cl, len

bits_op:

mov ax, word ptr[si]
and ax, 7DF0h
ror ax, 2d
ror al, 2d
push ax
and ax, 303h
cmp ah, al
je inarrays
pop ax
add si, 2d
loop bits_op
jmp exit

inarrays:

pop ax
mov byte ptr[di], ah
mov byte ptr[bp], al
inc di
inc bp
add si, 2d
loop bits_op

exit:

mov ax, 4c00h
int 21h

array		dw	64666d, 777d, 888d, 999d, 1000d, 1111d, 1222d, 1333d, 1444d, 1555d
		dw	757d, 13565d, 5352d, 2245d, 12341d, 62633d, 241d, 3553d, 2155d, 1445d
		dw	9393d, 53215d, 1355d, 2144d, 253d, 5153d, 3156d, 1535d, 12545d, 14d
		dw	21545d, 3156d, 3156d, 5613d, 541d, 541d, 566d, 214d, 521d, 54555d
len		equ	($-array)/2d	;count of array

newarray	db	40d dup(24h)
newarray2	db	40d dup(24h)

code	ends
end	start