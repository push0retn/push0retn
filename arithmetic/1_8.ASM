.286
.model	tiny
code	segment
org	100h

;4*A+8*B+16*C-A*D

start:

mov si, offset array
mov di, offset a
mov bp, offset pos
mov cx, 4d

write:

mov bx, word ptr[bp]
mov ax, word ptr[si+bx]
mov word ptr[di], ax
add di, 2d
add bp, 2d
loop write

;4*A

mov ax, a
mov bx, 4d
mul bx
mov cx, ax

;8*B

mov ax, b
mov bx, 8d
mul bx

;4*A+8*B

add cx, ax
mov temp, cx

;16*C

mov ax, c_
mov bx, 16d
mul bx
add temp, ax

;A*D

xor dx, dx
xor cx, cx
mov ax, a
mov bx, d
mul bx

;4*A+8*B+16*C-A*D = res

add ax, temp
adc cx, 0
add dx, cx

mov di, offset res
mov word ptr[di], dx
mov word ptr[di+2], ax

mov ax, 4c00h
int 21h

array	dw	8797d, 5675d, 492d, 723d, 829d, 7d, 8d, -23d, 8710d, 744d, 512d, 313d
pos	dw	0, 4d, 8d, 14d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

temp	dw	?
res	dd	?

code	ends
end	start