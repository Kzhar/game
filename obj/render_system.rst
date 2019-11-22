ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;RENDER SYSTEM
                              3 ;
                              4 ;==============================
                              5 ;GLOBAL 
                              6 ;==============================
                              7 .globl cpct_getScreenPtr_asm
                              8 .globl cpct_drawSolidBox_asm 
                              9 
                             10 ;==============================
                             11 ;;INCLUDES
                             12 ;==============================
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             13 .include "entity_manager.h.s"
                              1 ;============================================================
                              2 ;============================================================
                              3 ;ENTITY MANAGER HEADER 
                              4 ;============================================================ 
                              5 ;============================================================
                              6 
                              7 .globl entityman_create 
                              8 .globl entityman_getEntityArray_IX 
                              9 .globl entityman_getNumEntities_A 
                             10 
                             11 .globl entity_size 
                             12 .globl max_entities
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
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
   406C DD 4E 00      [19]   28 	ld c, 0(ix)		; C => X position of the entity 
   406F DD 46 01      [19]   29 	ld b, 1(ix)		; B => Y position of the entity 
   4072 CD 40 41      [17]   30 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
                             31 	
   4075 EB            [ 4]   32 	ex de, hl 			;
   4076 DD 7E 06      [19]   33 	ld a, 6(ix)			;Color
   4079 DD 4E 02      [19]   34 	ld c, 2(ix)			;Entity Width
   407C DD 46 03      [19]   35 	ld b, 3(ix)			;Entiy Height
   407F CD 9C 40      [17]   36 	call cpct_drawSolidBox_asm
                             37 
   4082 F1            [10]   38 	pop af
                             39 
   4083 3D            [ 4]   40 	dec a
   4084 C8            [11]   41 	ret z
                             42 
   4085 01 07 00      [10]   43 	ld bc, #entity_size
   4088 DD 09         [15]   44 	add ix, bc
   408A 18 DC         [12]   45 	jr _renloop
                             46 
                             47 
