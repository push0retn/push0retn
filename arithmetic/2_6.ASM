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

;12*C-B-C = 11*C-B

mov ax, c_
mov bl, 11d
mul bx
sub ax, b
mov res1, ax

;(B+A+C)/d

mov ax, b
add ax, a
add ax, c_
mov bx, d
div bx
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	254d, 77d, 63d, -24d, 825d, 728d, 7d, 3d, 72d, 42d, 4d, 54523d, -56432d
pos	db	4d, 6d, 16d, 22d,

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;12*C-B-C = 11*C-B
res2	dw	?	;(B+A+C)/d

code	ends
end	start