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

;c*a-b*d

mov al, c_
mov bl, a
mul bl
mov dx, ax
xor ax, ax
mov al, b
mov bl, d
mul bl
sub dx, ax
mov res1, dx

;((c+a)/b+1)+3*d

xor ax, ax
mov al, c_
add al, a
mov bl, b
inc bl
div bl
xor dx, dx
mov dl, al
mov ax, 3d
mov bl, d
mul bl
add ax, dx
mov res2, ax

mov ax, 4c00h
int 21h

array	db	43d, 42d, 64d, 75d, 232d, 23d, 53d, 113d, 132d, 34d, 225d, 2d
pos	db	1d, 3d, 6d, 8d

a	db	?
b	db	?
c_	db	?
d	db	?

res1	dw	?	;c*a-b*d
res2	dw	?	;((c+a)/b+1)+3*d

code	ends
end	start