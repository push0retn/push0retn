.286
.model	tiny
code	segment	
org	100h

;Задан текст из 100 символов, содержащий слова произвольной длины. Слова
;в тексте разделены пробелами. Создать новый массив, в который поместить количества
;букв в каждом слове. Вывести на экран все слова текста, каждое с новой строки.

start:

mov si, offset text
mov di, offset array2
mov bp, offset array

search:

mov al, byte ptr[si]
cmp al, 24h
je exit
cmp al, 20h
je space
mov byte ptr[di], al
inc cl
inc si
inc di
jmp search

space:

mov byte ptr[bp], cl
xor cl, cl
mov byte ptr[di], 0Ah
inc di
mov byte ptr[di], 0Dh
inc di
inc si
jmp search

exit:

mov byte ptr[bp], cl
mov ah, 9d
mov dx, offset array2
int 21h

mov ax, 4c00h
int 21h

text	db	'its sfggh 24weq rty uids axczv b ngn f gg htiorj d sas ddds '
	db	'jnxc uwq e rtyiod sax85 3213t uyitot reh', 24h
array	db	50d dup(24h)	;count of symbols in word
array2	db	200d dup(24h)	;all words are new line

code	ends
end	start