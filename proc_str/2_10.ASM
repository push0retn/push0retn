.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Часть  строки,  следующую  за первым вхождением заданного символа переписать в обратном порядке заданное число раз.

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

;Запись строки, следующей за заданным символом, в обратном порядке.

mov cx, offset str_
add cx, len
sub cx, pos_symb
dec cx
mov bx, cx			;Сохранение длины, необходимой части строки.
shr cx, 1d
mov si, offset str_
add si, len
dec si
mov di, pos_symb
inc di

inverse:

mov al, byte ptr[si]
mov ah, byte ptr[di]
mov byte ptr[di], al
mov byte ptr[si], ah
dec si
inc di
loop inverse

mov cx, count
dec cx
mov di, offset str_
add di, len

write:

mov si, pos_symb
inc si
push cx
mov cx, bx
rep movsb
sub si, bx
pop cx
loop write

exit:

mov ax, 4c00h
int 21h

str_		db	'123456789klksk123456789', ($-str_)*4d dup(0)	;Исходная строка.
len			equ	($-str_)/5d										;Длина исходной строки.
symb		db	'k'												;Заданный символ.
pos_symb	dw	?												;Позиция заданного символа.
count		equ	4d												;Заданное количество повторений части строки.

code	ends
end	start