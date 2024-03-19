.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;В исходной строке указанное число символов, начиная с заданной позиции, переписать в конец строки.

start:

;Копирование заданного количества символов с заданной позиции в конец строки.

mov si, offset str_+pos
mov di, offset str_+len
mov cl, itterations

write_in_end:

push cx
mov cl, count
rep movsb
sub si, count
pop cx
loop write_in_end

mov ax, 4c00h
int 21h

str_		db	'123456789123456789', 18d dup(24h)		;Исходная строка.
len			equ	($-str_)-18d							;Длина исходной строки.
count		equ	5d										;Заданное количество символов.
pos			equ	4d										;Заданная позиция.
itterations	equ	3d										;Заданное количество повторений.

code	ends
end	start