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
inc bp
add di, 2d
loop writevar

;7*a-4*b+9

mov ax, a
neg ax
mov bl, 7d
mul bl
mov bx, b
shl bx, 2d
add ax, bx
sub ax, 9d
neg ax
mov res1, ax

;(15-a)/3*b

mov ax, b
mov bx, 3d
mul bx
xchg bx, ax
mov ax, 15d
neg a
add ax, a
div bx
neg ax
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	4343d, 54d, 33d, -114d, 15d, 56d, 543d, 2d, 2d, -54d, 554d, 877d, 232d
pos	db	6d, 10d, 18d, 22d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;7*a-4*b+9
res2	dw	?	;(15-a)/3*b

code	ends
end	start