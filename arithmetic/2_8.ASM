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

;(C+B+A)*3

mov ax, c_
add ax, b
add ax, a
mov bl, 3d
mul bx
mov res1, ax

;(C+B-A)/A

mov ax, c_
add ax, b
sub ax, a
neg ax
mov bx, a
div bx
neg ax
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	8797d, 5675d, 492d, 723d, 829d, 7d, 8d, -23d, 8710d, 744d, 512d, 313d
pos	db	0, 4d, 8d, 14d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(C+B+A)*3
res2	dw	?	;(C+B-A)/A

code	ends
end	start