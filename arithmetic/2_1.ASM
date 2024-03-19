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
inc di
inc bp
loop writevar

;(A-B)*C+10

mov al, a
neg al
add al, b
neg al

mov bl, c_
mul bl
add ax, 10d
mov res1, ax

xor ax, ax
xor bx, bx

;(4*A+B+C)/D

mov al, a
neg al
mov bl, 4d
mul bl
add al, b
add al, c_
mov bl, d
div bl
neg al
xor ah, ah
mov res2, ax

mov ax, 4C00h
int 21h

array	db	1d, -21d, 54d, 78d, 32d, 78d, 42d, 81d, 32d, 221d, 164d, 21d, 0
pos	db	1d, 3d, 6d, 11d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;res1 = (A-B)*C+10
res2	dw	?	;res2 = (4*A+B+C)/D

code	ends
end	start