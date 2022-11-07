section	.text

	global load_gdt
        global reloadSegments
load_gdt:
        cli
        MOV   [gdtr], DI
        MOV  [gdtr+2], RSI
        LGDT  [gdtr] ;load gdt into cpu.
        ret
reloadSegments:
        ; Reload CS register:
        PUSH 0x28                 ; Push code segment to stack, 0x08 is a stand-in for your code segment
        LEA RAX, [rel .reload_CS] ; Load address of .reload_CS into RAX
        PUSH RAX                  ; Push this value to the stack
        RETFQ                     ; Perform a far return, RETFQ or LRETQ depending on syntax
.reload_CS:
        ; Reload data segment registers
        MOV   AX, 0x30 ; 0x10 is a stand-in for your data segment
        MOV   DS, AX
        MOV   ES, AX
        MOV   FS, AX
        MOV   GS, AX
        MOV   SS, AX
        RET


section	.data
gdtr DW 0
DQ 0 
