		.ORIG x0200

		;;  this calls a subroutine (function) that clears the screen
		JSR	CLEAR

		;;  this code draws a red dot in the center
		LD 	R5, RED
		STI	R5, CENTER

	;; WRITE THE REST OF YOUR PROGRAM HERE!
		LD R2, CENTER	;sets R2 as the location of the dot, initially center
		LD R3, RED		;sets R3 as the color of the dot, initially red
		; colors loaded as R5=Red, R6=Yellow, R7=Green
READ    LDI	R0, KBSR_ADDR	; R0 holds value at xFE00
	    BRzp	READ		; keep looping if it doesn’t start with 1
		; if we got here, we can read the key
        LDI R0, KBDR_ADDR	; read the key into R0
	;;COLOR checking
		;first we check if they pressed b
		LD R1, B			;load b into R1
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip b to -b and add to R0
		BRz BDOT			;if 0->b was pressed
		;else we check for g
		LD R1, G
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip g to -g and add to R0
		BRz GDOT			;if 0->g was pressed
		;else we check for r
		LD R1, R
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip r to -r and add to R0
		BRz RDOT			;if 0->r was pressed
	;;MOVEMENT checking
		;first we check to the right with d
		LD R1, D			;load s into R1
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip d to -d and add to R0
		BRz DMOVE			;if 0->d was pressed
		;next we check down with s
		LD R1, S			;load s into R1
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip s to -s and add to R0
		BRz SMOVE			;if 0->s was pressed
		;next left with a
		LD R1, A			;load a into R1
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip a to -a and add to R0
		BRz AMOVE			;if 0->a was pressed
		;finally move up with w
		LD R1, W			;load w into R1
		NOT R1, R1
		ADD R1, R1, #1
		ADD R1, R1, R0		;flip w to -w and add to R0
		BRz WMOVE			;if 0->w was pressed

		BR	READ			;else we wait
BDOT	LD R3, BLUE			;sets color to blue
		STR R3, R2, 0		;draws the blue dot
		BR 	READ
GDOT	LD R3, GREEN		;sets color to green
		STR R3, R2, 0		;draws green dot
		BR READ
RDOT	LD R3, RED			;sets color to red
		STR R3, R2, 0		;draws red dot in the center
		BR READ
DMOVE	LD R7, SIDEWALL
		ADD R6, R2, #1		;R6 is R2+1->can check if multiple of 128
		AND R7, R7, R6
		BRz READ
		AND R7, R7, 0		;sets R7 to 0->code for black
		STR	R7, R2, 0		;draws black dot, clearing current one
		ADD R2, R2, #1		;moves location to the right by 1	
		STR R3, R2,	0		;draws new dot there
		BR READ
SMOVE	LD R7, BOTTOM		;R7 is now bottom
		ADD R7, R7, R2		;R7 is bottom left pixel-current location
		BRzp	READ
		AND R7, R7, 0		;sets R7 to 0->code for black
		STR	R7, R2, 0		;draws black dot, clearing current one
		LD R7, DOWN
		ADD R2, R2, R7		;moves location to 1 down->x80	
		STR R3, R2,	0		;draws new dot there
		BR READ
AMOVE	LD R7, SIDEWALL
		AND R7, R7, R2
		BRz READ
		AND R7, R7, 0		;sets R7 to 0->code for black
		STR	R7, R2, 0		;draws black dot, clearing current one
		LD R7, LEFT
		ADD R2, R2, R7		;moves location to 1 left->xFFFF	
		STR R3, R2,	0		;draws new dot there
		BR READ
WMOVE	LD R7, TOP			;R7 is now top
		ADD R7, R7, R2		;R7 is topright pixel-current location
		BRnz	READ
		AND R7, R7, 0		;sets R7 to 0->code for black
		STR	R7, R2, 0		;draws black dot, clearing current one
		LD R7, UP
		ADD R2, R2, R7		;moves location to 1 up->xFF80	
		STR R3, R2,	0		;draws new dot there
		BR READ

		HALT

		;;  ADD OTHER VARIABLES/LABELS HERE!

CENTER	.FILL	xE040
RED		.FILL	x7C00
BLUE 	.FILL	x001F
GREEN	.FILL	x03E0
B 		.FILL   x0062
G 		.FILL	x0067
R 		.FILL	x0072
S 		.FILL 	x0073
D 		.FILL	x0064
A 		.FILL 	x0061
W 		.FILL	x0077
DOWN	.FILL	x0080
UP 		.FILL 	xFF80
LEFT	.FILL 	xFFFF
BOTTOM	.FILL	x0280	;the 2's complement of the bottom leftmost pixel
TOP		.FILL	x3F81	;the 2's complement of the top rightmost pixel
SIDEWALL	.FILL	x007F	;all 1s until 128->can check 128's multiples

KBSR_ADDR	.FILL		xFE00
KBDR_ADDR	.FILL		xFE02


	;;  This is a subroutine that clears the screen
	;;  You should not need to change this!
CLEAR	LD R7, END
	NOT R7, R7
	ADD R7, R7, #1
	AND R6, R6, #0
	LD R5, START
L1	STR R6, R5, #0
	ADD R5, R5, #1
	ADD R4, R5, R7
	BRnp L1
	RET
START	.FILL 	xC000
END	.FILL	xFDFF
	
	.END
