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

;11*b+a-10

mov ax, b
mov bl, 11d
mul bx
neg a
sub ax, a
neg a
sub ax, 10d
mov res1, ax

;(10+b-c*a)/d

mov ax, c_
mov bx, a
neg bx
mul bx
mov bx, b
add bx, 10d
add ax, bx
mov bx, d
div bx
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	254d, 77d, 63d, -24d, 825d, 728d, 7d, 3d, 72d, 42d, 4d, 54523d
pos	db	6d, 8d, 18d, 22d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;11*b+a-10
res2	dw	?	;(10+b-c*a)/d

code	ends
end	start