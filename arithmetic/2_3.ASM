.286
.model	tiny
code	segment
org	100h

start:

mov si, offset array
mov bp, offset pos
mov di, offset a
mov cl, 4d

writevar:

mov bl, byte ptr[bp]
mov ax, word ptr[si+bx]
mov word ptr[di], ax
add di, 2d
inc bp
loop writevar

;2*B+B*A

mov ax, b
shl ax, 1d
mov cx, ax
mov bx, b
mov ax, a
neg ax
mul bx
sub cx, ax
mov res1, cx

;((A+3*B)/C)+4

mov ax, b
mov bx, 3d
mul bx
add ax, a
mov bx, c_
div bx
add ax, 4d
mov res2, ax

mov ax, 4C00h
int 21h

array	dw	4343d, 54d, 33d, -114d, 15d, 56d, 543d, 2d, 2d, -54d, 554d, 877d, 232d
pos	db	6d, 10d, 18d, 22d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;2*B+B*A
res2	dw	?	;((A+3*B)/C)+4

code	ends
end	start