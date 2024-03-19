.286
.model	tiny
code	segment
org	100h

start:

mov si, offset nums
mov di, offset a
mov cx, 4d

searchnums:

push cx
mov bp, offset array
mov cx, 12d

search:

mov ax, word ptr[bp]
sub ax, word ptr[si]
jne nextsearch
movsw
pop cx
loop searchnums
jmp math

nextsearch:

add bp, 2d
loop search

math:

;(B+C)*A - 3*D

mov ax, d
mov bx, 3d
mul bx

mov di, offset temp1
mov word ptr[di], ax
mov word ptr[di+2], dx

mov ax, b
mov bx, c_
neg ax
neg bx
add ax, bx
mov bx, a
mul bx

add ax, word ptr[di]
add dx, word ptr[di+2]

mov di, offset res1
mov word ptr[di], ax
mov word ptr[di+2], dx

xor dx, dx

;(A/C) + 4*B

mov ax, a
mov bx, c_
neg bx
div bx

mov cx, ax

mov ax, b
neg ax
shl ax, 2d
add ax, cx
neg ax
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	78d, 4345d, 6512d, -652d, 8653d, 4533d, 652d, -32554d, 653d, 45212d, 54212d, 215d
nums	dw	4345d, -652d, -32554d, 45212d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(B+C)*A - 3*D
res2	dw	?	;(A/C) + 4*B
temp1	dd	?

code	ends
end	start