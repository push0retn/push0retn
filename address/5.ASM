.286
.model	tiny
code	segment
org	100h

;5. Задано слово и массив из 32 чисел форматом слово. Каждому биту слова
;соответствует пара чисел из массива: первому биту слова соответствуют числа 1 и 2 из
;массива, второму биту - числа 3 и 4, и т.д. Если бит слова равен 1, умножить
;соответствующую пару чисел и, если произведение больше слова, поместить его в
;новый массив.

start:

mov si, offset array
mov di, offset newarray
mov bp, si
mov cl, len

bits_op:

push cx
mov ax, word ptr[si]
mov cx, 16d

begin:

shr ax, 1d
jc bit_equ_1
add bp, 4d
loop begin
jmp newnum

bit_equ_1:

push ax
mov ax, word ptr[bp]
mov bx, word ptr[bp+2]
mul bx
cmp dx, 0
jnz in_newarray
add bp, 4d
loop begin
jmp newnum

in_newarray:

mov word ptr[di], ax
mov word ptr[di+2], dx
add di, 4d
add bp, 4d
xor dx, dx
pop ax
loop begin

newnum:
pop cx
add si, 2d
mov bp, offset array
loop bits_op

mov ax, 4c00h
int 21h

array	dw	999d, 214d, 414d, 5666d, 1251d, 25415d, 6666d, 2313d, 222d
	dw	2154d, 222d, 555d, 121d, 5566d, 354d, 1222d, 555d, 2451, 2455d
	dw	21556d, 656d, 234d, 15d, 666d, 1366d, 1513d, 235d, 24d, 33d, 32d
	dw	241d, 32d
len	equ	($-array)/2d	;count of array

newarray	dd	32d dup(24h)

code	ends
end	start