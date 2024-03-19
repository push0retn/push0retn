.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Заменить заданный символ в строке текста на указанный  новый символ.

start:

;Вывод сообщений пользователю.

mov ah, 9d
mov dx, offset msg
int 21h
mov dx, offset msg2
int 21h

;Поиск заданного символа в массиве и изменение его на другой заданный символ.

mov cl, len
mov di, offset str_
mov bl, new_symb
mov al, symb

change:

repne scasb
inc cl
cmp byte ptr[di-1], al
jne exit
mov byte ptr[di-1], bl
loop change

exit:

;Вывод сообщений пользователю.

mov ah, 9d
mov dx, offset	msg5
int 21h
mov dx, offset str_
int 21h

mov ax, 4c00h
int 21h

msg			db	'String:', 0Ah, 0Dh										;Сообщение пользователю.
str_		db	'asngjegi3qubnqub3wbfxzkjzjbxkbxzjxbkjkjskauuw', 24h	;Исходная строка.
msg2		db	0Ah, 0Dh, 'Symbol: '									;Сообщение пользователю.
symb		db	'j'														;Заданный символ, который необходимо заменить.
msg3		db 	0Ah, 0Dh, 'New symbol: '								;Сообщение пользователю.
new_symb	db	'A', 0Ah, 0Dh											;Заданный символ, на который необходимо заменить.
msg4		db	'change symbol...', 0Ah, 0Dh, 24h						;Сообщение пользователю.
msg5		db	'New string!', 0Ah, 0Dh, 24h							;Сообщение пользователю.
len			equ	msg2-str_												;Длина исходной строки.

code	ends
end	start