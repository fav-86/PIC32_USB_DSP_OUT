/*
    *MIPS32 inpstructions assembler code
*/    
    
/* Input data structure    
volatile static struct {
    int *pCurr;		// destination curr pointer
    int *pEnd;		// destination end address
    int size;		// destination size in bytes
    int volumeL;	// volume value: min - 0, max - 0x40000000
    int volumeR;	// volume value: min - 0, max - 0x40000000
    int lfsr;		// LFSR random generate register
    int off;		// DC offset in 32-bit LSBs
} tAttCtrl;
*/
    
    
/* Global functions declarations */
.global dsp_att32_fmt
.global dsp_att32
.global dsp_att16
    
    
    
    
    
    
    
    
    
    
    
/*
    dsp_att32_fmt - read USB packet with 32bit samples, attenuate and write 32bit result to fir1 fifo 
    external declaration:     extern int dsp_att32_fmt(volatile void *pUsbFifo, int Size, volatile void *pAtt, void *pBuf);

    input:
    pFifo - USB FIFO data pointer ($a0)
    pVol - control structure pointer ($a1)
    Size - Size of USB packet in bytes ($a2)
    pBuf - pointer to DoP recognition buffer ($a3)

    output:
    pBuf - DoP recognition data buffer
    Return 1 if dest addr overflow detected, else return zero ($v0).

    Source data array must contain dual channel int32 data samples.
*/
dsp_att32_fmt:
    // load destination curr pointer
    LW $t0, 0($a2)
    // load destination end address
    LW $t1, 4($a2)
    // load destination size
    LW $t2, 8($a2)
    // load volume Left
    LW $t3, 12($a2)
    // load volume Right
    LW $t4, 16($a2)
    // load LFSR value
    LW $t5, 20($a2)
    // load offset
    LW $t6, 24($a2)
    
    // load one to dither multiply
    LI $t7, 1
    // load unity gain value to DC offset multiply
    LI $t8, 0x40000000
    // load result value
    LI $v0, 0
    
    // save size value
    SUBU $a1, $a1, 32
    SW $a1, 0($a2)
    
    // calc end pos
    ADDU $a1, $t0, 32
    // check buffer overflow
    BLTU $a1, $t1, .dsp_att32_fmt_loop1
    SUBU $a1, $a1, $t2
    ADDU $v0, 1
    
    .dsp_att32_fmt_loop1:
    // LFSR one shift processing with 0x00D80000 24bit polynome
    AND $v1, $t5, 0x100
    MUL $v1, $v1, 0x00D80000
    SRL $t5, $t5, 1
    XOR $t5, $t5, $v1
    // restore noise gain
    SRA $t9, $t5, 6
    
    // load from usb fifo input sample Left
    LW $v1, ($a0)
    // save to DoP data buffer
    SW $v1, 0($a3)
    // multiply data to volume coef
    MULT $ac0, $v1, $t3
    // sum dithering noise
    MADD $ac0, $t9, $t7
    // Summ DC offset
    MADD $ac0, $t6, $t8
    
    // load from usb fifo input sample Right
    LW $v1, ($a0)
    // save to DoP data buffer
    SW $v1, 4($a3)
    // multiply data to volume coef
    MULT $ac1, $v1, $t4
    // sum dithering noise
    MADD $ac1, $t9, $t7
    // Summ DC offset
    MADD $ac1, $t6, $t8
    
    // Restore gain & round with saturation & -12db attenuation Left
    EXTR_RS.W $v1, $ac0, 24
    // save result Left
    SW $v1, 0($t0)
    // Restore gain & round with saturation & -12db attenuation Right
    EXTR_RS.W $v1, $ac1, 24
    // save result Right
    SW $v1, 4($t0)
    
    // inc dest addr
    ADDU $t0, $t0, 8
    // inc buf addr
    ADDU $a3, $a3, 8
    // check buffer overflow
    BLTU $t0, $t1, .dsp_att32_fmt_p1
    SUBU $t0, $t0, $t2
    .dsp_att32_fmt_p1:
    // check end processing
    BNE $t0, $a1, .dsp_att32_fmt_loop1
    
    // restore size value
    LW $a1, 0($a2)
    
    // calc end pos
    ADDU $a1, $a1, $t0
    // check buffer overflow
    BLTU $a1, $t1, .dsp_att32_fmt_loop2
    // if overflow - calc new value
    SUBU $a1, $a1, $t2
    ADDU $v0, 1
    
    .dsp_att32_fmt_loop2:
    // LFSR one shift processing with 0x00D80000 24bit polynome
    AND $v1, $t5, 0x100
    MUL $v1, $v1, 0x00D80000
    SRL $t5, $t5, 1
    XOR $t5, $t5, $v1
    // restore noise gain
    SRA $t9, $t5, 6
    
    // load from usb fifo input sample Left
    LW $v1, ($a0)
    // multiply data to volume coef
    MULT $ac0, $v1, $t3
    // sum dithering noise
    MADD $ac0, $t9, $t7
    // Summ DC offset
    MADD $ac0, $t6, $t8
    
    // load from usb fifo input sample Right
    LW $v1, ($a0)
    // multiply data to volume coef
    MULT $ac1, $v1, $t4
    // sum dithering noise
    MADD $ac1, $t9, $t7
    // Summ DC offset
    MADD $ac1, $t6, $t8
    
    // Restore gain & round with saturation & -12db attenuation Left
    EXTR_RS.W $v1, $ac0, 24
    // save result Left
    SW $v1, 0($t0)
    // Restore gain & round with saturation & -12db attenuation Right
    EXTR_RS.W $v1, $ac1, 24
    // save result Right
    SW $v1, 4($t0)

    // inc dest addr
    ADDU $t0, $t0, 8
    // check buffer overflow
    BLTU $t0, $t1, .dsp_att32_fmt_p2
    SUBU $t0, $t0, $t2
    .dsp_att32_fmt_p2:
    // check end processing
    BNE $t0, $a1, .dsp_att32_fmt_loop2
    
    // save curr destination pointer
    SW $t0, 0($a2)
    // save LFSR value
    SW $t5, 20($a2)
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    dsp_att32 - read USB packet with 32bit samples, attenuate and write 32bit result to fir1 fifo 
    external declaration:     extern int dsp_att32(volatile void *pUsbFifo, int Size, volatile void *pAtt);

    input:
    pFifo - USB FIFO data pointer ($a0)
    pVol - control structure pointer ($a1)
    Size - Size of USB packet in bytes ($a2)

    output:
    Return 1 if dest addr overflow detected, else return zero ($v0).

    Source data array must contain dual channel int32 data samples.
*/
dsp_att32:
    // load destination curr pointer
    LW $t0, 0($a2)
    // load destination end address
    LW $t1, 4($a2)
    // load destination size
    LW $t2, 8($a2)
    // load volume Left
    LW $t3, 12($a2)
    // load volume Right
    LW $t4, 16($a2)
    // load LFSR value
    LW $t5, 20($a2)
    // load offset
    LW $t6, 24($a2)
    
    // load one to dither multiply
    LI $t7, 1
    // load unity gain value to DC offset multiply
    LI $t8, 0x40000000
    // load result value
    LI $v0, 0
    
    // calc end pos
    ADDU $a1, $a1, $t0
    // check buffer overflow
    BLTU $a1, $t1, .dsp_att32_loop
    // if overflow - calc new value
    SUBU $a1, $a1, $t2
    ADDU $v0, 1

    .dsp_att32_loop:
    // LFSR one shift processing with 0x00D80000 24bit polynome
    AND $v1, $t5, 0x100
    MUL $v1, $v1, 0x00D80000
    SRL $t5, $t5, 1
    XOR $t5, $t5, $v1
    // restore noise gain
    SRA $t9, $t5, 6
    
    // load from usb fifo input sample Left
    LW $v1, ($a0)
    // multiply data to volume coef
    MULT $ac0, $v1, $t3
    // sum dithering noise
    MADD $ac0, $t9, $t7
    // Summ DC offset
    MADD $ac0, $t6, $t8
    
    // load from usb fifo input sample Right
    LW $v1, ($a0)
    // multiply data to volume coef
    MULT $ac1, $v1, $t4
    // sum dithering noise
    MADD $ac1, $t9, $t7
    // Summ DC offset
    MADD $ac1, $t6, $t8
    
    // Restore gain & round with saturation & -12db attenuation Left
    EXTR_RS.W $v1, $ac0, 24
    // save result Left
    SW $v1, 0($t0)
    // Restore gain & round with saturation & -12db attenuation Right
    EXTR_RS.W $v1, $ac1, 24
    // save result Right
    SW $v1, 4($t0)
    
    // inc dest addr
    ADDU $t0, $t0, 8
    // check buffer overflow
    BLTU $t0, $t1, .dsp_att32_p1
    // if overflow - go to begin
    SUBU $t0, $t0, $t2
    .dsp_att32_p1:
    // check end processing
    BNE $t0, $a1, .dsp_att32_loop
    
    // save destination pointer
    SW $t0, 0($a2)
    // save LFSR value
    SW $t5, 20($a2)
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/*
    dsp_att16 - read USB packet with 16bit samples, attenuate and write 32bit result to fir1 fifo		
    external declaration:     extern int dsp_att16(volatile void *pUsbFifo, int Size, volatile void *pAtt);

    input:
    pFifo - USB FIFO data pointer ($a0)
    pVol - control structure pointer ($a1)
    Size - Size of USB packet in bytes ($a2)

    output:  
    Return 1 if dest addr overflow detected, else return zero ($v0).

    Source data array must contain dual channel int32 data samples.
*/
dsp_att16:
    // load destination curr pointer
    LW $t0, 0($a2)
    // load destination end address
    LW $t1, 4($a2)
    // load destination size
    LW $t2, 8($a2)
    // load volume Left
    LW $t3, 12($a2)
    // load volume Right
    LW $t4, 16($a2)
    // load LFSR value
    LW $t5, 20($a2)
    // load offset
    LW $t6, 24($a2)
    
    // load one to dither multiply
    LI $t7, 1
    // load unity gain value to DC offset multiply
    LI $t8, 0x00004000
    // load result value
    LI $v0, 0
    
    // calc end pos
    ADDU $a1, $a1, $t0
    // check buffer overflow
    BLTU $a1, $t1, .dsp_att16_loop
    // if overflow - calc new value
    SUBU $a1, $a1, $t2
    ADDU $v0, 1

    .dsp_att16_loop:
    // LFSR one shift processing with 0x00D80000 24bit polynome
    AND $v1, $t5, 0x100
    MUL $v1, $v1, 0x00D80000
    SRL $t5, $t5, 1
    XOR $t5, $t5, $v1
    // restore noise gain
    SRA $t9, $t5, 22
    
    // load half-word Left
    LH $v1, 0($a0)
    // multiply data to volume coef
    MULT $ac0, $v1, $t3
    // sum dithering noise
    MADD $ac0, $t9, $t7
    // Summ DC offset
    MADD $ac0, $t6, $t8
    
    // load half-word Right
    LH $v1, 2($a0)
    // multiply data to volume coef
    MULT $ac1, $v1, $t4
    // sum dithering noise
    MADD $ac1, $t9, $t7
    // Summ DC offset
    MADD $ac1, $t6, $t8
    
    // Restore gain & round with saturation & -12db attenuation Left
    EXTR_RS.W $v1, $ac0, 8
    // save result Left
    SW $v1, 0($t0)
    // Restore gain & round with saturation & -12db attenuation Right
    EXTR_RS.W $v1, $ac1, 8
    // save result Right
    SW $v1, 4($t0)
    
    // inc dest addr
    ADDU $t0, $t0, 8
    // check buffer overflow
    BLTU $t0, $t1, .dsp_att16_p1
    // if overflow - go to begin
    SUBU $t0, $t0, $t2
    .dsp_att16_p1:
    // check end processing
    BNE $t0, $a1, .dsp_att16_loop
    
    // save destination pointer
    SW $t0, 0($a2)
    // save LFSR value
    SW $t5, 20($a2)
    // restore address pointer
    J $ra
    
    
    
    
    

    
    
    
    
    
    
