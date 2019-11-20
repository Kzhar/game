;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"

.area _DATA
.area _CODE
;GLOBAL DECLARATIONS
;IMPORTANT!!!!!!!!!!!!!!!!!!!!!
;In build_config.mk we add -g flag in (Z80ASMFLAGS   := -l -o -s -g)
;Now all unknown call wil be taken by the assembler as GLOBAL
;x: .db #11
;y: .db #00

player: .db 20, 20, 2,  8,  1, 1, 0xF0
enemy:  .db 40, 80, 3, 12, -1, 0, 0xFF

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;;Init systems
   call rendersys_init

   ld hl, #player
   call entityman_create

   ld hl, #enemy
   call entityman_create

loop:
   ;;
   call enetityman_getEntityArray_IX
   call enetityman_getNumEntities_A
   call rendersys_update

   jr loop
