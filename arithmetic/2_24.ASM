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

;c*b+a*5

mov ax, c_
mov bx, b
neg bx
mul bx
mov cx, ax
mov ax, a
mov bx, 5d
mul bx
sub cx, ax
neg cx
mov res1, cx

;((c+a)/b+1)+3*d

mov ax, a
add ax, c_
mov bx, b
neg bx
dec bx
div bx
mov cx, ax
mov ax, d
mov bx, 3d
neg ax
mul bx
add cx, ax
neg cx
mov res2, cx

mov ax, 4c00h
int 21h

array	dw	24d, 554d, 23d, 14d, -65d, 88d, 47d, 55d, 264d, -33d, 543d, 312d, 343d
pos	db	0, 8d, 10d, 18d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;c*b+a*5
res2	dw	?	;((c+a)/b+1)+3*d

code	ends
end	start