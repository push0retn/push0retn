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
mov al, byte ptr[si+bx]
mov byte ptr[di], al
inc bp
inc di
loop writevar

;(A+B)*5+9

mov al, a
add al, b
mov bl, 5d
mul bl
add ax, 9d
mov res1, ax

;(C+7*B)/(A+D)

xor ax, ax
mov al, b
mov bl, 7d
mul bl
add al, c_
mov bl, a
add bl, d
div bl
mov res2, al

mov ax, 4c00h
int 21h

array	db	43d, 42d, 64d, 75d, 232d, 23d, 53d, 113d, 132d, 34d, 225d, 2d
pos	db	1d, 3d, 7d, 9d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;(A+B)*5+9
res2	db	?	;(C+7*B)/(A+D)

code	ends
end	start