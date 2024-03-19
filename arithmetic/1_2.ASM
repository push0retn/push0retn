.286
.model	tiny
code	segment
org	100h

;C*C+B*D = res

start:

mov si, offset array
mov cl, 11d

writevar:

cmp byte ptr[si], 76d
je ina
cmp byte ptr[si], -53d
je inb
cmp byte ptr[si], 72d
je inc_
cmp byte ptr[si], 142d
je ind
inc si
loop writevar
jmp math

ina:

mov al, byte ptr[si]
mov a, al
inc si
loop writevar
jmp math

inb:

mov al, byte ptr[si]
mov b, al
inc si
loop writevar
jmp math

inc_:

mov al, byte ptr[si]
mov c_, al
inc si
loop writevar
jmp math

ind:

mov al, byte ptr[si]
mov d, al
inc si
loop writevar

math:

mov al, c_
mov bl, c_
mul bl
mov dx, ax
xor ax, ax
mov al, b
neg al
mov bl, d
mul bl
neg ax
add ax, dx
mov res, ax

     
mov ax, 4C00h
int 21h

array	db	76d, 225d, 243d, -53d, 234d, 72d, 76d, 64d, 33d, 142d, 243d

a	db	?
b	db	?
c_	db	?
d	db	?
res	dw	?

code	ends
end	start