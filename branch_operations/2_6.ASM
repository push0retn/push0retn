.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;В  последней строке символы,  следующие за заданиым символом, переписать в обратном порядке.

start:

;Поиск заданного символа в строке.

mov di, offset str_
mov al, symb
mov cl, len
repne scasb
cmp cl, 0
je exit
dec di

;Запись символов в обратном порядке.

mov cx, di
mov si, offset str_
sub cx, si
dec di
shr cx, 1d

inverse:

mov al, byte ptr[si]
mov ah, byte ptr[di]
mov byte ptr[si], ah
mov byte ptr[di], al
dec di
inc si
loop inverse

exit:

mov ax, 4c00h
int 21h

str_	db	'abcdefg123456789123456789'		;Исходная строка.
len		equ	$-str_							;Длина исходной строки.
symb	db	'3'								;Заданный символ.


code	ends
end	start