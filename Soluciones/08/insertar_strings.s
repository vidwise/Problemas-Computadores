@;
@; Author: Arey Ferrero Ramos
@;

		@; Rutina para insertar dos strings en el display LCD.
		@; R0 = str1.
		@; R1 = str2.
insertar_strings:
	push {r0-r3, lr}
	mov r2, r1
	mov r1, #0x080
	bl insertar_string
	mov r0, r2
	mov r1, #0x0C0
	bl insertar_string
	pop {r0-r3, pc}

