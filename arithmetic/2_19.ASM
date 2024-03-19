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

;3*(b+c)-2

mov al, b
add al, c_
mov bl, 3d
mul bx
sub ax, 2d
mov res1, ax

;4*c-b+(a/3)

xor ax, ax
mov al, a
div bl
add al, b
mov bl, c_
shl bl, 4d
sub bl, al
mov res2, bl

mov ax, 4c00h
int 21h

array	db	43d, 42d, 64d, 75d, 232d, 23d, 23d, 113d, 132d, 34d, 225d, 2d
pos	db	1d, 3d, 6d, 8d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;3*(b+c)-2
res2	db	?	;4*c-b+(a/3)

code	ends
end	start