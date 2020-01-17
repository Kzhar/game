;
;ENTITY MANAGER
;
;.include "entity_manager.h.s"
.include "cmp/array_structure.h.s"
.include "man/entity.h.s"
.include "cmp/entity.h.s"
.include "assets/assets.h.s"
.include "cpctelera.h.s"

.module entity_manager

;==============================
;Manager Member Variables
;==============================
;Entity components

DefineComponentArrayStructure _entity, max_entities, DefineCmp_Entity_default

;MANAGER PUBLIC FUNCTIONS
;============================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Man_entity_getArray
;Gets a pointer to the array of entities in IX and also the number of entities in A

man_entity_getArray::
	ld	ix, #_entity_array
	ld	a, (_entity_num)
	ret
;Man_entity_Init
;Initializes the entity manager. It ser ups everything with 0 eneitites and ready to start creating new ones

man_entity_init::
	;;reset all component vector values
	xor	a			;entity num = 0
	ld	(_entity_num), a	;set number of entities to zero

	ld	hl, #entity_array
	ld 	(_entity_pend), hl	;entity pointer poitns to first(last?) entity of the array (empty array)

	ret

;====================================================
;RETURN:
;	DE Points to added element
;	BC Sizeof (Entity_t)
;====================================================

man_entity_new::
	ld  hl, #_entity_num
	inc (hl)			;_entity_num++

	ld hl, (_entity_pend)
	ld d, h
	ld e, l				;DE = HL 

	ld bc, #sizeof_e
	add hl, bc			;next entity pointer to the last entity + size of each entity
	ld (_entity_pend), hl		;Store pend pointer updated
;====================================================
;INPUT
;	HL: Pointer to entity initialier byte (7 dates)
;====================================================
man_entity_create::
	push hl
	call man_entity_new

	ld__ixh_d
	ld__ixl_e	;IX=DE

	;copy initialization values to new entity
	;DE points to the new added entity
	;BC holds sizeof(entity_t)
	;copy initialization values

	pop hl
	ldir		;transfer a byte of data from memory location pointed by hl to the memory location pointed by de (bc times)

	ret
	
;entityman_create::

;	ld de, (_last_elem_ptr)		;;
;	ld bc, #sizeof_e		;;
;	ldir 				;;

;	ld a, (_num_entities)
;	inc a
;	ld (_num_entities), a

;	ld hl, (_last_elem_ptr)
;	ld bc, #sizeof_e
;	add hl, bc
;	ld (_last_elem_ptr), hl 

;	ret 

