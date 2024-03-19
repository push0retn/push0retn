.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Часть строки,  предшествующую первому вхождению заданного символа, переписать в обратном порядке заданное число раз.

start:

;Поиск первого вхождения заданного символа.

mov di, offset str_
mov cl, len
mov al, symb
repne scasb
cmp cl, 0
jz exit
dec di
mov pos_symb, di

;Запись символов, предшествующих заданному, в обратном порядке в другой массив.

mov cx, pos_symb
sub cx, offset str_
mov bx, cx
mov di, offset array
mov si, pos_symb
dec si


write_new_array:

mov al, byte ptr[si]
mov byte ptr[di], al
dec si
inc di
loop write_new_array

mov di, offset str_
mov si, offset array
mov cx, count

;Запись символов в обратном порядке в исходную строку.

write_inverse:

push cx
mov cx, bx
rep movsb
sub si, bx
pop cx
loop write_inverse

exit:

mov ax, 4c00h
int 21h

str_		db	'123456789l123456789', ($-str_)*3d dup(24h)	;Исходная строка.
len			equ	($-str_)/4d									;Длина исходной строки.
symb		db	'l'											;Заданный символ.
pos_symb	dw	?											;Позиция заданного символа.
count		equ	4d											;Заданное количество повторений.
array		db	len dup(24h)								;Массив для записи символов.

code	ends
end	start