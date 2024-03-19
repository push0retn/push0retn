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

;(3*b-4)*a

mov ax, b
mov bl, 3d
neg ax
mul bx
add ax, 4d
mov bx, a
mul bx
neg ax
mov res1, ax

;(b/a)+(c/d)

mov ax, b
mov bx, a
neg ax
div bx
mov cx, ax
xor dx, dx
mov ax, c_
mov bx, d
neg ax
neg bx
div bx
sub cx, ax
neg cx
mov res2, cx

mov ax, 4c00h
int 21h

array	dw	123d, 23d, 567d, 75d, -476d, 675d, -5645d, 342d, -7654d, 7652d, 543d, 43211d
pos	db	2d, 8d, 12d, 16d, 20d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(3*b-4)*a
res2	dw	?	;(b/a)+(c/d)

code	ends
end	start