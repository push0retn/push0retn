.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Написать программу  формирования  строки  из исходной  путем  заданного  числа  повторений  исходной строки.


start:

;Выделение памяти под новую строку.

mov ax, len
shr ax, 4d
inc ax
mov bx, repeat_str
mul bx
mov bx, ax
mov ah, 48h
int 21h
mov es, ax

;Формирование новой строки.

mov cx, repeat_str

write:

push cx
mov si, offset str_source
mov cx, len

begin_write:

rep movsb
pop cx
loop write

mov ax, 4c00h
int 21h

str_source	db	'bhjdfasdasnjasnjgdaskjtgn'		;Исходный массив.
len 		equ	$-str_source					;Длина исходного массива.
repeat_str	equ	2d								;Количество повторений исходного массива.

code	ends
end	start