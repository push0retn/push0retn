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

;(A/B)+3*C

mov ax, a
neg ax
mov bx, b
div bx
mov cx, ax
mov ax, c_
mov bx, 3d
mul bx
sub ax, cx
mov res1, ax

;(3*A-B)+C

mov ax, a
neg ax
mul bx
add ax, b
sub ax, c_
neg ax
mov res2, ax


mov ax, 4c00h
int 21h

array	dw	254d, 77d, 63d, -24d, 825d, 728d, 7d, 3d, 72d, 42d, 4d, 54523d
pos	db	6d, 8d, 18d, 22d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(A/B)+3*C
res2	dw	?	;(3*A-B)+C

code	ends
end	start