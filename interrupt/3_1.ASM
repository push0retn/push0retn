.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Подсчитать количество вхождений заданного символа в строку  текста.


start:

;Вывод приглашения ко вводу пользователя.

mov ah, 9d
mov dx, offset msg
int 21h

;Ввод строки пользователем.

mov ah, 0Ah
mov dx, offset str_
int 21h

;Выбор символа для поиска пользователем.

mov ah, 9d
mov dx, offset msg1
int 21h

mov ah, 1d
int 21h

mov symb, al				;Сохранение искомого символа в переменную.

;Поиск количества вхождений заданного символа в строке.

mov di, offset str_+2
mov cl, byte ptr[di-1]
xor dx, dx

search_symb:

repne scasb
cmp cl, 0
jz output
inc dl
jmp search_symb

;Вывод на экран результатов поиска.

;Преобразование 16-ричного числа в код ASCII.

output:

mov ax, dx
mov di, offset msg3+6
cmp ax, 0Fh
ja numbs2
sub di, 2d
call hex_in_dec
jmp exit

numbs2:

cmp ax, 63h
ja numbs3
dec di
call hex_in_dec
jmp exit

numbs3:

call hex_in_dec

;Вывод на экран результатов поиска и выход из программы.

exit:

mov ah, 9d
mov dx, offset msg2
int 21h

mov ax, 4c00h
int 21h

str_	db	250d, 254 dup(24h)		;Массив для ввода строки пользователем.

;Блок сообщений для пользователя.

msg	db	'Input the source string(MAX. 252 symbols)', 0Ah, 0Dh, 24h
msg1	db	0Ah, 0Dh,'Input the searching symbol', 24h
msg2	db	0Ah, 0Dh, 'Symbol '
symb	db	?						;Заданный символ.
msg3	db	'  =    ', 24h

;Преобразование 16-чного числа в десятичные числа в кодировке ASCII.
;Параметры:
;DI = смещение последнего индекса массива.
;AX = число.

hex_in_dec	proc	uses ax dx bx di 

xor dx, dx
mov bx, 0Ah

divide:

div bx
add dl, 30h
mov byte ptr[di], dl
cmp ax, 0
je exitp
dec di
xor dx, dx
jmp divide

exitp:

ret

hex_in_dec	endp

code ends
end start