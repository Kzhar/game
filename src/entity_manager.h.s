;============================================================
;============================================================
;ENTITY MANAGER HEADER 
;============================================================ 
;============================================================

;global functions 
.globl entityman_create 
.globl entityman_getEntityArray_IX 
.globl entityman_getNumEntities_A 

;Global variables
.globl max_entities

; Entity Definiton macro
.macro DefineEntityAnonymous _x, _y, _vx, _vy, _w, _h, _color 
   .db _x 
   .db _y 
   .db _w 
   .db _h 
   .db _vx
   .db _vy 
   .db _color
.endm

.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color 
_name::
	DefineEntityAnonymous _x, _y, _vx, _vy, _w, _h, _color ;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.endm

e_x = 0
e_y = 1
e_w = 2
e_h = 3
e_vx = 4
e_vy = 5
e_col = 6
sizeof_e = 7


.macro DefineEntityArray _name, _N 
_name::
	.rept _N
		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
	.endm
.endm
