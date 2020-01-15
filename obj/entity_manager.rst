ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;ENTITY MANAGER
                              3 ;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "entity_manager.h.s"
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



                              5 
                     0003     6 max_entities == 3
                              7 
                              8 
   4000 00                    9 _num_entities:: .db 0
   4001 03 40                10 _last_elem_ptr:: .dw _entity_array
                             11 
   4003                      12 DefineEntityArray _entity_array, max_entities
   0003                       1 _entity_array::
                              2 	.rept max_entities
                              3 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              4 	.endm
   0003                       1 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4003 DE                    1    .db 0xDE 
   4004 AD                    2    .db 0xAD 
   4005 DE                    3    .db 0xDE 
   4006 AD                    4    .db 0xAD 
   4007 DE                    5    .db 0xDE
   4008 AD                    6    .db 0xAD 
   4009 AA                    7    .db 0xAA
   000A                       1 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   400A DE                    1    .db 0xDE 
   400B AD                    2    .db 0xAD 
   400C DE                    3    .db 0xDE 
   400D AD                    4    .db 0xAD 
   400E DE                    5    .db 0xDE
   400F AD                    6    .db 0xAD 
   4010 AA                    7    .db 0xAA
   0011                       1 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4011 DE                    1    .db 0xDE 
   4012 AD                    2    .db 0xAD 
   4013 DE                    3    .db 0xDE 
   4014 AD                    4    .db 0xAD 
   4015 DE                    5    .db 0xDE
   4016 AD                    6    .db 0xAD 
   4017 AA                    7    .db 0xAA
                             13 	
                             14 ;.ds max_entities * sizeof_e 
                             15 
   4018                      16 entityman_getEntityArray_IX::
   4018 DD 21 03 40   [14]   17 	ld ix, #_entity_array
   401C C9            [10]   18 	ret
                             19 
   401D                      20 entityman_getNumEntities_A::
   401D 3A 00 40      [13]   21 	ld a, (_num_entities)
   4020 C9            [10]   22 	ret
                             23 ;====================================================
                             24 ;INPUT
                             25 ;	HL: Pointer to entity initialier byte (7 dates)
                             26 ;====================================================
   4021                      27 entityman_create::
                             28 
   4021 ED 5B 01 40   [20]   29 	ld de, (_last_elem_ptr)		;;
   4025 01 07 00      [10]   30 	ld bc, #sizeof_e		;;
   4028 ED B0         [21]   31 	ldir 				;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             32 
   402A 3A 00 40      [13]   33 	ld a, (_num_entities)
   402D 3C            [ 4]   34 	inc a
   402E 32 00 40      [13]   35 	ld (_num_entities), a
                             36 
   4031 2A 01 40      [16]   37 	ld hl, (_last_elem_ptr)
   4034 01 07 00      [10]   38 	ld bc, #sizeof_e
   4037 09            [11]   39 	add hl, bc
   4038 22 01 40      [16]   40 	ld (_last_elem_ptr), hl 
                             41 
   403B C9            [10]   42 	ret 
                             43 
