.286
.model	tiny
code	segment
org	100h

;D+B-A*C/8 = res

start:

mov si, offset array
mov bp, offset pos
mov di, offset a
mov cx, 4d

write:

mov bl, byte ptr[bp]
mov ax, word ptr[si+bx]
mov word ptr[di], ax
inc bp
add di, 2d
loop write

;A*C/8

mov ax, a
mov bx, c_
neg bx
mul bx
xor bx, bx
mov bl, 8d
div bx

;D+B

mov bx, d
mov cx, b
neg cx
sub bx, cx
sub ax, bx
neg ax
neg dx

mov di, offset res
mov word ptr[di], dx
mov word ptr[di+2], ax

mov ax, 4c00h
int 21h

array	dw	123d, 23d, 567d, 75d, -476d, 675d, -5645d, 342d, -7654d, 7652d, 543d, 43211d
pos	db	2d, 8d, 12d, 16d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res	dd	?

code	ends
end	start