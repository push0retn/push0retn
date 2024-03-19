.286
.model		tiny
code		segment
include		macro.mac
org		100h

;The program displays a list of files from the root directory.
;When you press the S key, program sorts this list alphabetically.

start:

;read dump source directory

read_disk 1d, 0, 2d, 14d, dump

;write filenames in extension in list of files, for use it array later

mov si, offset dump
mov di, offset listf

write_listf:

cmp byte ptr[si], 0
jz out_listf

add si, 32d
mov cx, 11d
rep movsb
sub si, 11d

jmp write_listf

;out on display list of files

out_listf:

mov si, offset listf
mov di, offset fname

write_struc:

cmp byte ptr[si], 0
jz wait_key

mov cl, 8d
rep movsb
inc di
mov cl, 3d
rep movsb

mov di, offset fname

mov ah, 9d
mov dx, di
int 21h

jmp write_struc

;wait press key and sort filenames or not

wait_key:

mov ah, 1d
int 21h

cmp al, 73h		;if press S key sort filenames
jnz exit		;else exit

;bubble sort

alphabet_sort:

mov si, offset listf
mov di, si
add di, 11d

sort:

mov cl, 8d
repe cmpsb
ja swap

;next filename

mov bx, 8d
add di, cx
add di, 3d
sub bx, cx
sub si, bx

cmp byte ptr[di], 0
jz next_fname

jmp sort

;change positions of filenames and extensions

swap:

mov bx, 8d
sub bx, cx
sub si, bx
sub di, bx
mov cl, 11d

change_pos:

mov ah, byte ptr[si]
mov al, byte ptr[di]
mov byte ptr[si], al
mov byte ptr[di], ah
inc di
inc si
loop change_pos

;compare with end of array and next or not

sub si, 11d

cmp byte ptr[di], 0
jnz sort

next_fname:

add si, 11d
mov di, si
add di, 11d

cmp byte ptr[si+11], 0
jz out_alphabet

jmp sort

;out on display sorted filenames

out_alphabet:

mov si, offset listf

;new string and back carriet

mov ah, 9d
mov dx, offset return
int 21h

outdisp:

cmp byte ptr[si], 0
jz exit

mov di, offset fname

mov cx, 8d
rep movsb
inc di
mov cx, 3d
rep movsb

mov ah, 9d
mov dx, offset fname
int 21h

jmp outdisp

exit:

outprog

dump	db	7200d dup(0)		;dump of diskette
listf	db	2475d dup(0)		;files list

;structure for out on display

fname	db	8d dup(0), 9d
ext	db	3d dup(0), 0Ah, 0Dh, 24h
return	db	0Ah, 0Dh, 24h

code		ends
end		start

