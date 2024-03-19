.286
.model	tiny
code	segment
org	100h

;(Формулировка из задачи)
;2. Подсчитать количество символов,  у которых равные соседи в исходной строке. Первый и последний символы считать соседями.

start:

;Поиск "соседей" каждого символа в строке.

mov si, offset str_
mov di, offset neighbours
mov cl, len

write_neighbours:

mov al, byte ptr[si-1]
mov ah, byte ptr[si+1]
mov byte ptr[di], al
mov byte ptr[di+1], ah
inc si
add di, 2d
loop write_neighbours

mov si, offset neighbours
mov cl, len
shr cl, 1d

;Поиск равных "соседей".

search_equal:

mov di, offset neighbours
push cx
mov al, byte ptr[si]
mov ah, byte ptr[si+1]
mov cl, len

search_begin:

mov dl, byte ptr[di]
mov dh, byte ptr[di+1]
push ax
xor ax, dx
pop ax
jz equal
add di, 2d
loop search_begin
jmp after_loop

equal:

inc count_equ
add di, 2d
loop search_begin 

after_loop:

pop cx
add si, 2d
dec count_equ
loop search_equal

mov ax, 4c00h
int 21h

str_double	db	'qwertyuiopqwertyuiopasdfghjkl'		;Исходная 
str_		db	'qwertyuiopqwertyuiopasdfghjkl'		;строка
str_double2	db	'qwertyuiopqwertyuiopasdfghjkl'		;и 2 её копии.
len			equ	$-str_double2						;Длина исходной строки.
neighbours	db	2*len+1 dup (24h)					;"Соседи" каждого символа.
count_equ	db	0									;Количество равных "соседей".

code	ends
end	start