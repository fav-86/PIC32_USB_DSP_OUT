/*
    *MIPS32 inpstructions assembler code
*/
    
    
/* Global functions declarations */    
.global usb_rxcpy
.global dsp_scpy
.global dsp_cleare
    
    
    
    
    
    
/*
    usb_rxcpy - copy num bytes from USB FIFO pointer to pDst
     
    external declaration:     extern void usb_rxcpy(volatile void *pFifo, void *pDst, int num);

    input:
    pFifo - USB FIFO pointer ($a0)
    num - number bytes to copy ($a2)

    output:
    pDst - int result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
*/
usb_rxcpy:
    // calc quad samples num
    SRL $v0, $a2, 5
    SLL $v0, $v0, 5
    // calc quad samples end destination address    
    ADDU $v1, $a1, $v0
    J .usb_rx4cpy
    
    .usb_rx4cpy_loop:
    // load 4 sapmles
    LW $t0, ($a0)
    LW $t1, ($a0)
    LW $t2, ($a0)
    LW $t3, ($a0)
    LW $t4, ($a0)
    LW $t5, ($a0)
    LW $t6, ($a0)
    LW $t7, ($a0)
    // save 4 samples
    SW $t0, 0($a1)
    SW $t1, 4($a1)
    SW $t2, 8($a1)
    SW $t3, 12($a1)
    SW $t4, 16($a1)
    SW $t5, 20($a1)
    SW $t6, 24($a1)
    SW $t7, 28($a1)
    // address inc
    ADDU $a1, $a1, 32
    .usb_rx4cpy:
    BLTU $a1, $v1, .usb_rx4cpy_loop
    
    // calc single samples num
    SUBU $v0, $a2, $v0
    // calc end destination address
    ADDU $v1, $a1, $v0
    J .usb_rx1cpy
    
    .usb_rx1cpy_loop:
    // load 1 sapmle
    LW $t0, ($a0)
    LW $t1, ($a0)
    // save 1 sample
    SW $t0, 0($a1)
    SW $t1, 4($a1)
    // address inc
    ADDU $a1, $a1, 8
    .usb_rx1cpy:
    BLTU $a1, $v1, .usb_rx1cpy_loop

    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
/*
    dsp_scpy - copy even num 32-bit words from address pSrc to pDst
     
    external declaration:     extern void dsp_scpy(void *pSrc, void *pDst, int num);

    input:
    pSrc - int source data pointer ($a0)
    num - num of bytes to copy ($a2)

    output:
    pDst - int result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
*/
dsp_scpy:
    // calc quad samples bytes num
    SRL $v0, $a2, 5
    SLL $v0, $v0, 5
    // calc quad samples end destination address    
    ADDU $v1, $a1, $v0
    J .dsp_s4cpy
    
    .dsp_s4cpy_loop:
    // load 4 samples
    LW $t0, 0($a0)
    LW $t1, 4($a0)
    LW $t2, 8($a0)
    LW $t3, 12($a0)
    LW $t4, 16($a0)
    LW $t5, 20($a0)
    LW $t6, 24($a0)
    LW $t7, 28($a0)
    // save 4 samples
    SW $t0, 0($a1)
    SW $t1, 4($a1)
    SW $t2, 8($a1)
    SW $t3, 12($a1)
    SW $t4, 16($a1)
    SW $t5, 20($a1)
    SW $t6, 24($a1)
    SW $t7, 28($a1)
    // address inc
    ADDU $a0, $a0, 32
    ADDU $a1, $a1, 32
    .dsp_s4cpy:
    BLTU $a1, $v1, .dsp_s4cpy_loop
    
    // calc single samples num
    SUBU $v0, $a2, $v0
    // calc end destination address
    ADDU $v1, $a1, $v0
    J .dsp_s1cpy
    
    .dsp_s1cpy_loop:
    // load 1 sapmle
    LW $t0, 0($a0)
    LW $t1, 4($a0)
    // save 1 sample
    SW $t0, 0($a1)
    SW $t1, 4($a1)
    // address inc
    ADDU $a0, $a0, 8
    ADDU $a1, $a1, 8
    .dsp_s1cpy:
    BLTU $a1, $v1, .dsp_s1cpy_loop

    // restore address pointer
    J $ra

    
    
    
    
    
    
    
/*
    dsp_cleare - write destination pDst with value "Zero"
     
    external declaration:     extern void dsp_cleare(void *pDst, int Size);

    input:
    Size - destination size in bytes (must be multiple by 8 (1 sample)) ($a1)
     
    output:
    pDst - destination pointer ($a0)
*/
dsp_cleare:
    
    // calc 16 samples bytes num
    SRL $a2, $a1, 7
    SLL $a2, $a2, 7
    // calc end destination address    
    ADDU $v1, $a0, $a2
    // go to start
    J .dsp_clr16_start
    
    .dsp_clr16_loop:
    // cleare 16 samples
    SW $zero, 0($a0)
    SW $zero, 4($a0)
    SW $zero, 8($a0)
    SW $zero, 12($a0)
    SW $zero, 16($a0)
    SW $zero, 20($a0)
    SW $zero, 24($a0)
    SW $zero, 28($a0)
    SW $zero, 32($a0)
    SW $zero, 36($a0)
    SW $zero, 40($a0)
    SW $zero, 44($a0)
    SW $zero, 48($a0)
    SW $zero, 52($a0)
    SW $zero, 56($a0)
    SW $zero, 60($a0)
    SW $zero, 64($a0)
    SW $zero, 68($a0)
    SW $zero, 72($a0)
    SW $zero, 76($a0)
    SW $zero, 80($a0)
    SW $zero, 84($a0)
    SW $zero, 88($a0)
    SW $zero, 92($a0)
    SW $zero, 96($a0)
    SW $zero, 100($a0)
    SW $zero, 104($a0)
    SW $zero, 108($a0)
    SW $zero, 112($a0)
    SW $zero, 116($a0)
    SW $zero, 120($a0)
    SW $zero, 124($a0)
    // address inc
    ADDU $a0, $a0, 128
    .dsp_clr16_start:
    BLTU $a0, $v1, .dsp_clr16_loop
    
    // calc single samples num
    SUBU $a2, $a1, $a2
    // calc end destination address
    ADDU $v1, $a0, $a2
    // go to start
    J .dsp_clr1_start
    
    .dsp_clr1_loop:
    // cleare 1 sample
    SW $zero, 0($a0)
    SW $zero, 4($a0)
    // address inc
    ADDU $a0, $a0, 8
    .dsp_clr1_start:
    BLTU $a0, $v1, .dsp_clr1_loop
    
    // restore address pointer
    J $ra