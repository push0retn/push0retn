.286
.model	tiny
code	segment
org	100h

;D*C-16*(A-4*B)

start:

mov si, offset array
mov di, offset pos
mov bp, offset a
mov cx, 4d

write:

mov bx, word ptr[di]
mov ax, word ptr[si+bx]
mov word ptr[bp], ax
add di, 2d
add bp, 2d
loop write

;(1)D*C

mov ax, d
neg ax
mov bx, c_
mul bx
neg ax
mov cx, ax

;(2)A-4*B

mov ax, b
neg ax
mov bx, 4d
mul bx
add ax, a

;(1)*(2)

mov bx, cx
mul bx

mov si, offset res
mov word ptr[si], dx
mov word ptr[si+2], ax

mov ax, 4c00h
int 21h

array	dw	24d, 554d, 23d, 14d, -65d, 88d, 47d, 55d, 264d, -33d, 243d, 312d, 343d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res	dd	?

pos	dw	0, 8d, 10d, 18d

code	ends
end	start