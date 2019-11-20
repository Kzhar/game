ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;
                              2 ;RENDER SYSTEM
                              3 ;
                              4 
   4000                       5 rendersys_init::
   4000 C9            [10]    6 	ret
                              7 ;;=====================================
                              8 ;;IMPUT
                              9 ;;	IX: Pointer to first entity to render 
                             10 ;;	A: Number of entities to render
                             11 ;;===================================
   4001                      12 rendersys_update::
                             13 
   4001                      14 _render_loop:
   4001 F5            [11]   15 	push af
                             16 	;; Calculate a video-memory location for printing a string
   4002 11 00 C0      [10]   17 	ld de, #0xC000  	;DE => Pointer to the start of screen video-memory
   4005 DD 4E 00      [19]   18 	ld c, 0(ix)		; C => X position of the entity 
   4008 DD 46 01      [19]   19 	ld b, 1(ix)		; B => Y position of the entity 
   400B CD 40 41      [17]   20 	call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in 
                             21 	
   400E EB            [ 4]   22 	ex de, hl 			;
   400F DD 7E 06      [19]   23 	ld a, 6(ix)			;Color
   4012 DD 4E 02      [19]   24 	ld c, 2(ix)			;Entity Width
   4015 DD 46 03      [19]   25 	ld b, 3(ix)			;Entiy Height
   4018 CD 9C 40      [17]   26 	call cpct_drawSolidBox_asm
                             27 
   401B F1            [10]   28 	pop af
                             29 
   401C 3D            [ 4]   30 	dec a
   401D C8            [11]   31 	ret z
                             32 
   401E 01 07 00      [10]   33 	ld bc, #entity_size
   4021 DD 09         [15]   34 	add ix, bc
   4023 18 DC         [12]   35 	jr _render_loop
                             36 
                             37 
