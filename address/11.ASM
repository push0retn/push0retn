.286
.model	tiny
code	segment
org	100h

;11. Задан текст из 100 символов, содержащий слова произвольной длины. Слова
;в тексте разделены пробелами. Создать новый массив, в который поместить количества
;букв в каждом слове. Вывести на экран количество слов в тексте.

start:

mov si, offset text
mov di, offset array

search:

cmp byte ptr[si], 24h
je exit
cmp byte ptr[si], 20h
je space
inc ah
inc si
jmp search

space:

inc al
mov byte ptr[di], ah
xor ah, ah
inc di
inc si
jmp search

exit:

mov byte ptr[di], ah
inc al
xor ah, ah
mov bl, 10d
div bl
or ah, 30h
or al, 30h
mov di, offset words
mov byte ptr[di], al
mov byte ptr[di+1], ah
mov dx, di
mov ah, 9d
int 21h

mov ax, 4C00h
int 21h

text	db	'asfgw teq etqs gdxcg sdfgteq jtjf d hvcxz sdfgp- etyuiewq sxz ' 
	db	'weqr ieys hxzn, jklir w ew io treq uuuu', 24h  
array	db	50d dup(24h)
words	db	3d dup(24h)	;count of words in decimal

code	ends
end	start