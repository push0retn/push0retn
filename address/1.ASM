.286
.model	tiny
code	segment
org	100h

;1. Задана последовательность символов, заканчивающаяся точкой. Подсчитать
;количество битов в состоянии 0 для каждого символа. Создать новый массив, который
;содержит эти значения для каждого символа. Выведите на экран символ, его двоичное
;представление и количество битов в состоянии 1.

start:

mov cx, 10d				;count of numbers
mov si, offset array
mov di, offset count
push si
push di

writecount:

call bin8count
inc si
inc di
loop writecount
pop di
pop si

mov cl, 10d
mov ah, 2d

printresult:

mov dl, byte ptr[si]
int 21h

mov dl, 0Ah
int 21h

mov dl, 0Dh
int 21h

mov dl, byte ptr[di]
or dl, 30h
int 21h

mov dl, 0Ah
int 21h

mov dl, 0Dh
int 21h

call bin8print

mov dl, 0Ah
int 21h

mov dl, 0Dh
int 21h

inc di
add si, 2d
dec ah
int 21h
inc ah
loop printresult

mov ax, 4c00h
int 21h

;Parameters:
;SI = source(db)

bin8print	proc	uses ax cx dx 

mov ah, 2d
mov cx, 8d
mov al, byte ptr[si]

print:

shl al, 1d
mov dh, al
jc print1
mov dl, 30h
int 21h
mov al, dh
loop print
jmp return

print1:

mov dl, 31h
int 21h
mov al, dh
loop print

return:

mov dl, 0Ah
int 21h
mov dl, 0Dh
int 21h
ret

bin8print	endp

;Parameters:
;SI = source(db)
;DI = destination of count bits(db)

bin8count	proc	uses dx ax cx

xor dx, dx
mov al, byte ptr[si]
mov cx, 8d

count?:

shr al, 1d
jc carry
loop count?
jmp exp

carry:

inc dx
loop count?

exp:

mov byte ptr[di], dl
ret 

bin8count	endp


code	ends
end	start

array		db	'0.1.2.3.4.5.6.7.8.9.'
count		db	10d dup(24h)
return		db	0Ah, 0Dh, 24h