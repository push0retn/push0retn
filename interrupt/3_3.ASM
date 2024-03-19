.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Удалить заданный символ из текста.

start:

;Ввод строки пользователем (допускается строка до 250 символов).

mov ah, 9d
mov dx, offset msg
int 21h

mov ah, 0ah
mov dx, offset str_
int 21h

;Задание символа пользователем.

mov ah, 9d
mov dx, offset msg2
int 21h

mov ah, 1d
int 21h
mov symb, al

;Удаление заданного символа из строки.

mov ah, 9d 
mov dx, offset msg3
int 21h

mov di, offset str_+2
mov cl, byte ptr[di-1]
mov si, di
add si, cx
sub si, 3d
mov al, symb

delete:

repne scasb
inc cl

push cx
push di
push si
mov cx, si
dec di
sub cx, di
add cx, 3d
mov si, di
inc si
rep movsb

pop si
pop di
pop cx
loop delete

exit:

;Вывод на экран изменённой строки и выход из программы.

mov ah, 9d
mov dx, offset msg4
int 21h
mov dx, offset str_+2
int 21h

mov ax, 4c00h
int 21h

str_	db	250d, 255d dup(24h) 					;Исходная строка.
symb	db	?										;Заданный символ.

;Сообщения пользователю.

msg		db	'Input string', 0Ah, 0Dh, 24h
msg2	db	0Ah, 'Input symbol: ', 24h
msg3	db	0Ah, 0Dh, 'delete symbol...', 24h
msg4	db	0Ah, 0Dh, 'New string!', 0Ah, 0Dh, 24h 

code	ends
end	start