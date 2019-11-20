ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;ENTITY MANAGER
                              3 ;
                     0003     4 max_entities == 3
                     0007     5 entity_size  == 7		;x, y, w, h, vx, vy, color 
                              6 
   4050 00                    7 _num_entities:: .db 00
   4051 53 40                 8 _last_elem_ptr:: .dw _entity_array
   4053                       9 _entity_array::
   4053                      10 	.ds max_entities * entity_size 
                             11 
   4068                      12 enetityman_getEntityArray_IX::
   4068 DD 21 53 40   [14]   13 	ld ix, #_entity_array
   406C C9            [10]   14 	ret
                             15 
   406D                      16 enetityman_getNumEntities_A::
   406D 3A 50 40      [13]   17 	ld a, (_num_entities)
   4070 C9            [10]   18 	ret
                             19 ;====================================================
                             20 ;INPUT
                             21 ;	HL: Pointer to entity initialier byte (7 dates)
                             22 ;====================================================
   4071                      23 entityman_create::
                             24 
   4071 ED 5B 51 40   [20]   25 	ld de, (_last_elem_ptr)
   4075 01 07 00      [10]   26 	ld bc, #entity_size
   4078 ED B0         [21]   27 	ldir 
                             28 
   407A 3A 50 40      [13]   29 	ld a, (_num_entities)
   407D 3C            [ 4]   30 	inc a
   407E 32 50 40      [13]   31 	ld (_num_entities), a
                             32 
   4081 2A 51 40      [16]   33 	ld hl, (_last_elem_ptr)
   4084 01 07 00      [10]   34 	ld bc, #entity_size
   4087 09            [11]   35 	add hl, bc
   4088 22 51 40      [16]   36 	ld (_last_elem_ptr), hl 
                             37 
   408B C9            [10]   38 	ret 
                             39 
