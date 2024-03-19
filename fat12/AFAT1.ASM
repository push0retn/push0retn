.286
.model	tiny
code	segment
org	100h
include	macro.mac

;Analyze the disk A and displays the total number of clusters,
;the number of free clusters, the number of busy clusters and
;the number of bad clusters.

start:

read_disk 0, 0, 2d, 9d, dump_fat	;read fat table

mov si, offset dump_fat
add si, 1d

;search sectors

mov cx, 4607d		;count of loop
shr cx, 1d		;

search:

mov ax, word ptr[si]
and ax, 0000111111111111b

cmp ax, 0		;compare with number of free cluster
ja nofree		;

inc freecl		;free cluster
add si, 2d		;
loop search		;
jmp display		;

nofree:

cmp ax, 0FF7h		;compare with number of bad cluster
jz bad			;

inc busycl		;busy cluster
add si, 2d		;
loop search		;
jmp display		;

bad:

inc badcl		;bad cluster
add si, 2d		;
loop search		;

;Out results on display

display:

mov di, offset msg2+18
push di
push busycl
call hex_ascii

mov di, offset msg3+18
push di
push freecl
call hex_ascii

mov di, offset msg4+17
push di
push badcl
call hex_ascii

mov ah, 9d
mov dx, offset msg
int 21h

exit:

mov ax, 4c00h
int 21h

;Hex number in decimal ASCII
;Parameters(stack):
;1. Offset of last byte in memory.
;2. Number.

hex_ascii	proc	uses ax dx bp di

mov bp, sp
mov ax, word ptr es:[bp+10]
mov di, word ptr es:[bp+12]
mov bx, 10d
xor dx, dx

in_ascii:

cmp ax, 0
je exitp

div bx
add dl, 30h
mov byte ptr[di], dl
dec di
xor dl, dl
jmp in_ascii

exitp:

ret 4

hex_ascii	endp

dump_fat	db	4608d dup(0)	;dump fat table

busycl		dw	0		;busy clusters	
freecl		dw	0		;free clusters
badcl		dw	0		;bad clusters

msg		db	'Total clusters:', 9d, '2880', 0Ah, 0Dh
msg2		db	'Busy clusters:', 9d, 3d dup(0), 30h, 0Ah, 0Dh
msg3		db	'Free clusters:', 9d, 3d dup(0), 30h, 0Ah, 0Dh
msg4		db	'Bad clusters:', 9d, 3d dup(0), 30h, 7d, 24h

code	ends
end	start