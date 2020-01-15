.include "cpctelera.h.s"
.include "cpm/entity.h.s"
.include "sys/physics.h.s"
.include "sys/render.h.s"
.include "sys/input.h.s"
.include "man/entity.h.s"
.include "assets/assets.h.s"

.module game_manager ;????what is this?
;============================================================
;Manager Configuration Constants
;============================================================
;Manager member variables

ent1: DefineCmp_Entity   0,    0,    1,    2,  4,  16, sp_mainchar
ent2: DefineCmp_Entity  70,   40, 0xFF, 0xFE,  4,   8, sp_redball
ent3: DefineCmp_Entity	40,  120,    2, 0xFC,  5,  12, sp_sword

;============================================================
;Manager Public functions
;============================================================

man_game_init::
	;Init Entity Manager
	call man_entity_init

	;init systems
	call sys_eren_init
	call sys_physics_init
	call sys_input_init

	;Init 3 Test Entities
	ld hl, #ent1
	call man_entity_create
	ld hl, #ent2
	call man_entity_create
	ld hl, #ent3
	call man_entity_create

	ret

;==================================================
;Man Game Update
;Updates 1 Game Cycle doing everithing except the rendering.

man_game_update::
	call man_entity_getArray
	call sys_input_update
	call man_entity_getArray
	call sys_physics_update

	ret

;==================================================
;Man Game Render
;Does rendering process apart from game update

man_game_render::
	call man_entity_getArray
	call sys_eren_update

	ret







