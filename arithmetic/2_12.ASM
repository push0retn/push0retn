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

;(B-A)*C+D

mov al, b
neg al
add al, a
mov bl, c_
mul bl
mov bl, d
sub ax, bx
neg ax
mov res1, ax

;((14+B)/C)-A

xor ax, ax
mov al, b
neg al
sub al, 14d
mov bl, c_
div bl
add al, a
neg al
mov res2, al


mov ax, 4C00h
int 21h

array	db	76d, 225d, 243d, -53d, 234d, 72d, 76d, 64d, 33d, 142d, 243d
pos	db	0d, 3d, 5d, 9d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;(B-A)*C+D
res2	db	?	;((14+B)/C)-A

code	ends
end	start