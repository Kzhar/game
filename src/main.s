;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"

.area _DATA
.area _CODE
;GLOBAL DECLARATIONS
;IMPORTANT!!!!!!!!!!!!!!!!!!!!!
;In build_config.mk we add -g flag in (Z80ASMFLAGS   := -l -o -s -g)
;Now all unknown call wil be taken by the assembler as GLOBAL
x: .db #11
y: .db #00

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm
loop: 
   ;; Calculate a video-memory location for printing a string
   ld de, #0xC000    ;DE => Pointer to the start of screen video-memory
   ld hl, #x         ;HL => points to x Memory direction
   ld b, (hl)        ;Load HL content in B
   inc (hl)
   inc hl            ;HL => points to the next memory direction (Y)
   ld c, (hl)        ;Load HL content in C
   inc (hl)
  

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

   ex de, hl 
   ld a, #0xFF
   ld bc, #0x0804
   call cpct_drawSolidBox_asm
 
   call cpct_waitVSYNC_asm
   halt
   halt 
   jr    loop