.286
.model	tiny
code	segment
org	100h

;Написать программу,  удаляющую  пробелы  в  конце  исходной  строки.

start:

mov si, offset str_
add si, len

;Сравнение символа строки с пробелом.

delete_space:

cmp byte ptr[si], 20h
je change
jmp exit

;Если пробел, то заменить его на $.
;Если нет, то выйти из программы.

change:

mov byte ptr[si], 24h
dec si
jmp delete_space

exit:

mov ax, 4c00h
int 21h

str_	db	'dzkjasfkjasnfkjasnf xzkljndfaskj lknfas klnfas    '
len		equ	$-str_-1	;Длина строки -1.

code	ends
end	start