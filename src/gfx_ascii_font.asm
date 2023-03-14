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

;---------------------------------------------------------
; ASCII Font table - 5x7 bit bitmaps displayed on vertical 
;   line oled displays with one bit spacing to create 
;   6x8 bit characters. Printable ASCII characters from 
;   space toDEL (used for invalid chararacters) supported.    
;---------------------------------------------------------          
            proc    gfx_ascii_font
        db $00, $00, $00, $00, $00    ; 20   (space)
        db $00, $00, $5f, $00, $00    ; 21 !
        db $00, $07, $00, $07, $00    ; 22 "
        db $14, $7f, $14, $7f, $14    ; 23 #
        db $24, $2a, $7f, $2a, $12    ; 24 $
        db $23, $13, $08, $64, $62    ; 25 %
        db $36, $49, $55, $22, $50    ; 26 &
        db $00, $05, $03, $00, $00    ; 27 '
        db $00, $1c, $22, $41, $00    ; 28 (
        db $00, $41, $22, $1c, $00    ; 29 )
        db $14, $08, $3e, $08, $14    ; 2a *
        db $08, $08, $3e, $08, $08    ; 2b +
        db $00, $50, $30, $00, $00    ; 2c ,
        db $08, $08, $08, $08, $08    ; 2d -
        db $00, $60, $60, $00, $00    ; 2e .
        db $20, $10, $08, $04, $02    ; 2f /
        db $3e, $51, $49, $45, $3e    ; 30 0
        db $00, $42, $7f, $40, $00    ; 31 1
        db $42, $61, $51, $49, $46    ; 32 2
        db $21, $41, $45, $4b, $31    ; 33 3
        db $18, $14, $12, $7f, $10    ; 34 4
        db $27, $45, $45, $45, $39    ; 35 5
        db $3c, $4a, $49, $49, $30    ; 36 6
        db $01, $71, $09, $05, $03    ; 37 7
        db $36, $49, $49, $49, $36    ; 38 8
        db $06, $49, $49, $29, $1e    ; 39 9
        db $00, $36, $36, $00, $00    ; 3a colon
        db $00, $56, $36, $00, $00    ; 3b semicolon
        db $08, $14, $22, $41, $00    ; 3c <
        db $14, $14, $14, $14, $14    ; 3d =
        db $00, $41, $22, $14, $08    ; 3e >
        db $02, $01, $51, $09, $06    ; 3f ?
        db $32, $49, $79, $41, $3e    ; 40 @
        db $7e, $11, $11, $11, $7e    ; 41 A
        db $7f, $49, $49, $49, $36    ; 42 B
        db $3e, $41, $41, $41, $22    ; 43 C
        db $7f, $41, $41, $22, $1c    ; 44 D
        db $7f, $49, $49, $49, $41    ; 45 E
        db $7f, $09, $09, $09, $01    ; 46 F
        db $3e, $41, $49, $49, $7a    ; 47 G
        db $7f, $08, $08, $08, $7f    ; 48 H
        db $00, $41, $7f, $41, $00    ; 49 I
        db $20, $40, $41, $3f, $01    ; 4a J
        db $7f, $08, $14, $22, $41    ; 4b K
        db $7f, $40, $40, $40, $40    ; 4c L
        db $7f, $02, $0c, $02, $7f    ; 4d M
        db $7f, $04, $08, $10, $7f    ; 4e N
        db $3e, $41, $41, $41, $3e    ; 4f O
        db $7f, $09, $09, $09, $06    ; 50 P
        db $3e, $41, $51, $21, $5e    ; 51 Q
        db $7f, $09, $19, $29, $46    ; 52 R
        db $46, $49, $49, $49, $31    ; 53 S
        db $01, $01, $7f, $01, $01    ; 54 T
        db $3f, $40, $40, $40, $3f    ; 55 U
        db $1f, $20, $40, $20, $1f    ; 56 V
        db $3f, $40, $38, $40, $3f    ; 57 W
        db $63, $14, $08, $14, $63    ; 58 X
        db $07, $08, $70, $08, $07    ; 59 Y
        db $61, $51, $49, $45, $43    ; 5a Z
        db $00, $7f, $41, $41, $00    ; 5b [
        db $02, $04, $08, $10, $20    ; 5c backslash
        db $00, $41, $41, $7f, $00    ; 5d ]
        db $04, $02, $01, $02, $04    ; 5e ^
        db $40, $40, $40, $40, $40    ; 5f _
        db $00, $01, $02, $04, $00    ; 60 `
        db $20, $54, $54, $54, $78    ; 61 a
        db $7f, $48, $44, $44, $38    ; 62 b
        db $38, $44, $44, $44, $20    ; 63 c
        db $38, $44, $44, $48, $7f    ; 64 d
        db $38, $54, $54, $54, $18    ; 65 e
        db $08, $7e, $09, $01, $02    ; 66 f
        db $0c, $52, $52, $52, $3e    ; 67 g
        db $7f, $08, $04, $04, $78    ; 68 h
        db $00, $44, $7d, $40, $00    ; 69 i
        db $20, $40, $44, $3d, $00    ; 6a j 
        db $7f, $10, $28, $44, $00    ; 6b k
        db $00, $41, $7f, $40, $00    ; 6c l
        db $7c, $04, $18, $04, $78    ; 6d m
        db $7c, $08, $04, $04, $78    ; 6e n
        db $38, $44, $44, $44, $38    ; 6f o
        db $7c, $14, $14, $14, $08    ; 70 p
        db $08, $14, $14, $18, $7c    ; 71 q
        db $7c, $08, $04, $04, $08    ; 72 r
        db $48, $54, $54, $54, $20    ; 73 s
        db $04, $3f, $44, $40, $20    ; 74 t
        db $3c, $40, $40, $20, $7c    ; 75 u
        db $1c, $20, $40, $20, $1c    ; 76 v
        db $3c, $40, $30, $40, $3c    ; 77 w
        db $44, $28, $10, $28, $44    ; 78 x
        db $0c, $50, $50, $50, $3c    ; 79 y
        db $44, $64, $54, $4c, $44    ; 7a z
        db $00, $08, $36, $41, $00    ; 7b {
        db $00, $00, $7f, $00, $00    ; 7c |
        db $00, $41, $36, $08, $00    ; 7d }
        db $10, $08, $08, $10, $08    ; 7e ~
        db $00, $3C, $3C, $3C, $00    ; 7f DEL (block)
            endp
