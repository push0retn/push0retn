.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Написать программу формирования  сжатой  строкн  символов. 
;Сжатие заключается  в  удалении пробелов из исходной  строки  при просмотре ее справа налево.


start:

mov si, offset str_	
add si, len				
dec si			;Последний элемент массива.
mov di, si				
dec di			;Предпоследний элемент массива.
mov cx, len

;Просмотр строки справа налево.

compare:

cmp byte ptr[di], 20h
je space
dec si
dec di
loop compare
jmp exit

;Элемент массива равен 20Н(Пробел), удаление пробела.

space:

cmp byte ptr[di], 24h
je start
movsb
loop space
dec len
jmp start

exit:

mov ax, 4c00h
int 21h

str_	db	'12414    gfgfgf 2144 11 1 2 4 5 4222$'
len	dw	$-str_-1	;Количество элементов массива

code	ends
end	start