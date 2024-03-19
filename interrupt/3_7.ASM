.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Удалить все пробелы из строки символов.

start:

;Ввод строки пользователем.

mov ah, 9d
mov dx, offset msg
int 21h

mov ah, 0ah
mov dx, offset str_
int 21h

;Вывод сообщения пользователю.

mov ah, 9d
mov dx, offset msg2
int 21h

;Удаление пробелов из строки.

delete_spaces:

mov di, offset str_+2
mov cl, byte ptr[di-1]
mov al, 20h
repne scasb

cmp cl, 0
jz exit

dec di
mov si, offset str_+2
mov cl, byte ptr[si-1]
add cx, si
sub cx, di
mov si, di
inc si
rep movsb
xor cx, cx
jmp delete_spaces

;Вывод сообщения пользователю, изменённой строки и выход из программы.

exit:

mov ah, 9d
mov dx, offset msg3
int 21h
mov dx, offset str_+2
int 21h

mov ax, 4c00h
int 21h

str_	db	250d, 255d dup(24h)							;Массив для записи строки.

;Сообщения пользователю.

msg		db	'Input string:', 0ah, 0dh, 24h				
msg2	db	0ah, 'delete spaces...', 0ah, 0dh, 24h
msg3	db	'New string!', 0ah, 0dh, 24h

code	ends
end	start