.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;Найти  всех  соседей  заданного символа в исходной строке.Первый и последний символ считать соседями.


start:

mov di, offset str_
mov si, offset neigh
mov bp, di
mov al, symb
mov cl, len
inc cl

;Поиск "соседей" заданного символа.

search_symb:

repne scasb
dec di
cmp cl, 0 
je exit
cmp di, bp
je first
add bp, len
dec bp
cmp di, bp
je last
mov dl, byte ptr[di+1]
mov byte ptr[si], dl
inc si
mov dl, byte ptr[di-1]
mov byte ptr[si], dl
inc si
inc di
jmp search_symb

;Символ является первым в строке.

first:

mov dl, byte ptr[di+1]
mov byte ptr[si], dl
inc si
add bp, len
dec bp
mov dl, byte ptr[bp]
mov byte ptr[si], dl
inc bp
sub bp, len
inc si
inc di
jmp search_symb

;Символ является последним в строке.

last:

mov dl, byte ptr[di-1]
mov byte ptr[si], dl
inc si
mov dl, byte ptr[bp]
mov byte ptr[si], dl
inc si
inc di
jmp search_symb

;Вывод на экран найденных "соседей" заданного символа и выход.

exit:

mov ah, 9d
mov dx, offset neigh
int 21h

mov ax, 4c00h
int 21h

str_	db	'kjfasfaskjkjkjsafkjsjjsjfnngfkazkxnk'		;Исходная строка символов.
len		equ	$-str_										;Длина исходной строки.
symb	db	'k'											;Заданный символ.
neigh	db	len dup(24h)								;Соседи заданного символа.

code	ends
end	start