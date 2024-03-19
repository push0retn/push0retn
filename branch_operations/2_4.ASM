.286
.model	tiny
code	segment
org	100h

;В  исходную  строку  вставить  после заданного символ-а все символы, предшествующие ему. Оставшуюся часть строки оставить без изменения.

start:

;Поиск заданного символа.

mov di, offset str_
mov al, symb
mov cl, len

repne scasb

cmp cl, 0	;Если заданного символа в строке нет,
jz exit		;то выйти из программы.

dec di
mov pos_symb, di

;Перенос символов в конец строки.

mov di, offset str_
add di, len

mov cx, di
sub cx, pos_symb
dec cx

mov si, pos_symb
inc si
rep movsb

;Перенос символов после заданного символа.

mov si, offset str_
mov di, pos_symb
mov cx, di
inc di
sub cx, si
rep movsb

exit:

mov ax, 4c00h
int 21h

str_		db	'123456789f987654321', $-str_ dup(0)	;Исходная строка.
len			equ	(($-str_)/2d)							;Длина исходной строки.
symb		equ	'f'										;Заданный сивол.
pos_symb	dw	?										;Позиция заданного символа.

code	ends
end	start