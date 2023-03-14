;-------------------------------------------------------------------------------
; gfx_oled - a library for basic graphics functions useful 
; for an oled display connected to the 1802-Mini computer via 
; the SPI Expansion Board.  These routines operate on pixels
; in a buffer used by the display.
;
;
; Copyright 2023 by Gaston Williams
;
; Based on code from the Elf-Elfos-OLED library
; Written by Tony Hefner
; Copyright 2022 by Tony Hefner
;
; Based on code from Adafruit_SH110X library
; Written by Limor Fried/Ladyada for Adafruit Industries  
; Copyright 2012 by Adafruit Industries
;
; SPI Expansion Board for the 1802/Mini Computer hardware
; Copyright 2022 by Tony Hefner 
;-------------------------------------------------------------------------------
#include    include/ops.inc
#include    include/gfx_display.inc

;-------------------------------------------------------
; Public routine - This routine files the buffer with
;   the byte $FF so that all pixels are set.
;-------------------------------------------------------

;-------------------------------------------------------
; Name: fill_buffer
;
; Fill the entire display buffer.
;
; Parameters: rf - pointer to display buffer.
;
; Return: (None)
;-------------------------------------------------------
            proc    fill_buffer
            PUSH    rf                ; save buffer ptr            
            PUSH    rc                ; save counter
            LOAD    rc, BUFFER_SIZE   ; set counter
             
fb_loop:    ldi     $FF
            str     rf
            inc     rf
            dec     rc
            LBRNZ   rc, fb_loop

            POP     rc
            POP     rf
            
            CLC               ; make sure DF = 0            
            RETURN

            endp
