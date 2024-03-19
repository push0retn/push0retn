.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Написать  программу выделения из исходной строки  подстроки  символов  заданной  длины с указанного номера позиции.

start:

;Запись позиции подстроки символов.

mov si, offset str_
add si, pos
dec si
mov di, offset str_ddc

;Запись подстроки с указанного номера позиции в другой массив.

mov cl, count
rep movsb

mov ax, 4c00h
int 21h

str_		db	'rertyyyfcdxdxkskasnfnoqubrtoquw'	;Исходная строка символов
pos			equ	7d									;Номер позиции подстроки
count		equ	8d									;Длина подстроки
str_ddc		db	9d dup(24h)							;Массив для записи подстроки символов

code	ends
end	start