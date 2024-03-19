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
mov ax, word ptr[bp+si]
mov word ptr[di], ax
inc bp
add di, 2d
loop writevar

;3*C+5*B-4*A

mov ax, c_
neg ax
mov bl, 3d
mul bx
mov cx, ax
mov ax, b
neg ax
mov bl, 5d
mul bl
add cx, ax
mov ax, a
shl ax, 2d
add cx, ax
neg cx
neg dx
mov di, offset res1
mov word ptr[di], cx
mov word ptr[di+2], dx

;(4*C+B*A)/D
;The example is incorrect because it cannot be executed by a program on an
;Intel 80286 processor. The program cannot divide a 32-bit number located        					
;in the DX:AX registers into a 16-bit number, since the DX register, where
;the remainder is placed, is occupied.

;xor dx, dx
;xor cx, cx
;mov ax, c_
;neg ax
;mov bx, 4d
;mul bx

;mov di, offset temp
;mov word ptr[di], ax
;mov word ptr[di+2], dx

;xor dx, dx
;mov ax, b
;neg ax
;mov bx, a
;mul bx
;add ax, word ptr[di]
;add dx, word ptr[di+2]
;mov bx, d
;div bx
;mov res2, ax

mov ax, 4c00h
int 21h

array	dw	78d, 4345d, 6512d, -652d, 8653d, 4533d, 652d, -32554d, 653d, 45212d, 54212d, 215d
pos	db	2d, 6d, 14d, 18d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

res1	dd	?	;3*C+5*B-4*A
res2	dw	?	;(4*C+B*A)/D
temp	dd	?	


code	ends
end	start