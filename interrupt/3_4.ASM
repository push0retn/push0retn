.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Подсчитать количество слов в строке,  считая словом последовательность знаков между пробелами.

start:

;Пользователь вводит строку.

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

;Подсчёт количества слов в строке.

mov si, offset str_+2
mov cl, byte ptr[si-1]
mov count, 0

search_words:

cmp byte ptr[si], 20h
jne it_word
xor bl, bl
inc si
loop search_words
jmp hex_in_ascii

it_word:

cmp bl, 1d
jb count1
inc bl
inc si
loop search_words
jmp hex_in_ascii

count1:

inc count
inc bl
inc si
loop search_words

;Перевод числа количества слов в строке в код ASCII для вывода на экран.

hex_in_ascii:

xor ax, ax
mov al, count
mov count, 20h
mov si, offset count+2
mov bx, 10d
xor dx, dx

trans:

cmp al, 0
je out_display
div bx
add dl, 30h
mov byte ptr[si], dl
dec si
xor dl, dl
jmp trans

;Вывод на экран количества слов в строке.

out_display:

mov ah, 9d
mov dx, offset count
int 21h

mov ax, 4c00h
int 21h

str_	db	250d, 255d dup(24h)						;Массив для записи строки.

;Сообщения пользователю.

msg		db	'Input string: ', 0ah, 0dh, 24h	
msg2	db	0Ah, 'Word count...', 0Ah, 0Dh, 24h
count	db	3 dup(20h), 20h							;Количество слов в строке.
msg3	db	'words$'


code	ends
end	start