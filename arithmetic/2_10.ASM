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

;3*A+B-2*C

mov ax, a
mov bl, 3d
mul bl
mov bx, b
neg bx
sub bx, ax
mov ax, c_
neg ax
shl ax, 1d
sub ax, bx
mov res1, ax

;(4*A+mod(B,3))/C

mov ax, b
neg ax
mov bx, 3d
div bx
mov ax, a
shl ax, 2d
sub dx, ax
mov ax, dx
neg ax
mov bx, c_
neg bx
xor dx, dx
div bx
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	123d, 23d, 567d, 75d, -476d, 675d, -5645d, 342d, -7654d, 7652d, 543d, 43211d
pos	db	2d, 8d, 12d, 16d, 20d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;3*A+B-2*C
res2	dw	?	;(4*A+mod(B,3))/C

code	ends
end	start