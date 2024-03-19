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

;(a+b)/(c+9)

mov ax, a
add ax, b
mov bx, c_
add bx, 9d
div bx
mov res1, ax

;(a*5-c)*b

mov ax, a
mov bx, 5d
mul bx
sub ax, c_
mov bx, b
mul bx
mov si, offset res2
mov word ptr[si], ax
mov word ptr[si+2], dx

mov ax, 4C00h
int 21h

array	dw	8797d, 5675d, 492d, 723d, 829d, 7d, 8d, -23d, 8710d, 744d, 512d, 313d
pos	db	0, 4d, 8d, 14d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(a+b)/(c+9)
res2	dd	?	;(a*5-c)*b

code	ends
end	start