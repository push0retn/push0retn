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

;(b-5*c)*a

mov al, c_
mov bl, 5d
mul bl
mov bl, b
neg bl
add ax, bx
mov bl, a
mul bl
neg ax
mov res1, ax

;(a*b-c)/d

xor ax, ax
mov al, a
mov bl, b
neg bl
mul bl
mov bl, c_
add ax, bx
mov bl, d
div bl
neg al
mov res2, al


mov ax, 4c00h
int 21h

array	db	76d, 225d, 243d, -53d, 234d, 72d, 76d, 64d, 33d, 142d, 243d
pos	db	0, 3d, 5d, 9d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;(b-5*c)*a
res2	db	?	;(a*b-c)/d

code	ends
end	start