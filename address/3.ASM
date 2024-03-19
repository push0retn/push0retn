.286
.model	tiny
code	segment
org	100h

;3. Задан массив из 30 слов. В каждом слове находятся два числа: одно в битах
;14, 13, 12, 11, 10, второе в битах 8, 7, 6, 5, 4, 3. Если бит 14 и бит 13 в первом числе
;совпадают с битами 8 и 7 второго числа, то поместить их в два разных массива.

start:

mov si, offset array
mov di, offset array1
mov bp, offset array2
mov cl, len

bits_operations:

mov ax, word ptr[si]
and ax, 7DF8h
ror ax, 2d	
ror al, 1d
push ax
and ax, 1830h
ror ah, 4d
ror al, 4d
cmp ah, al
je inarrays
pop ax
add si, 2d
loop bits_operations
jmp exit

inarrays:

pop ax
mov byte ptr[di], ah
mov byte ptr[bp], al
inc di
inc bp
add si, 2d
loop bits_operations

exit:

mov ax, 4c00h
int 21h

array	dw	54444d, 2332d, 4141d, 4566d, 3132d, 1132d, 5678d, 12314d
	dw	14214d, 56666d, 2314d, 2454d, 5625d, 12543d, 7444d, 1533d
	dw	5256d, 1555d, 12542d, 2142d, 4142d, 9876d, 4236d, 6345
	dw	65535d, 21545d, 64232d, 12344d, 6344d, 62987d
len	equ	($-array)/2d	;count of array
array1	db	15 dup(24h)
array2	db	15 dup(24h)

code	ends
end	start