
	.data
	.type	v, %object
	.type	n, %object
	.size	v, 8
	.size	n, 1

n:
	.xword 8

v:
	.xword 79, 55, 94, 48, 19, 13, 45, 21

	.text
	.global main
	.arch armv8-a+fp+simd
	.type main, %function

main:
			ADRP	X0, v				//get the address of array v
			ADD		X0, X0, :lo12:v
			ADRP	X4, n				//get address of n
			ADD		X4, X4,	:lo12:n
			LDUR	X4, [X4, #0]		//load n(7) into X4
			SUB		X3, X3, X3			//initialize i to 0
			SUB		X8, X8, X8			//initialize sum to 0
			SUB		X9, X9, X9			//initialize large to 0
			SUB		X10, X10, X10		//initialize small to 0
			ADD		X10, X10, #100		//set small to a value larger than array


	loop:	LDUR	X2, [X0, #0]		//load v[i] into X2
			ADD		X8, X8, X2			// sum = sum +v[i]
			SUBS	X6, X2, X9			// if a[i] > large
			B.LE	Else

	Then:	SUB		X9, X9, X9			//set large to 0
			ADD		X9, X9, X2			//set large to a[i]

	Else:	SUBS	X7, X10, X2			//if small > a[i]
			B.LE 	Check
			SUB		X10, X10, X10		//set small to 0
			ADD		X10, X10, X2		//set small to a[i]

	Check:	ADD		X3, X3, #1			//i = i + 1
			ADD		X0, X0, #8			//get next array element
			SUB		X5, X4, X3			//check if i < 8
			CBNZ	X5, loop			//if i < 8 repeat loop
Exit:
