.386
.model flat,stdcall
option casemap:none

VirtualAlloc proto stdcall :DWORD, :DWORD, :DWORD, :DWORD
VirtualProtect proto stdcall :DWORD, :DWORD, :DWORD, :DWORD
VirtualFree proto stdcall :DWORD, :DWORD, :DWORD

includelib \masm32\lib\kernel32.lib

.code 
	main:
		push ebp
		mov ebp,esp

		mov eax,dword ptr ss:[ebp+0ch]
		cmp eax,1
		jnz @returnf

		push eax
		push 40h
		push 1000h
		push 4h
		push 0
		call VirtualAlloc
		mov ebx,eax

		push ebx
		push 40h
		push 1h
		push 445481h
		call VirtualProtect	

		mov byte ptr ds:[445481h],03h

		push 0
		push dword ptr ds:[ebx]
		push 1h
		push 445481h
		call VirtualProtect 	

		push 4000h
		push 4h
		push ebx
		call VirtualFree

		pop eax
		@returnf:
			leave
			retn 0ch
		
	end main
	
	;miksussy
