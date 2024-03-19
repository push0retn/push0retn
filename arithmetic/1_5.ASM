.286
.model	tiny
code	segment
org	100h

;2*(A+D)-(B-C)/4 = res

start:

lea si, array
lea di, a
mov cx, len

writevar:

cmp word ptr[si], 776d
je write
cmp word ptr[si], 42d
je write
cmp word ptr[si], 545d
je write
cmp word ptr[si], 873d
je write
add si, 2d
loop writevar
jmp math

write:

mov ax, word ptr[si]
mov word ptr[di], ax
add di, 2d
add si, 2d
loop writevar

math:

;2*(A+D) = cx

mov ax, a
add ax, d
mov bl, 2d
mul bx
mov cx, ax

;(B-C)/4

mov ax, b
sub ax, c_
mov bl, 4d
neg ax
div bx
add cx, ax
mov res, cx

mov ax, 4c00h
int 21h

array	dw	8952d, 4d, 776d, 34d, 65d, 185d, 42d, 545d, 873d, 235d, 653d, 542d
len	equ	($-array)/2d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res	dw	?

code	ends
end	start