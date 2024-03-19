.286
.model	tiny
code	segment
org	100h

;Написать программу, удаляющую из исходной строки повторные  вхождения  заданного символа.

start:

mov di, offset str_
mov al, symb
mov cl, len

;Поиск повторных вхождений заданного символа в строке.

search:

repne scasb
inc dl
inc cl
cmp dl, 1d
ja delete
loop search
jmp exit

;Удаление из строки заданного символа.

delete:

push si
push di
push cx
mov si, di
dec di
dec cl
rep movsb
pop cx
pop di
pop si
loop search


exit:

mov ax, 4c00h
int 21h

str_	db	'strzssszjjvznzxvzllzadzsgljnxzvnxzvnkljz$'
len		equ	$-str_		;Длина строки.
symb	equ	'z'			;Заданный символ.

code	ends
end	start