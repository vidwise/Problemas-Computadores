RSI_timer0:

push{lr}

@; leemos bit 4 del registro, si es 1, lo desplazamos tanto como bits leidos sino nos saltamos la acumulacion
@; leemos marcas[MAX_FILAS] con num_filas, acumulamos nuestro resultado en el mismo sitio
@; acumulamos bits leidos con una or
@; sumamos 1 a los bits leidos
@; si llevamos 32 bits, desactivar timer


pop{pc}