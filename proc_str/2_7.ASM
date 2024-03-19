.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Образовать  строку, повторив  фрагмент  исходной  строки  с  заданной  позиции  данной  длины требуемое число раз.

start:

mov si, offset str_
add si, pos
mov di, offset new_str
mov cl, itterations

write:

push cx
mov cl, count
rep movsb
sub si, count
pop cx
loop write

mov ax, 4c00h
int 21h

str_		db	'12345678abcde12345678'		;Исходная строка.

new_str		db	($-str_)*3d dup(24h)		;Новая строка.
pos			equ	8d							;Заданная позиция символа в строке.
count		equ	5d							;Заданное количество символов, необходимое копировать.
itterations	equ	4d							;Заданное количество повторений.

code	ends
end	start