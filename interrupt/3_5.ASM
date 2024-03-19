.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Переместить заданный символ,  если он содержится в строке, в начало строки.

start:

;Ввод строки пользователем.

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

;Вывод сообщения пользователю о начале работы с массивом.

mov ah, 9d
mov dx, offset msg3
int 21h

;Поиск заданного символа в строке.

mov di, offset str_+2
mov cl, byte ptr[di-1]
mov al, symb
repne scasb
cmp cl, 0								;Данного символа нет в строке?
jz exit									;Если нет, то выход из программы.

mov pos, di								;Запись позиции символа в переменную.

;Перемещение символа в начало строки.

mov di, offset str_+1
mov cl, byte ptr[di]
add di, cx
mov si, di
dec si
std
rep movsb
inc si
mov di, si
inc di
mov si, offset symb
movsb

;Удаление символа с позиции, в которой он был.

mov di, pos
mov si, offset str_+1
mov cl, byte ptr[si]
add si, cx
mov cx, si
sub cx, di
mov si, di
inc si
cld
rep movsb

mov ah, 9d
mov dx, offset msg4
int 21h
mov dx, offset str_+2
int 21h

exit:

mov ax, 4c00h
int 21h

str_	db	250d, 256d dup(24h)									;Массив для записи строки пользователем.
symb	db	?													;Переменная для записи символа пользователем.
pos		dw	?													;Позиция заданного символа.

;Сообщения пользователю.

msg		db	'Input string:', 0Ah, 0Dh, 24h
msg2	db	0Ah,'Input symbol: ', 24h
msg3	db	0Ah, 0Dh, 'moving symbol...', 0Ah, 0Dh, 24h
msg4	db	'New string!', 0Ah, 0Dh, 24h

code	ends
end		start