include		macro.mac

.286
.model		tiny
code		segment
org		100h

;Program display a list of files from the root directory.
;When press the U key, program sort this list by size.

start:

;read the root directory

read_disk 1d, 0, 2d, 14d, root_dir

;display list of files

mov si, offset root_dir
mov di, offset file_list
mov dx, offset name_display
mov bp, offset sizes
add si, 32d

display_list:

cmp byte ptr[si], 0
jz wait_key

cmp byte ptr[si], 0E5h
jz next_file

mov cx, 11d
rep movsb

xchg dx, di
sub si, 11d
mov cx, 11d
rep movsb

sub di, 11d
xchg dx, di

mov ax, word ptr[si+17]
mov word ptr[bp], ax
mov ax, word ptr[si+19]
mov word ptr[bp+2], ax
add bp, 4d

add si, 21d

print name_display

jmp display_list

next_file:

add si, 32d
jmp display_list

wait_key:

print msg

mov ah, 1d
int 21h

cmp al, 'u'
jz sort

cmp al, 'x'
jz exit

jmp wait_key

;bubble sort

sort:

print return

mov bp, offset file_list
mov si, offset sizes
mov di, offset sizes+4

xor bx, bx			;index of numbers 
mov dx, 1d			;in array

bubble_sort:

cmp word ptr[di], 24h
jz next_itteration

mov ax, word ptr[si]

cmp ax, word ptr[di]
jb swap
ja next_size

mov ax, word ptr[si+2]

cmp ax, word ptr[di+2]
jb swap

next_size:

add di, 4d
inc dx
jmp bubble_sort

next_itteration:

inc bx
mov dx, bx
inc dx
mov si, bx
shl si, 2d
add si, offset sizes
mov di, si
add di, 4d

cmp word ptr[si], 24h
jz display_sort

jmp bubble_sort

;change positions

swap:

mov ax, word ptr[si]
mov cx, word ptr[di]
mov word ptr[si], cx
mov word ptr[di], ax

mov ax, word ptr[si+2]
mov cx, word ptr[di+2]
mov word ptr[si+2], cx
mov word ptr[di+2], ax

pusha

mov ax, 11d
mov cx, dx
mul bx

mov si, ax
add si, bp

mov ax, 11d
mov bx, cx
mul bx

mov di, ax
add di, bp

mov cx, 11d

change_pos:

mov al, byte ptr[si]
mov ah, byte ptr[di]
mov byte ptr[si], ah
mov byte ptr[di], al

inc si
inc di

loop change_pos

popa

jmp next_size

;display sorted list of files

display_sort:

mov si, bp
mov di, offset name_display

display:

cmp byte ptr[si], 0
jz exit

mov cx, 11d
rep movsb
sub di, 11d
print name_display

jmp display

exit:

outprog

root_dir	db	7200d dup(0)
file_list	db	2465d dup(0)
sizes		dw	448d dup(24h)

name_display	db	11d dup(0)
return		db	0Ah, 0Dh, 24h

msg		db	'Press U for sort', 0Ah, 0Dh
		db	'Press X for exit', 0Ah, 0Dh, 24h

code	ends
end	start