.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Написать программу  формирования  сжатой строки символов. 
;Сжатие заключается в удалении пробелов из исходной  строки  при просмотре ее слева направо.

start:

mov si, offset str_+1	;смещение второго элемента массива
mov di, offset str_
mov cl, len

;Просмотр строки слева направо.

compare:

cmp byte ptr[di], 20h
je space
inc si
inc di
loop compare 
jmp exit

;Байт равен 20H(Пробел), удаление пробела

space:

cmp byte ptr[di], 24h
je start
movsb
loop space
jmp start

exit:

mov ax, 4C00h
int 21h

str_	db	'1 2 3 4 5 646  4626 45234   1111', 24h
len	equ	$-str_	;количество элементов массива

code	ends
end	start