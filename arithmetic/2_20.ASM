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

;(7*a)/c+b

mov ax, a
mov bl, 7d
mul bl
mov bx, c_
neg bx
neg b
add bx, b
neg b
div bx
neg ax
mov res1, ax

;a*b-3

mov ax, a
mov bx, b
neg bx
mul bx
add ax, 3d
neg ax
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	123d, 23d, 567d, 75d, -476d, 675d, -5645d, 342d, -7654d, 7652d, 543d, 43211d
pos	db	2d, 8d, 12d, 16d, 20d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(7*a)/c+b
res2	dw	?	;a*b-3
code	ends
end	start