.286
.model	tiny
code	segment
org	100h

;A*B*C-8*D = res

start:

mov si, offset array
mov bp, offset pos
mov di, offset a
mov cx, 4d

write:

mov bl, byte ptr[bp]
mov al, byte ptr[si+bx]
mov byte ptr[di], al
inc di
inc bp
loop write

mov al, a
mov bl, b
mul bl
mov bl, c_
mul bx
mov cx, ax

xor ax, ax
mov al, d
mov bl, 8d
mul bl
sub cx, ax

mov di, offset res
mov word ptr[di], dx
mov word ptr[di+2], cx

mov ax, 4c00h
int 21h

array	db	43d, 42d, 64d, 75d, 232d, 23d, 53d, 113d, 132d, 34d, 225d, 2d 
pos	db	1d, 3d, 6d, 8d

a	db	?
b	db	?
c_	db	?
d	db	?

res	dd	?

code	ends
end	start