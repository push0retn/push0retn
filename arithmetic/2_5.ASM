.286
.model	tiny
code	segment
org	100h

start:

mov si, offset array
mov bp, offset pos
mov di, offset a
mov cx, 4d

writevar:

mov bl, byte ptr[bp]
mov ax, word ptr[si+bx]
mov word ptr[di], ax
add di, 2d
inc bp
loop writevar

;A+mod(A,5)

mov ax, a
mov bl, 5d
div bx
add dx, a
mov res1, dx

;(3+B)/A

mov ax, b
add ax, 3d
mov bx, a
div a
mov res2, ax

mov ax, 4c00h
int 21h

array	dw	8952d, 4d, 776d, 34d, 65d, 42d, 545d, 675d, 873d, 235d, 653d, 542d
pos	db	4d, 12d, 14d, 18d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dw	?	;A+mod(A,5)
res2	dw	?	;(3+B)/A

code	ends
end	start