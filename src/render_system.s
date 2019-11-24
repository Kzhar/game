;
;RENDER SYSTEM
;
;==============================
;GLOBAL 
;==============================


;==============================
;;INCLUDES
;==============================
.include "entity_manager.h.s"
.include "cpct_functions.h.s"

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
	ld c, e_x(ix)		; C => X position of the entity 
	ld b, e_y(ix)		; B => Y position of the entity 
	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
	
	ex de, hl 			;
	ld a, e_col(ix)			;Color
	ld c, e_w(ix)			;Entity Width
	ld b, e_h(ix)			;Entiy Height
	call cpct_drawSolidBox_asm

	pop af

	dec a
	ret z

	ld bc, #sizeof_e
	add ix, bc
	jr _renloop


