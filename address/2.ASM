.286
.model	tiny
code	segment
org	100h

;2. Задан массив из 50 слов. Первое число массива содержит действительное
;количество чисел в массиве. В каждом слове находятся два числа: одно в битах 14, 13,
;12, 11, 10, второе в битах 8, 7, 6, 5, 4, 3. Если бит 1 в слове неравен 0, то умножить эти
;два числа и поместить произведение в новый массив. Выведите на экран числа и
;произведения.

start:

mov si, offset array
mov di, offset array2
mov cx, len

bitsop:

mov bx, word ptr[si+2]
and bx, 7DFCh
ror bx, 2d
shr bh, 1d
jc carry
ror bh, 1d
jmp compare

carry:

mov al, bl
or ax, 100h
xor bl, bl
ror bx, 1d
xchg bh, bl

compare:

mov dx, word ptr[si+2]
and dx, 2d
jnz inarray2
add si, 2d
loop bitsop

inarray2:
push ax
call out_dw_hex
push bx
call out_dw_hex

mul bx
mov word ptr[di], ax

push ax
call out_dw_hex

mov ah, 1d
int 21h

mov ah, 2d
mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h

add di, 2d
add si, 2d
xor ax, ax
xor bx, bx
loop bitsop

mov ax, 4c00h
int 21h

;Parameters(STACK):
;NUM
;Result:
;Num on display

out_dw_hex	proc	uses ax dx di bp

mov bp, sp
mov ax, word ptr ss:[bp+10d]
mov dx, ax
mov di, offset out_buf
mov cx, 4d

inhex:

mov ax, dx
rol ax, 4d
mov dx, ax
and ax, 0000000000001111b
cmp al,	9d
ja letter
add al, 30h
mov byte ptr[di], al
inc di
loop inhex
jmp exproc

letter:

add al, 37h
mov byte ptr[di], al
inc di
loop inhex

exproc:

mov ah, 9d
mov dx, offset out_buf
int 21h
mov dx, offset return
int 21h

ret 2

out_buf		db	5d dup(24h)
return		db	0Ah, 0Dh, 24h

out_dw_hex	endp


code	ends
end	start

array	dw	50d, 5666d, 234d, 755d, 213d, 5467d, 5353d, 785d, 4214d, 2142d
		dw	11d, 868d, 9767d, 4444d, 2113d, 54333d, 231d, 64656d, 2422d
		dw	2341d, 3555d, 23154d, 523d, 2d, 4214d, 5535d, 2411d,  5643d
		dw	21421d, 5643d, 46422d, 3133d, 222d, 111d, 2144d, 6534d, 2145d
		dw	12515d, 5166d, 21565d, 2353d, 2154d, 6777d, 23521d, 2545d, 2155d
		dw	21413d, 5644d, 2112d, 4111d

len		equ	($-array)/2d	;count of array
array2	dw	50 dup(24h)

