/* Declaraciones de rutinas de gesti�n de RSIs */

extern unsigned char mensajeRecibido;
extern unsigned char codigoMensaje;

extern void INT_instalarRSIPrincipal(u32* irq_handler, void* rsi, int mascara);
extern void rsi_principal(void);
