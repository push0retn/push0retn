.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;В  исходную  строку  вставить  после заданного  символа  все  символы,  предшествующие заданному в об-ратном порядке. Оставшуюся часть строки оставить без изменения.

start:

;Поиск заданного символа.

mov di, offset str_
mov al, symb
mov cl, len
repne scasb

cmp cl, 0
jz exit

dec di
mov pos_symb, di

mov cx, offset str_
add cx, len
sub cx, pos_symb
dec cx

mov bx, pos_symb
sub bx, offset str_

;Перенос символов.

mov si, offset str_
add si, len
dec si

carry_symbs:

mov al, byte ptr[si]
mov byte ptr[si+bx], al
dec si
loop carry_symbs

;Запись символов в обратном порядке после заданного символа.

mov cx, bx
mov si, pos_symb
dec si
mov di, pos_symb
inc di

write_after:

mov al, byte ptr[si]
mov byte ptr[di], al
dec si
inc di
loop write_after

exit:

mov ax, 4C00h
int 21h

str_		db	'2468k123456789', $-str_ dup(0)		;Исходная строка.
len 		equ	($-str_)/2d							;Длина исходной строки.
symb		equ	'k'									;Заданный символ.
pos_symb	dw	?									;Позиция заданного символа.

code	ends
end	start