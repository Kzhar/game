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
   4025 00                    9 _num_entities:: .db 0
   4026 28 40                10 _last_elem_ptr:: .dw _entity_array
                             11 
   4028                      12 DefineEntityArray _entity_array, max_entities
   0003                       1 _entity_array::
                              2 	.rept max_entities
                              3 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
                              4 	.endm
   0003                       1 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4028 DE                    1    .db 0xDE 
   4029 AD                    2    .db 0xAD 
   402A DE                    3    .db 0xDE 
   402B AD                    4    .db 0xAD 
   402C DE                    5    .db 0xDE
   402D AD                    6    .db 0xAD 
   402E AA                    7    .db 0xAA
   000A                       1 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   402F DE                    1    .db 0xDE 
   4030 AD                    2    .db 0xAD 
   4031 DE                    3    .db 0xDE 
   4032 AD                    4    .db 0xAD 
   4033 DE                    5    .db 0xDE
   4034 AD                    6    .db 0xAD 
   4035 AA                    7    .db 0xAA
   0011                       1 		DefineEntityAnonymous 0xDE, 0xAD, 0xDE, 0xAD, 0xDE, 0xAD, 0xAA
   4036 DE                    1    .db 0xDE 
   4037 AD                    2    .db 0xAD 
   4038 DE                    3    .db 0xDE 
   4039 AD                    4    .db 0xAD 
   403A DE                    5    .db 0xDE
   403B AD                    6    .db 0xAD 
   403C AA                    7    .db 0xAA
                             13 	
                             14 ;.ds max_entities * sizeof_e 
                             15 
   403D                      16 entityman_getEntityArray_IX::
   403D DD 21 28 40   [14]   17 	ld ix, #_entity_array
   4041 C9            [10]   18 	ret
                             19 
   4042                      20 entityman_getNumEntities_A::
   4042 3A 25 40      [13]   21 	ld a, (_num_entities)
   4045 C9            [10]   22 	ret
                             23 ;====================================================
                             24 ;INPUT
                             25 ;	HL: Pointer to entity initialier byte (7 dates)
                             26 ;====================================================
   4046                      27 entityman_create::
                             28 
   4046 ED 5B 26 40   [20]   29 	ld de, (_last_elem_ptr)		;;
   404A 01 07 00      [10]   30 	ld bc, #sizeof_e		;;
   404D ED B0         [21]   31 	ldir 				;;
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             32 
   404F 3A 25 40      [13]   33 	ld a, (_num_entities)
   4052 3C            [ 4]   34 	inc a
   4053 32 25 40      [13]   35 	ld (_num_entities), a
                             36 
   4056 2A 26 40      [16]   37 	ld hl, (_last_elem_ptr)
   4059 01 07 00      [10]   38 	ld bc, #sizeof_e
   405C 09            [11]   39 	add hl, bc
   405D 22 26 40      [16]   40 	ld (_last_elem_ptr), hl 
                             41 
   4060 C9            [10]   42 	ret 
                             43 
