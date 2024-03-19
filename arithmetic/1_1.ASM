.286
.model	tiny
code	segment
org	100h

;(A+16*B)*(C-D) = res

start:

mov si, offset array
mov di, offset a
mov cx, 13d

writevar:

cmp byte ptr[si], -21d
je write
cmp byte ptr[si], 78d
je write
cmp byte ptr[si], 42d
je write
cmp byte ptr[si], 21d
je write
inc si
loop writevar
jmp math

write:

mov al, byte ptr[si]
cmp byte ptr[di-1], al
jne noteq
inc si
loop writevar
jmp math

noteq:

mov byte ptr[di], al
inc si
inc di
loop writevar

math:

mov bl, 16d
xor ax, ax
mov al, b
mul bl
mov bl, a
neg bl
sub ax, bx
mov bl, c_
sub bl, d
mul bx
mov res, ax

mov ax, 4C00h
int 21h

array	db	1d, -21d, 54d, 78d, 32d, 78d, 42d, 81d, 32d, 221d, 164d, 21d, 0

a	db	?
b	db	?
c_	db	?
d	db	?
res	dw	?

code	ends
end	start