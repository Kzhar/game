ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;ENTITY MANAGER
                              3 ;
                     0003     4 max_entities == 3
                     0007     5 entity_size  == 7		;x, y, w, h, vx, vy, color 
                              6 
   402B 00                    7 _num_entities:: .db 00
   402C 2E 40                 8 _last_elem_ptr:: .dw _entity_array
   402E                       9 _entity_array::
   402E                      10 	.ds max_entities * entity_size 
                             11 
   4043                      12 entityman_getEntityArray_IX::
   4043 DD 21 2E 40   [14]   13 	ld ix, #_entity_array
   4047 C9            [10]   14 	ret
                             15 
   4048                      16 entityman_getNumEntities_A::
   4048 3A 2B 40      [13]   17 	ld a, (_num_entities)
   404B C9            [10]   18 	ret
                             19 ;====================================================
                             20 ;INPUT
                             21 ;	HL: Pointer to entity initialier byte (7 dates)
                             22 ;====================================================
   404C                      23 entityman_create::
                             24 
   404C ED 5B 2C 40   [20]   25 	ld de, (_last_elem_ptr)		;;
   4050 01 07 00      [10]   26 	ld bc, #entity_size		;;
   4053 ED B0         [21]   27 	ldir 				;;
                             28 
   4055 3A 2B 40      [13]   29 	ld a, (_num_entities)
   4058 3C            [ 4]   30 	inc a
   4059 32 2B 40      [13]   31 	ld (_num_entities), a
                             32 
   405C 2A 2C 40      [16]   33 	ld hl, (_last_elem_ptr)
   405F 01 07 00      [10]   34 	ld bc, #entity_size
   4062 09            [11]   35 	add hl, bc
   4063 22 2C 40      [16]   36 	ld (_last_elem_ptr), hl 
                             37 
   4066 C9            [10]   38 	ret 
                             39 
