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

;(15-B)*C+A

mov ax, b
neg ax
add ax, 15d
mov bx, c_
mul bx
add ax, a
neg ax
mov res1, ax

;((13*A-B)/C)+A

mov ax, a
mov bx, 13d
mul bx
mov bx, b
neg bx
add ax, bx
mov bx, c_
div bx
add ax, a
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	24d, 554d, 23d, 14d, -65d, 88d, 47d, 55d, 264d, -33d, 543d, 312d, 343d
pos	db	0, 8d, 10d, 18d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;(15-B)*C+A
res2	dw	?	;((13*A-B)/C)+A

code	ends
end	start