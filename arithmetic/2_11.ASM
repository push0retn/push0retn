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
inc di
inc bp
loop writevar

;10*A+B-3*C

mov al, a
mov bl, 0Ah
neg al
mul bl
sub al, b
mov dl, al
mov al, c_
mov bl, 3d
mul bl
add al, dl
neg al
mov res1, al

;(12*A-B)/C

xor ax, ax
xor dx, dx
mov al, a
neg al
mov bl, 0Ch
mul bl
add al, b
mov bl, c_
div bl
neg al
mov res2, al

mov ax, 4c00h
int 21h

array	db	1d, -21d, 54d, 78d, 42d, 81d, 32d, 221d, 164d, 21d, 0d
pos	db	1d, 3d, 6d, 11d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	db	?	;10*A+B-3*C
res2	db	?	;(12*A-B)/C

code	ends
end	start