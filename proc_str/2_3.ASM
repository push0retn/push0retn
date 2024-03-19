.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Переставить в обратном порядке все символы между первым  и последним  вхождением  заданного симво-ла в исходной строке, 
;если заданный символ встречается в строке не менее двух раз.


start:

;Поиск первого и последнего вхождения символа.

mov di, offset str_
mov al, symb
mov cl, len

search:

repne scasb
cmp cl, 0
je inverse
inc dl
cmp dl, 1d
je first_symb
mov last, di
dec last
inc di
jmp search

first_symb:

mov first, di
dec first
inc di
jmp search

;Перестановка символов в обратном порядке.

inverse:

mov cx, last
sub cx, first
shr cx, 1d
inc cx

mov si, first
mov di, last

inverse_begin:

mov al, byte ptr[si]
mov ah, byte ptr[di]
mov byte ptr[si], ah
mov byte ptr[di], al
dec di
inc si
loop inverse_begin

mov ax, 4c00h
int 21h

str_	db	'kjfasfas123456789s123456789s'	;Исходная строка.
len		equ	$-str_							;Длина исходной строки.
symb	db	's'								;Заданный символ.
first	dw	0								;Первое вхождение заданного символа.
last	dw	0								;Последнее вхождение заданного символа.

code	ends
end		start

