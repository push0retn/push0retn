.286
.model	tiny
code	segment
org	100h

;16*(A+C+8*D) = res

start:

lea si, array
lea di, a
mov cx, len

writevar:

cmp word ptr[si], 4345d
je write
cmp word ptr[si], -652d
je write
cmp word ptr[si], -32554d
je write
cmp word ptr[si], 45212d
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

mov di, offset temp
mov si, offset res
mov ax, d
mov bl, 8d
mul bx
mov word ptr[di], dx
mov word ptr[di+2], ax
mov ax, c_
mov dx, a
neg ax
sub ax, dx
mov dx, word ptr[di+2]
sub dx, ax
mov word ptr[di+2], dx
mov bl, 16d
mov ax, word ptr[di+2]
mul bx
mov word ptr[si+2], ax
mov cx, dx
mov ax, word ptr[di]
mul bx
add ax, cx
mov word ptr[si], ax

mov ax, 4C00h
int 21h

array	dw	78d, 4345d, 6512d, -652d, 8653d, 4533d, 652d, -32554d, 653d, 45212d, 54212d, 215d
len 	equ	($-array)/2d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

temp	dd	0
res	dd	0

code	ends
end	start