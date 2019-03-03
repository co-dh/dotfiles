TODO
====

    [ ] implement see with ndisam
    [ ] open file
    [ ] run file
    

Register Usage:
===============

   http://web.archive.org/web/20091028195159/http://www.colorforth.com/forth.html
   Data Stack: EAX, *ESI
   edx: address,
   esp: Return Stack
   edi: dword pointer to next word to be interpreted

Color:
=====

    http://web.archive.org/web/20091110113250/http://www.colorforth.com/parsed.html
    text in 32 bit word, bit 0-3 for color.
    1 execute yellow
    3 define red
    4 compile green
    7 compile cyan
    c variable magenta
    
    bit 4 : hex
    cyan macro: compiled only, not executed


next macro adr
 dec ecx
 jnz adr
endm

dup_ macro
 lea esi, [esi-4] ;8D76FC
 mov [esi], eax ; 8906
 endm

drop macro
 lodsd ; AD
endm

hp equ 1024
vp equ 768
vesa equ 117h
buffer equ 604*256
include boot.asm ; boot boot0 hard

; 100000 dictionary
;  a0000 top of return stack
;  9f800 top of data stack
;  9d800 free
;  97000 floppy buffer
;   4800 source

icons equ 12*256*4 ; 3000
warm:
 dup_

start1:
 call ati0                      ; Set up video-card memory.
 call show0                     ; Run "god" task for first time.
 mov forths, (forth1-forth0)/4 ; Remove additions to FORTH
 mov macros, (macro1-macro0)/4 ;   and MACRO wordlists.
 mov eax, 18                   ; Load and run block 18.
 call load
 jmp accept

: swap 168b 2, c28b0689 , ;

swap:  [esi] <-> eax  
00000000  8B16              mov edx,[esi]
00000002  8906              mov [esi],eax
00000004  8BC2              mov eax,edx

: 0 ?dup c031 2, ;
00000000  31C0              xor eax,eax


cdrop: ; compile drop,  list = h; *h++ = 0xad ; 
 mov edx, h
 mov list, edx
 mov byte ptr [edx], 0adh ; lodsd
 inc h
 ret:
     
; - negate     
00000000  F7D0              not eax
pop: 
00000000  58                pop eax


qdup: ;"?dup", add dup is previous is not drop. if (list == h-1) and *(h-1) == 0xad(DROP) h--; else cdup 
 mov edx, h               ; See if the last optimizable instruc-
 dec edx                  ;   tion was one byte back from the end
 cmp list, edx            ;   of the dictionary.
 jnz cdup                 ; If not, just compile a DUP.
 cmp byte ptr [edx], 0adh ; If so, was the instruction LODSD?
 jnz cdup                 ; If not, just compile a DUP.
 mov h, edx               ; If so, remove the LODSD and compile
 ret                      ;   nothing.

: pop ?dup 58 1, ;

dump (a)

