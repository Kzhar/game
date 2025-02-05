;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "entity_manager.h.s"
.include "render_system.h.s"
.include "cpct_functions.h.s"

.area _DATA
.area _CODE
;GLOBAL DECLARATIONS
 

;IMPORTANT!!!!!!!!!!!!!!!!!!!!!
;In build_config.mk we add -g flag in (Z80ASMFLAGS   := -l -o -s -g)
;Now all unknown call wil be taken by the assembler as GLOBAL

;DefineEntity player, 20, 20, 1, 1, 2,  8, 0xF0 
;DefineEntity enemy, 40, 80,-1, 0, 3, 12, 0xFF 

;player: .db 20, 20, 2,  8,  1, 1, 0xF0
;enemy:  .db 40, 80, 3, 12, -1, 0, 0xFF

_main::
   	;; Disable firmware to prevent it from interfering with string drawing
   	call cpct_disableFirmware_asm

	;Init Game Manager
	call man_game_init

	;Loop forever
	loop:
	call man_game_update
	;wait Vsync
	call cpct_waitVSYNC_asm
	call man_game_render

	jr loop

   ;;Init systems
   ;call rendersys_init

   ;ld hl, #player
   ;call entityman_create

   ;ld hl, #enemy
   ;call entityman_create

loop:
   ;;
   ;call entityman_getEntityArray_IX
   ;call entityman_getNumEntities_A
   ;call rendersys_update

   ;jr loop
