.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;В  исходной  строке  фрагмент  с заданной  позиции  заданной  длины  повторить требуемое число раз. Ос-тапьные символы строки оставить без изменения.

start:

;Перенос символов на заданное число.

mov al, len_new
mov bl, count
mul bl
mov bx, ax

mov di, offset str_
add di, pos
add di, len_new
mov si, offset str_
add si, len_str
dec si

carry:

cmp si, di
jb write
mov al, byte ptr[si]
mov byte ptr[si+bx], al
dec si
jmp carry

;Запись символов с заднной позиции заданное число раз.

write:

mov cl, count
mov si, offset str_
add si, pos

write_begin:

push cx
mov cl, len_new
rep movsb
sub si,	len_new
pop cx
loop write_begin

mov ax, 4c00h
int 21h

str_		db	'123456789123456789123456789', $-str_ dup(0)		;Исходная строка.
len_str		equ	($-str_)/2d											;Длина исходной строки.
pos			equ	9d													;Заданная позиция символов в строке.
len_new		equ	5d													;Заданное количество символов, необходимое копировать.
count		equ	3d													;Заданное количество повторений копирования символов.

code	ends
end	start