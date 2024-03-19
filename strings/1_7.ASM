.286
.model	tiny
code	segment
org	100h

;Написать  программу,  которая  бы  инверсировала  исходную строку.

start:

;Запись позиции первого и последнего символов.

mov si, offset str_+len
dec si
mov di, offset str_
mov cl, len
shr cl, 1d

inverse:

;Инвертирование строки.

mov al, byte ptr[si]
mov ah, byte ptr[di]
mov byte ptr[si], ah
mov byte ptr[di], al
inc di
dec si
loop inverse

mov ax, 4c00h
int 21h

str_	db	'123456789'	
len		equ	$-str_		;Длина строки.

code	ends
end	start