.286
.model	tiny
code	segment
org	100h

;(A+4)*(B+16)-(C+8*D) = res
 
start:

mov si, offset nums
mov bp, offset a
mov cx, 4d

writevar:

mov ax, word ptr[si] 
mov di, offset array
mov cx, len

search:
scasw
je write
loop search
jmp math

write:

mov ax, word ptr[di-2]
add si, 2d
mov word ptr[bp], ax
add bp, 2d
jmp writevar

math:

;(A+4)*(B+16)

mov ax, a
neg ax
sub ax, 4d
mov bx, b
add bx, 16d
mul bx
neg ax
mov temp, ax

;C+8*D

mov ax, d
neg ax
mov bx, 8d
mul bx
lea bp, temp2
add ax, c_
sub ax, temp

mov bp, offset res
mov word ptr[bp], dx
mov word ptr[bp+2], ax

mov ax, 4c00h
int 21h

array	dw	254d, 77d, 63d, -24d, 825d, 728d, 7d, 3d, 72d, 42d, 4d, 54523d, -56432d
len	equ	($-array)/2d

a	dw	?
b	dw	?
c_	dw	?
d	dw	?

temp	dw	?
temp2	dd	?
res	dd	?

nums	dw	-24d, 825d, 42d, -56432d

code	ends
end	start