;
;RENDER SYSTEM
;
;==============================
;GLOBAL 
;==============================
.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm 

;==============================
;;INCLUDES
;==============================
.include "entity_manager.h.s"

rendersys_init::
	ret
;;=====================================
;;IMPUT
;;	IX: Pointer to first entity to render 
;;	A: Number of entities to render
;;===================================
rendersys_update::

_renloop:
	push af
	;; Calculate a video-memory location for printing a string
	ld de, #0xC000  	;DE => Pointer to the start of screen video-memory
	ld c, 0(ix)		; C => X position of the entity 
	ld b, 1(ix)		; B => Y position of the entity 
	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
	
	ex de, hl 			;
	ld a, 6(ix)			;Color
	ld c, 2(ix)			;Entity Width
	ld b, 3(ix)			;Entiy Height
	call cpct_drawSolidBox_asm

	pop af

	dec a
	ret z

	ld bc, #entity_size
	add ix, bc
	jr _renloop


