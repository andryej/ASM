BITS        64
      SECTION     .text
      GLOBAL      sort

sort:
      mov     rax,rdi
      mov     r8,rsi
      lea     rcx,[rdi+8*rsi-8]
      sar     r8,1
      mov     r8,[rdi+8*r8]
dwhl:
    whl1:
          cmp     [rax],r8
          jge     dnwhl1
          add     rax,8
          jmp whl1
    dnwhl1:

    whl2:
          cmp     r8,[rcx]
          jge     dnwhl2
          sub     rcx,8
          jmp whl2
    dnwhl2:

      cmp     rax,rcx
      ja      iff1

    mov     r9,[rcx]
      mov     r10,[rax]
    mov     [rax],r9
    add     rax,8
    mov     [rcx],r10

      sub     rcx,8
      cmp     rax,rcx
      ja      iff1
      jmp     dwhl
iff1:
      cmp     rcx,rdi
      jbe     iff2

      push    rsi
      push    rdi
      push    rax

      xor     rsi,rsi
      sub     rcx,rdi
      inc     rsi
      shr     rcx,3
      add     rsi,rcx

      call    sort

      pop     rax
      pop     rdi
      pop     rsi
iff2:
      lea     r10,[rdi+8*rsi-8]
      cmp     rax,r10
      jae     iff3


      lea     r8,[rdi+8*rsi]
      mov     rdi,rax
      sub     r8,rax
      shr     r8,3
      mov     rsi,r8

      call    sort
iff3:
      ret
