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

;(A+C)*A+14

mov ax, a
mov bx, c_
neg ax
neg bx
add ax, bx
mov bx, a
neg bx
mul bx
sub ax, 14d
neg ax
mov res1, ax

;((17+C)/A)+B*D

mov ax, c_
neg ax
sub ax, 17d
mov bx, a
neg bx
div bx
add ax, b
mov bx, d
mul b
mov res2, ax

mov ax, 4C00h
int 21h

array	dw	4343d, 54d, 33d, -114d, 15d, 56d, 543d, 2d, 2d, -54d, 554d, 877d, 232d
pos	db	6d, 10d, 18d, 22d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(A+C)*A+14
res2	dw	?	;((17+C)/A)+B*D

code	ends
end	start