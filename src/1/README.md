el tiempo se almacena en vector de 6 bytes 

char = byte --> strb / ldrb
short int = 2 bytes = 1 half-word --> ldrh / strh
int =~ 4 Bytes = word --> ldr / str

@calib
0x1000 xoff  | 0b0001 1111
0x1001 xoff  | 0b1000 0000
--
0x1002 yoff  | 0b1111 1111
0x1003 yoff  | 0b1111 1111

r0 0x0000 0000
ldrh r0, [#0x1000]
r0 = 0x0000 801F



r0 0x0000 0000
ldr r0, [#0x1000]
r0 = 0xFFFF 801F  @; xoff + yoff * 2^ 16



r0 0x0000 0000
ldrh r0, [#0x1002]
r0 = 0x0000 FFFF



char tiempo[6];

|              |

15 (natural bin) = 0b 0000 1111
15 (BCD) = 0b 0001 0101

06 (natural) =
 = 06 (BCD)

255 - 15 = 0b 1111 1111 - 0b 0000 1111 = 240
--> r0
and r1, r0, 0b 1111 0000  @; 0b XXXX 0000
mov r2, r1, lsr #4  @; 0b 0000 XXXX
mov r4, #10
mul r3, r2, r4  @; 10

and r2, r0, 0b 0000 1111  @; 15



add r0, r3, r2

return r0




