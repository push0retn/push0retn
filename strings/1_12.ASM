.286
.model	tiny
code	segment
org	100h

;Написать программу,  удаляющую из исходной строки заданную конфигурацию символов.

start:

mov si, offset str_
mov cl, len
mov dl, cl

;Поиск заданной конфигурации символов.

search:

mov di, offset symb
repe cmpsb
dec dl
push dx
sub dl, cl
cmp dl, len_symb
je it_conf
pop dx
mov dl, cl
jmp search

;Конфигурация найдена.

it_conf:

pop dx
sub si, len_symb
mov pos, si 

;Удаление заданной конфигурации символов.

delete_conf:

mov di, pos
mov dx, offset str_
add dx, len
dec dx
sub dx, di
mov cx, len_symb

delete:

push cx
mov cx, dx
mov di, pos
dec di
mov si, di
inc si
rep movsb
pop cx
loop delete

mov ax, 4c00h
int 21h

str_		db	'jangftnqewoingwoin ndalsn nkldastgnkl$'
len			equ	$-str_				;Длина исходной строки.
symb		db	'n nk'				;Заданная конфигурация символов.
len_symb	equ	$-symb				;Длина конфигурации символов.
pos			dw	?					;Позиция найденной конфигурации символов.

code	ends
end	start