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

;4*b+a*c

mov al, a
mov bl, c_
neg al
mul bl

mov bl, b
shl bx, 4d
sub bx, ax
mov res1, bl

;(4*c+b)/(a+d)

xor ax, ax
mov al, c_
shl al, 4d
add al, b
mov bl, a
neg bl
add bl, d
div bl
mov res2, al

mov ax, 4c00h
int 21h

array	db	1d, -21d, 54d, 78d, 32d, 78d, 42d, 81d, 32d, 221d, 164d, 21d, 0
pos	db	1d, 3d, 6d, 11d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	db	?	;4*b+a*c
res2	db	?	;(4*c+b)/(a+d)

code	ends
end	start