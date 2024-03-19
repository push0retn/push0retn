.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Написать программу,  выполняющую следующую фуикцию. Заданы  две строки. Проверить вхождение каждого символа строки 1 в строку 2.  
;Если какой-либо (первый слева) символ строки 1 не представлен в строке 2, то фиксируется номер позиции этого символа в строке 1.


start:

mov si, offset str1
mov bp, offset pos

;Поиск символов, которых нет в строке 2.

search:

;Начало поиска и переход к следующему символу строки 1.

mov di, offset str2
mov cx, len
cmp byte ptr[si], 24h
je exit
mov al, byte ptr[si]


begin_search:

cmp al, byte ptr[di]
jne notequal
inc si
jmp search

;Символ в строке 1 не равен символу в строке 2, 
;тогда проверить следующий символ из строки 2.
;Если символ из строки 1 не равен ни одному
;символу из строки 2, тогда записать позицию символа.

notequal:

inc di
loop begin_search
mov word ptr[bp], si
add bp, 2d
inc si
jmp search

exit:

mov ax, 4c00h 
int 21h

str1	db	'HEhLFLO2    WORsLD!', 24h
str2	db	'HELLO WORLD!'
len	equ	$-str2		;Длина строки 2.
pos	dw	10 dup(0)	;Позиции неравных символов.

code	ends
end	start