.286
.model	tiny
code	segment
org	100h

;4*A - 2*(C+B) = res

start:

mov di, offset a
mov si, offset array
mov cx, len

writevar:

cmp word ptr[si], -114d
je write
cmp word ptr[si], 56d
je write
cmp word ptr[si], -54d
je write
cmp word ptr[si], 877d
je write
add si, 2d
loop writevar
jmp math

write:

mov ax, word ptr[si]
mov word ptr[di], ax
add si, 2d
add di, 2d
loop writevar

math:

mov ax, a
mov bx, 4d
mul bx
mov cx, ax
mov ax, c_
mov bx, d
add ax, bx
mov bx, 2d
mul bx
sub cx, ax
mov res, cx

mov ax, 4c00h
int 21h

array	dw	4343d, 54d, 33d, -114d, 15d, 56d, 543d, 2d, 2d, -54d, 877d, 232d
len	equ	($-array)/2d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?
res	dw	?

code	ends
end	start