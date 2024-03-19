.286
.model	tiny
code	segment
org	100h

;Написать программу,  заменяющую все десятичные цифры  в исходной строке на заданный символ.

start:

mov si, offset str_
mov al, symb
mov cl, len

;Поиск десятичных цифр.

change:

cmp byte ptr[si], 39h
jbe numb?
inc si
loop change
jmp exit

;Проверка, точно ли, найденный символ - десятичная цифра?

numb?:

cmp byte ptr[si], 30h
jae numb
inc si
loop change
jmp exit

;Да, это десятичная цифра, замена на заданный символ.

numb:

mov byte ptr[si], al
inc si
loop change

exit:

mov ax, 4c00h
int 21h

str_	db	'abc 1d4e fg5H 2Hge 2315jy'
len		equ	$-str_						;Длина строки.
symb	equ	'$'							;Заданный символ для замены десятичных цифр.

code	ends
end	start