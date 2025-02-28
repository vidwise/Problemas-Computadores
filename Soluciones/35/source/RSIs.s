@;
@; Author: Santiago Romaní Also
@; Solution author: Arey Ferrero Ramos
@; Merge with implementable problem by: Aleix Mariné-Tena
@;
@;=== RSIs.s: rutinas de servicio de interrupciones del programa  ===

.section .dtcm,"ax",%progbits
		
	.global mensajeRecibido
mensajeRecibido: .byte 0
		
	.global codigoMensaje
codigoMensaje: .space 1



.section .itcm,"ax",%progbits
		
	.align 2
	.arm
		
@;INT_instalarRSIPrincipal(u32* irq_handler, void* rsi, int mascara);
@;Rutina para copiar la direcci�n de una rsi principal dentro de la
@;posici�n para albergar dicha direcci�n que se especifica en el primer
@;par�metro;
@;Par�metros:
@;	irq_handler (R0):	0B00 3FFC para ARM9 (puede cambiar seg�n DTCM)
@;						03FF FFFC para ARM7
@;	rsi (R1):		direcci�n de la rsi principal
@;  mascara (R2):	bits activos indicando las interrupciones a atender 
@;C�digo:
	.global INT_instalarRSIPrincipal
INT_instalarRSIPrincipal:
		push {r1-r4, lr}
		
		ldr r4, =0x04000208		@; R4 = direcci�n REG_IME
		mov r3, #0
		strh r3, [r4]			@; desactivar interrupciones
		str r1, [r0]			@; instalar RSI principal
		ldr r1, =0x04000210		@; R1 = direcci�n REG_IE
		str r2, [r1]			@; guardar m�scara en REG_IE
		ldr r1, =0x04000214		@; R1 = direcci�n REG_IF
		mvn r2, #0				@; R2 = NOT(0) -> todos los bits a 1
		str r2, [r1]			@; ignora todas las peticiones pendientes
		mov r3, #1
		strh r3, [r4]			@; vuelve a activar las interrupciones
		
		pop {r1-r4, pc}



@;void rsi_principal(void);
@;Rutina de Servicio de Interrupciones principal: se encarga de llamar a las
@;RSI de cada dispositivo
@;C�digo:
	.global rsi_principal
rsi_principal:
		push {r0-r2, lr}
		
		ldr r0, =0x04000214		@; R0 apunta a REG_IF
		ldr r1, [r0]			@; R1 = valor de REG_IF
		tst r1, #0x00000001		@; verificar IRQ_VBLANK
		beq .Lno_VBlank
		bl rsi_vbl				@; llamar la RSI espec�fica
	.Lno_VBlank:
		tst r1, #0x00010000		@; verificar IRQ_IPCSYNC
		beq .Lno_IPCSync
		bl rsi_ipcsync			@; llamar la RSI espec�fica
	.Lno_IPCSync:
		ldr r2, =0x0B003FF8		@; R2 apunta a INTR_WAIT_FLAGS
		str r1, [r2]			@; marcar interrupciones atendidas en INTR_WAIT_FLAGS
		str r1, [r0]			@; marcar interrupciones atendidas en REG_IF			
		
		pop {r0-r2, pc}


@;void rsi_ipcsync(void);
@;Rutina de Servicio de Interrupciones de la sincronizaci�n entre procesadores;
@;actualiza las variables globales mesajeRecibido y codigoMensaje
@;C�digo:
rsi_ipcsync:
		push {r0, r1, lr}
		
		ldr r0, =mensajeRecibido
		mov r1, #1
		strb r1, [r0]			@; mensajeRecibido = 1;
		
		ldr r0, =0x4000180
		ldr r1, [r0]			@; R1 = contenido registro IPCSYNC
		and r1, #0x0F			@; filtrar los 4 bits bajos
		ldr r0, =codigoMensaje
		strb r1, [r0]			@; codigoMensaje = 4 bits bajos de IPCSYNC
		
		pop {r0, r1, pc}


@; rsi_vbl():	defines the interrupt service routine (ISR) which is fired
@;		every start of the vertical blank period, at around 60 Hz;
@;		at each activation, the ISR increases the current angle by a 
@;		given fraction (global variable), and updates the position of 
@;		sprite 0 if it gets a new integer angle; it also calls the
@;		activar_beat() routine, which starts the proper sound in case
@;		the sprite is on a beat mark.
@; RSI del vertical blank.
rsi_vbl:
    push {r0-r3, lr}

    ldr r1, =ang_actual
    ldr r0, [r1]
    ldr r2, =fraccion
    ldr r2, [r2]
    add r0, r2                   @; Se suma la fracción al índice 'ang_actual' para generar la nueva posición del vector de ángulos a la que se tendrá que acceder.

    mov r2, #360
    mov r2, r2, lsl #12          @; Se carga el valor 360 en formato Q12.
    cmp r0, r2                   @; Si se ha llegado al valor límite del índice 'ang_actual'
    subge r0, r2                 @; se le resta 360 (para mantener el valor acumulado de la fracción).
    str r0, [r1]
    mov r0, r0, lsr #12          @; Se elimina la parte decimal (Q12) del ángulo actual porque las posiciones de los vectores siempre deben ser enteras.

    ldr r3, =ang_pos             @; Se carga la dirección base del vector de ángulos.
    mov r0, r0, lsl #2
    ldrh r1, [r3, r0]            @; R1 = px (ángulo actual).
    add r0, #2
    ldrh r2, [r3, r0]            @; R2 = py (ángulo actual)
    bl SPR_moverSprite

    mov r0, #0x07000000		 @; R0 = OAM.
    mov r1, #1                   @; R1 = Número de sprites.
    bl SPR_actualizarSprites

    bl activar_beat              @; Se llama activar_beat desde la RSI (Justificación en el archivo 'activar_beat.md').

    pop {r0-r3, pc}

.end
