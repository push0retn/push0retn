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

;15*B+A-B

mov ax, b
mov bl, 14d
mul bl
add ax, a
mov res1, ax 

;(B+A)/mod(C,7)

mov ax, c_
mov bl, 7d
div bx
mov bx, dx
mov ax, b
add ax, a
xor dx, dx
div bx
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	8952d, 4d, 776d, 34d, 65d, 185d, 42d, 545d, 675d, 873d, 235d, 653d, 542d
pos	db	4d, 12d, 14d, 18d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;15*B+A-B
res2	dw	?	;(B+A)/mod(C,7)

code	ends
end	start