;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"

.area _DATA
.area _CODE
;GLOBAL DECLARATIONS
;IMPORTANT!!!!!!!!!!!!!!!!!!!!!
;In build_config.mk we add -g flag in (Z80ASMFLAGS   := -l -o -s -g)
;Now all unknown call wil be taken by the assembler as GLOBAL
x: .db #00
y: .db #00

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;; Calculate a video-memory location for printing a string
   ld de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld a, (x)
   ld b, a                   ;; B = y coordinate (24 = 0x18)
   ld a, (y)
   ld c, a                   ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

   ex de, hl 
   ld a, #0xFF
   ld bc, #0x0804
   call cpct_drawSolidBox_asm

   

loop:  
   jr    loop