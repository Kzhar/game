ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;RENDER SYSTEM
                              3 ;
                              4 ;==============================
                              5 ;GLOBAL 
                              6 ;==============================
                              7 
                              8 
                              9 ;==============================
                             10 ;;INCLUDES
                             11 ;==============================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             12 .include "entity_manager.h.s"
                              1 ;============================================================
                              2 ;============================================================
                              3 ;ENTITY MANAGER HEADER 
                              4 ;============================================================ 
                              5 ;============================================================
                              6 
                              7 ;global functions 
                              8 .globl entityman_create 
                              9 .globl entityman_getEntityArray_IX 
                             10 .globl entityman_getNumEntities_A 
                             11 
                             12 ;Global variables
                             13 .globl max_entities
                             14 
                             15 ; Entity Definiton macro
                             16 .macro DefineEntityAnonymous _x, _y, _vx, _vy, _w, _h, _color 
                             17    .db _x 
                             18    .db _y 
                             19    .db _w 
                             20    .db _h 
                             21    .db _vx
                             22    .db _vy 
                             23    .db _color
                             24 .endm
                             25 
                             26 .macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _color 
                             27 _name::
                             28 	DefineEntityAnonymous _x, _y, _vx, _vy, _w, _h, _color ;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             29 .endm
                             30 
                     0000    31 e_x = 0
                     0001    32 e_y = 1
                     0002    33 e_w = 2
                     0003    34 e_h = 3
                     0004    35 e_vx = 4
                     0005    36 e_vy = 5
                     0006    37 e_col = 6
                     0007    38 sizeof_e = 7
                             39 
                             40 
                             41 .macro DefineEntityArray _name, _N 
                             42 _name::
                             43 	.rept _N
                             44 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                             45 	.endm
                             46 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             13 .include "cpct_functions.h.s"
                              1 ;;=======================================================
                              2 ;;=======================================================
                              3 ;;CPCTELERA GLOBAL FUNCTIONS
                              4 ;;=======================================================
                              5 ;;=======================================================
                              6 
                              7 .globl cpct_getScreenPtr_asm
                              8 .globl cpct_drawSolidBox_asm 
                              9 .globl cpct_disableFirmware_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             14 
   4067                      15 rendersys_init::
   4067 C9            [10]   16 	ret
                             17 ;;=====================================
                             18 ;;IMPUT
                             19 ;;	IX: Pointer to first entity to render 
                             20 ;;	A: Number of entities to render
                             21 ;;===================================
   4068                      22 rendersys_update::
                             23 
   4068                      24 _renloop:
   4068 F5            [11]   25 	push af
                             26 	;; Calculate a video-memory location for printing a string
   4069 11 00 C0      [10]   27 	ld de, #0xC000  	;DE => Pointer to the start of screen video-memory
   406C DD 4E 00      [19]   28 	ld c, e_x(ix)		; C => X position of the entity 
   406F DD 46 01      [19]   29 	ld b, e_y(ix)		; B => Y position of the entity 
   4072 CD 40 41      [17]   30 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
                             31 	
   4075 EB            [ 4]   32 	ex de, hl 			;
   4076 DD 7E 06      [19]   33 	ld a, e_col(ix)			;Color
   4079 DD 4E 02      [19]   34 	ld c, e_w(ix)			;Entity Width
   407C DD 46 03      [19]   35 	ld b, e_h(ix)			;Entiy Height
   407F CD 9C 40      [17]   36 	call cpct_drawSolidBox_asm
                             37 
   4082 F1            [10]   38 	pop af
                             39 
   4083 3D            [ 4]   40 	dec a
   4084 C8            [11]   41 	ret z
                             42 
   4085 01 07 00      [10]   43 	ld bc, #sizeof_e
   4088 DD 09         [15]   44 	add ix, bc
   408A 18 DC         [12]   45 	jr _renloop
                             46 
                             47 
