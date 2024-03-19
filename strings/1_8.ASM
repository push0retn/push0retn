.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Написать  программу, находящую максимальный и  минимальный символы в исходной строке.

start:

mov si, offset str_+1
mov al, byte ptr[si-1]
mov cl, len

;Поиск максимального символа в строке.

max_symb:

cmp al, byte ptr[si]
jb it_max
inc si
loop max_symb
jmp write_max

;Найден символ больше, чем символ, записанный в регистре AL.

it_max:

mov al, byte ptr[si]
inc si
loop max_symb

;Запись максимального символа в переменную.

write_max:

mov max, al

mov si, offset str_+1
mov al, byte ptr[si-1]
mov cl, len

;Поиск минимального символа.

min_symb:

cmp al, byte ptr[si]
ja it_min
inc si
loop min_symb
jmp exit

;Символ меньше, чем символ, записанный в регистре AL.

it_min:

mov al, byte ptr[si]
inc si
loop min_symb

exit:

mov min, al

mov ax, 4c00h
int 21h

str_	db	'235769814'
len	equ	$-str_-1
min	db	?
max	db	?

code	ends
end	start