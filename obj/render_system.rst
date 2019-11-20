ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;RENDER SYSTEM
                              3 ;
                              4 
   4067                       5 rendersys_init::
   4067 C9            [10]    6 	ret
                              7 ;;=====================================
                              8 ;;IMPUT
                              9 ;;	IX: Pointer to first entity to render 
                             10 ;;	A: Number of entities to render
                             11 ;;===================================
   4068                      12 rendersys_update::
                             13 
   4068                      14 _renloop:
   4068 F5            [11]   15 	push af
                             16 	;; Calculate a video-memory location for printing a string
   4069 11 00 C0      [10]   17 	ld de, #0xC000  	;DE => Pointer to the start of screen video-memory
   406C DD 4E 00      [19]   18 	ld c, 0(ix)		; C => X position of the entity 
   406F DD 46 01      [19]   19 	ld b, 1(ix)		; B => Y position of the entity 
   4072 CD 40 41      [17]   20 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
                             21 	
   4075 EB            [ 4]   22 	ex de, hl 			;
   4076 DD 7E 06      [19]   23 	ld a, 6(ix)			;Color
   4079 DD 4E 02      [19]   24 	ld c, 2(ix)			;Entity Width
   407C DD 46 03      [19]   25 	ld b, 3(ix)			;Entiy Height
   407F CD 9C 40      [17]   26 	call cpct_drawSolidBox_asm
                             27 
   4082 F1            [10]   28 	pop af
                             29 
   4083 3D            [ 4]   30 	dec a
   4084 C8            [11]   31 	ret z
                             32 
   4085 01 07 00      [10]   33 	ld bc, #entity_size
   4088 DD 09         [15]   34 	add ix, bc
   408A 18 DC         [12]   35 	jr _renloop
                             36 
                             37 
