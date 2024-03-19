.286
.model		tiny
include		macro.mac
code		segment
org		100h

;After launching program, display menu "Delete" and "Restore".
;One of the items in this menu is selected, for example, by press the key.
;Then the program prompts you to enter a latter and, if the "Delete" was select
;delete from the root directory all files whose names begin on this letter.

;If "Restore" was selected, the program restores all deleted files in 
;the root directory using the entered letter.

start:

;Display message for user

print msg

;Wait press key

mov ah, 1d
int 21h

mov bl, al

print return

;View selected option

cmp bl, 31h
jz delete

cmp bl, 32h
jz restore

cmp bl, 33h
jz exit

jmp start

;Restore files

restore:

read_disk 1d, 0, 2d, 14d, root_dir
mov si, offset root_dir
add si, 32d

print msg2

mov ah, 1d
int 21h

mov bl, al

print return

;Change first letter deleted file(E5h) on letter selected of user

restore_files:

cmp byte ptr[si], 0
jz msg_restore

cmp byte ptr[si], 0E5h
jnz next_r_file

mov byte ptr[si], bl

next_r_file:

add si, 32d
jmp restore_files

;Delete files

delete:

read_disk 1d, 0, 2d, 14d, root_dir
mov si, offset root_dir
add si, 32d

print msg2

mov ah, 1d
int 21h

mov bl, al

print return

;Delete files started on letter from user input

delete_files:

cmp byte ptr[si], 0
jz msg_delete

cmp byte ptr[si], bl
jnz next_d_file

mov byte ptr[si], 0E5h

next_d_file:

add si, 32d
jmp delete_files

msg_delete:

write_disk 1d, 0, 2d, 14d, root_dir
print msg_del
jmp exit

msg_restore:

write_disk 1d, 0, 2d, 14d, root_dir
print msg_rest

exit:

outprog

root_dir	db	7200d dup(0)

msg		db	'Press number of option for select', 0Ah, 0Dh
		db	'1. Delete', 0Ah, 0Dh
		db	'2. Restore', 0Ah, 0Dh
		db	'3. Exit'
return		db	0Ah, 0Dh, 24h

msg2		db	'Press the first symbol of file names', 0Ah, 0Dh, 24h

msg_del		db	'Files delete!', 0Ah, 0Dh, 24h
msg_rest	db	'Files restore!', 0Ah, 0Dh, 24h

code		ends
end		start