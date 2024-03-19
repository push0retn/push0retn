.286
.model	tiny
code	segment
org	100h

start:

mov si, offset array
mov bp, offset pos
mov di, offset a
mov cl, 4d

;write nums of array in variables

writevar:

mov bl, byte ptr[bp]
mov al, byte ptr[si+bx]
mov byte ptr[di], al
inc bp
inc di
loop writevar

;4*A+B+2*C

mov al, a
mov bl, 4d
mul bl
mov cx, ax
mov al, c_
mov bl, 2d
mul bl
xor ah, ah
add ax, cx
mov bl, b
neg bl
sub ax, bx
mov res1, ax

;(4*A-B)/C

xor ax, ax
xor bx, bx

mov al, b
neg al
add ax, cx
mov bl, c_
div bl
xor ah, ah
mov res2, ax


mov ax, 4c00h
int 21h

array	db	76d, 225d, 243d, -53d, 234d, 72d, 76d, 64d, 33d, 142d, 243d
pos	db	0, 3d, 5d, 9d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;res1 = 4*A+B+2*C
res2	dw	?	;res2 = (4*A-B)/C

code	ends
end	start