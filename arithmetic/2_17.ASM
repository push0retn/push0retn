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

;B+A*C

mov ax, a
mov bx, c_
mul bx
neg b
add ax, b
neg b
mov res1, ax

;(3*mod(A,2)+2*B)/C

xor ax, ax
xor bx, bx
mov ax, a
mov bl, 2d
div bl
xchg ah, al
xor ah, ah
mov bl, 3d
mul bl
mov bx, b
neg bx
shl bx, 2d
add ax, bx
mov bx, c_
div bx
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	24d, 554d, 23d, 14d, -65d, 88d, 47d, 55d, 264d, -33d, 543d, 312d, 343d
pos	db	0d, 8d, 10d, 18d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;B+A*C
res2	dw	?	;(3*mod(A,2)+2*B)/C

code	ends
end	start