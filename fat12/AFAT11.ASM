.286
.model		tiny
include		macro.mac
code		segment
org		100h

;Determine whether there are files with the EXE extension in the root 
;directory and, if there are any, display alist of item.

start:

;Read root directory from diskette

read_disk 1d, 0, 2d, 14d, root_dir

;Compare extension with searching

mov si, offset root_dir
add si, 32d
mov di, offset compare_ext

search_exe:

add si, 8d
mov cx, 3d

cmp byte ptr[si], 0
jz exit

cmp byte ptr[si-8], 0E5h
jz skip_delete

repe cmpsb
jz display_file

mov bx, 3d
sub bx, cx
sub si, bx
sub si, 8d
add si, 32d
mov di, offset compare_ext

jmp search_exe

skip_delete:

add si, 24d
jmp search_exe

;Display EXE filename

display_file:

sub di, 3d
sub si, 11d

mov bp, di

mov di, offset fname
mov cx, 11d
rep movsb
print fname

mov di, bp
add si, 21d
jmp search_exe

exit:

outprog

root_dir	db	7200d dup(0)

fname		db	8d dup(20h), 9d
ext		db	3d dup(20h), 0Ah, 0Dh, 24h
compare_ext	db	'EXE'


code		ends
end		start