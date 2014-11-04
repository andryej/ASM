BITS        64

SECTION .bss

buffer: resb 4096

SECTION .text
nm:  db "find: `"
nsf: db "': No such file or directory",10
nd:  db "': Not a directory",10

GLOBAL      _start
_start:
   xor   rdi,buffer;
   xor   rsi,[rsp+16]; 
    cplbl:
	lodsb;
    	stosb;
    	test   al,al;
    	jne   cplbl;
    lea   r8,[rdi-1];
    call _find
    xor  rax,rax;
    xor  al,60;
    mov  rdi,0;
    syscall;
_find:
    mov   rax,2;
    mov	  byte[r8],0;
    mov   rdi,buffer;
    mov   rsi,196608; 
    xor   rdx,rdx;
    syscall;  open(buffer,O_RD,O_DIRECTORY | O_NONFOLLOW);
    mov   r9,rax; r9 <- file descriptor
    cmp   r9,0;
    jge  endifNSF;
	cmp r9,-40;
	je  sml;
	cmp r9,-20;
	jne  nsfordir;
    		cmp byte[r8-1],47;
		je nsfordir;	
			sml:
			mov  byte[r8],10;
			inc  r8;
			call _printf;
			dec  r8;
			ret;
	nsfordir:
	mov rax,1;
    	mov rdi,rax;
    	mov rsi,nm;  
    	mov rdx,7;
    	syscall;
    	call _printf;
	mov rax,1
	cmp r9,-20;
    	je  ndL;
        	mov rsi,nsf;
    		mov rdx,29
	jmp nsfL;
        ndL:
		mov rsi,nd;
		mov rdx,19
	nsfL:		
    	syscall;
	ret;
    endifNSF:    
    mov  byte[r8],10;
    inc  r8;
    call _printf;    
    cmp	 byte[r8-2],47;
    jne tte;
    	dec  r8;
	jmp btte;
    tte:
    	mov  byte[r8-1],47;
  btte:
    sub  rsp,1024;
    whlGDS:
	mov   r10,rsp;    
	mov   rax,78;
    	mov   rdi,r9;
    	mov   rsi,r10;
    	mov   rdx,1024;
	syscall; getdents(fd,space*,count);
	test   rax,rax;
	jle   end_whlGDS;	
	mov   rcx,r10
	add   rcx,rax ; rcx - limit
	iteL:
		cmp  r10,rcx;
		jae   whlGDS;
	cont_ite:
		mov	eax,dword[r10+18];
		and	eax,0xffff
		cmp	eax,'.';
		je 	ddt;
		mov	eax,dword[r10+18];
		and	eax,0xffffff;
		cmp	eax,'..';		
		je	ddt;
		push	r8;	
		mov	rdi,r8;
		lea	rsi,[r10+18];
		cplblp:
			lodsb
			stosb
			cmp  al,0
			jne cplblp
		lea     r8,[rdi-1];	
		push 	r9; filedescriptor
		push 	r10; iterator
		push 	rcx; limit
		call	_find
		pop 	rcx;
		pop	r10;
		pop	r9;
		pop	r8;
		ddt:
		xor	rdi,rdi;
		mov	di,word[r10+16];
		add	r10,rdi;
		jmp	iteL;
    end_whlGDS:
    dec   r8;
    mov   byte[r8],0;
    mov   rax,3;
    mov   rdi,r9;
    syscall;	
    add   rsp,1024;
    ret;    
_printf:
    mov     rax,1;
    mov     rdi,1; write(int fd,char* buf,int len);
    mov     rsi,buffer;
    mov     rdx,r8;
    sub	    rdx,buffer;
    syscall;
    ret;
