.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Переместить заданный символ, если он находится в строке, в конец строки.

start:

;Ввод строки пользователем.

mov ah, 9d
mov dx, offset msg
int 21h

mov ah, 0Ah
mov dx, offset str_
int 21h

;Ввод символа пользователем.

mov ah, 9d
mov dx, offset msg2
int 21h

mov ah, 1d
int 21h
mov symb, al

;Вывод сообщения пользователю о начале работы со строкой.

mov ah, 9d
mov dx, offset msg3
int 21h

;Перемещение заданного символа в конец строки.

mov al, symb
mov di, offset str_+2
mov cl, byte ptr[di-1]
repne scasb
cmp cl, 0
jz exit
dec di
mov si, offset str_+1
mov cl, byte ptr[si]
add cx, si
sub cx, di
mov si, di
inc si
rep movsb
mov byte ptr[di], al

;Вывод сообщений пользователю.

mov ah, 9d
mov dx, offset msg4
int 21h
mov dx, offset str_+2
int 21h

exit:

mov ax, 4c00h
int 21h

str_	db	250d, 255d dup(24h)								;Массив для записи строки.
symb	db	?												;Переменная для записи заданного символа.

;Сообщения пользователю.

msg	db	'Input string:', 0Ah, 0Dh, 24h
msg2	db	0Ah, 'Input symbol: ', 0Ah, 0Dh, 24h
msg3	db	0Ah, 0Dh, 'moving symbol...', 0Ah, 0Dh, 24h
msg4	db	'New string!', 0Ah, 0Dh, 24h

code	ends
end	start