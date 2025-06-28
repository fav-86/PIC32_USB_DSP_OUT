/*
    *MIPS32 inpstructions assembler code
*/
    
    
/* Global functions declarations */
.global fir1_5842
.global fir2_5842
.global fir3_5842

    
    
    
    
/*
typedef struct {
    
    
} tFIR_CTRL;
    
*/
    
    
    

/*
    fir1_5842 - FIR x2 half-band upsampler (1-st stage of SM5842)
	with 12db attenuation to saturation
     
    external declaration:     extern void fir1_5842(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)
     
    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 1 dual channel sample, upsample and return 2 dual channel samples
    with 6db attenuation.
*/ 
fir1_5842:
    .fir1_5842_beg:
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 576
    BLTU $t9, $a2, .fir1_5842_p1
    SUBU $t9, $t9, $a3
    .fir1_5842_p1:
    
    // load coef 1
    LI $v0, -12
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 88($t9)
    LW $t5, 96($t9)
    LW $t6, 104($t9)
    LW $t7, 112($t9)
    // multiply 4 samples to coef 1
    MULT $ac0, $t0, $v0
    MULT $ac1, $t1, $v0
    MULT $ac2, $t2, $v0
    MULT $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 2
    LI $v0, 26
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
    // multiply 4 samples to coef 2
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 3
    LI $v0, -52
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
    // multiply 4 samples to coef 3
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 4
    LI $v0, 95
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
    // multiply 4 samples to coef 4
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 5
    LI $v0, -163
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
    // multiply 4 samples to coef 5
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 6
    LI $v0, 265
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 6
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 7
    LI $v0, -414
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 7
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 8
    LI $v0, 626
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 8
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 9
    LI $v0, -918
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 9
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 10
    LI $v0, 1316
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 10
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 11
    LI $v0, -1846
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 11
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 12
    LI $v0, 2542
    // load next samples
    LW $t2, 112($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 12
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load address row 1 & check addr overflow
    ADDU $t8, $a0, 96
    BLTU $t8, $a2, .fir1_5842_p2
    SUBU $t8, $t8, $a3
    .fir1_5842_p2:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 480
    BLTU $t9, $a2, .fir1_5842_p3
    SUBU $t9, $t9, $a3
    .fir1_5842_p3:
    
    // load coef 13
    LI $v0, -3440
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 88($t9)
    // multiply 4 samples to coef 13
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 14
    LI $v0, 4587
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
    // multiply 4 samples to coef 14
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 15
    LI $v0, -6031
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
    // multiply 4 samples to coef 15
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 16
    LI $v0, 7831
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
    // multiply 4 samples to coef 16
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 17
    LI $v0, -10051
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
    // multiply 4 samples to coef 17
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 18
    LI $v0, 12765
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 18
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 19
    LI $v0, -16052
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 19
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 20
    LI $v0, 20003
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 20
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 21
    LI $v0, -24719
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 21
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 22
    LI $v0, 30312
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 22
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 23
    LI $v0, -36908
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 23
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 24
    LI $v0, 44651
    // load next samples
    LW $t2, 112($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 24
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load address row 1 & check addr overflow
    ADDU $t8, $a0, 192
    BLTU $t8, $a2, .fir1_5842_p4
    SUBU $t8, $t8, $a3
    .fir1_5842_p4:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 384
    BLTU $t9, $a2, .fir1_5842_p5
    SUBU $t9, $t9, $a3
    .fir1_5842_p5:
    
    // load coef 25
    LI $v0, -53702
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 88($t9)
    // multiply 4 samples to coef 25
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 26
    LI $v0, 64253
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
    // multiply 4 samples to coef 26
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 27
    LI $v0, -76529
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
    // multiply 4 samples to coef 27
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 28
    LI $v0, 90803
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
    // multiply 4 samples to coef 28
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 29
    LI $v0, -107417
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
    // multiply 4 samples to coef 29
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 30
    LI $v0, 126805
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 30
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 31
    LI $v0, -149544
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 31
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 32
    LI $v0, 176416
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 32
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 33
    LI $v0, -208527
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 33
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 34
    LI $v0, 247500
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 34
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 35
    LI $v0, -295824
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 35
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 36
    LI $v0, 357532
    // load next samples
    LW $t2, 112($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 36
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load address row 1 & check addr overflow
    ADDU $t8, $a0, 288
    BLTU $t8, $a2, .fir1_5842_p6
    SUBU $t8, $t8, $a3
    .fir1_5842_p6:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 336
    BLTU $t9, $a2, .fir1_5842_p7
    SUBU $t9, $t9, $a3
    .fir1_5842_p7:
    
    // load coef 37
    LI $v0, -439605
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 40($t9)
    // multiply 4 samples to coef 37
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 38
    LI $v0, 555269
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 32($t9)
    // multiply 4 samples to coef 38
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 39
    LI $v0, -732914
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 24($t9)
    // multiply 4 samples to coef 39
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 40
    LI $v0, 1046453
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 16($t9)
    // multiply 4 samples to coef 40
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 41
    LI $v0, -1767069
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 8($t9)
    // multiply 4 samples to coef 41
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 42
    LI $v0, 5335991
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 0($t9)
    // multiply 4 samples to coef 42
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($a1)
    // save intermediate sample
    SW $t7, 8($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 16($a1)
    // save intermediate sample
    SW $t4, 24($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 32($a1)
    // save intermediate sample
    SW $t5, 40($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 48($a1)
    // save intermediate sample
    SW $t6, 56($a1)
        
    // check addr channel
    SLL $v0, $a0, 29
    // If Right channel done - exit from func
    BNE $v0, $zero, .fir1_5842_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir1_5842_beg
    
    .fir1_5842_end:
    // restore address pointer
    J $ra
    

    
    
    
    

    

    
    
    
/*
    fir2_5842 - FIR x2 half-band upsampler (2-nd stage of SM5842)
     
    external declaration:     extern void fir2_5842(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 2 dual channel samples, upsample and return 4 dual channel samples.
*/    
fir2_5842:    
    .fir2_5842_beg:
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 56
    BLTU $t9, $a2, .fir2_5842_p1
    SUBU $t9, $t9, $a3
    .fir2_5842_p1:
    
    // load coef 1
    LI $v0, 1787
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 48($t9)
    LW $t5, 56($t9)
    LW $t6, 64($t9)
    LW $t7, 72($t9)
    // multiply 4 samples to coef 1
    MULT $ac0, $t0, $v0
    MULT $ac1, $t1, $v0
    MULT $ac2, $t2, $v0
    MULT $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 2
    LI $v0, -14786
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 40($t9)
    // multiply 4 samples to coef 2
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 3
    LI $v0, 66404
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 32($t9)
    // multiply 4 samples to coef 3
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 4
    LI $v0, -214470
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 24($t9)
    // multiply 4 samples to coef 4
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 5
    LI $v0, 569338
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 16($t9)
    // multiply 4 samples to coef 5
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 6
    LI $v0, -1425002
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 8($t9)
    // multiply 4 samples to coef 6
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 7
    LI $v0, 5211033
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 0($t9)
    // multiply 4 samples to coef 7
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($a1)
    // save intermediate sample
    SW $t6, 8($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 16($a1)
    // save intermediate sample
    SW $t7, 24($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 32($a1)
    // save intermediate sample
    SW $t4, 40($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 48($a1)
    // save intermediate sample
    SW $t5, 56($a1)
    
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 32
    BLTU $t8, $a2, .fir2_5842_p2
    SUBU $t8, $t8, $a3
    .fir2_5842_p2:
    ADDU $t9, $a0, 88    
    BLTU $t9, $a2, .fir2_5842_p3
    SUBU $t9, $t9, $a3
    .fir2_5842_p3:
    
    // load coef 1
    LI $v0, 1787
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 48($t9)
    LW $t5, 56($t9)
    LW $t6, 64($t9)
    LW $t7, 72($t9)
    // multiply 4 samples to coef 1
    MULT $ac0, $t0, $v0
    MULT $ac1, $t1, $v0
    MULT $ac2, $t2, $v0
    MULT $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 2
    LI $v0, -14786
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 40($t9)
    // multiply 4 samples to coef 2
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 3
    LI $v0, 66404
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 32($t9)
    // multiply 4 samples to coef 3
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 4
    LI $v0, -214470
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 24($t9)
    // multiply 4 samples to coef 4
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 5
    LI $v0, 569338
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 16($t9)
    // multiply 4 samples to coef 5
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 6
    LI $v0, -1425002
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 8($t9)
    // multiply 4 samples to coef 6
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 7
    LI $v0, 5211033
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 0($t9)
    // multiply 4 samples to coef 7
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 64($a1)
    // save intermediate sample
    SW $t6, 72($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 80($a1)
    // save intermediate sample
    SW $t7, 88($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 96($a1)
    // save intermediate sample
    SW $t4, 104($a1)
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 112($a1)
    // save intermediate sample
    SW $t5, 120($a1)    
    
    // check addr channel
    SLL $v0, $a0, 29
    // If Right channel done - exit from func
    BNE $v0, $zero, .fir2_5842_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir2_5842_beg
    
    .fir2_5842_end:
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
/*
    fir3_5842 - FIR x2 half-band upsampler (3-rd stage of SM5842)
     
    external declaration:     extern void fir3_5842(void *pSrc, void *pDst);

    input:
    pSrc - int32 source data pointer ($a0)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 4 dual channel samples, upsample and return 8 dual channel samples.
*/
fir3_5842:    
    // load coefficients
    LI $v0, -26591
    LI $v1, 229059
    LI $t8, -1052136
    LI $t9, 5043972

    .fir3_5842_beg:    
    // ************ channel pass 1 *********************    
    // load 8 data samples
    LW $t0, 0($a0)
    LW $t1, 8($a0)
    LW $t2, 16($a0)
    LW $t3, 24($a0)
    LW $t4, 32($a0)
    LW $t5, 40($a0)
    LW $t6, 48($a0)
    LW $t7, 56($a0)
    // multiply-acccumulate
    MULT $t0, $v0
    MADD $t1, $v1
    MADD $t2, $t8
    MADD $t3, $t9
    MADD $t4, $t9
    MADD $t5, $t8
    MADD $t6, $v1
    MADD $t7, $v0
    // Copy intermediate sample
    SW $t4, 8($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t0, $ac0, 23
    SW $t0, 0($a1)

    // ************ channel pass 2 *********************
    // load next sample
    LW $t0, 64($a0)
    // multiply-acccumulate
    MULT $t1, $v0
    MADD $t2, $v1
    MADD $t3, $t8
    MADD $t4, $t9
    MADD $t5, $t9
    MADD $t6, $t8
    MADD $t7, $v1
    MADD $t0, $v0
    // Copy intermediate sample
    SW $t5, 24($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t1, $ac0, 23
    SW $t1, 16($a1)
    
    // ************ channel pass 3 *********************
    // load next sample
    LW $t1, 72($a0)
    // multiply-acccumulate
    MULT $t2, $v0
    MADD $t3, $v1
    MADD $t4, $t8
    MADD $t5, $t9
    MADD $t6, $t9
    MADD $t7, $t8
    MADD $t0, $v1
    MADD $t1, $v0    
    // Copy intermediate sample
    SW $t6, 40($a1)    
    // Shift, round and save 32bit result
    EXTR_R.W $t2, $ac0, 23
    SW $t2, 32($a1)
    
    // ************ channel pass 4 *********************
    // load next sample
    LW $t2, 80($a0)
    // multiply-acccumulate
    MULT $t3, $v0
    MADD $t4, $v1
    MADD $t5, $t8
    MADD $t6, $t9
    MADD $t7, $t9
    MADD $t0, $t8
    MADD $t1, $v1
    MADD $t2, $v0    
    // Copy intermediate sample
    SW $t7, 56($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t3, $ac0, 23
    SW $t3, 48($a1)

    // ************ channel pass 5 *********************
    // load next sample
    LW $t3, 88($a0)
    // multiply-acccumulate
    MULT $t4, $v0
    MADD $t5, $v1
    MADD $t6, $t8
    MADD $t7, $t9
    MADD $t0, $t9
    MADD $t1, $t8
    MADD $t2, $v1
    MADD $t3, $v0    
    // Copy intermediate sample
    SW $t0, 72($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t4, $ac0, 23
    SW $t4, 64($a1)
    
    // ************ channel pass 6 *********************
    // load next sample
    LW $t4, 96($a0)
    // multiply-acccumulate
    MULT $t5, $v0
    MADD $t6, $v1
    MADD $t7, $t8
    MADD $t0, $t9
    MADD $t1, $t9
    MADD $t2, $t8
    MADD $t3, $v1
    MADD $t4, $v0    
    // Copy intermediate sample
    SW $t1, 88($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t5, $ac0, 23
    SW $t5, 80($a1)
    
    // ************ channel pass 7 *********************
    // load next sample
    LW $t5, 104($a0)
    // multiply-acccumulate
    MULT $t6, $v0
    MADD $t7, $v1
    MADD $t0, $t8
    MADD $t1, $t9
    MADD $t2, $t9
    MADD $t3, $t8
    MADD $t4, $v1
    MADD $t5, $v0    
    // Copy intermediate sample
    SW $t2, 104($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t6, $ac0, 23
    SW $t6, 96($a1)
    
    // ************ channel pass 8 *********************
    // load next sample
    LW $t6, 112($a0)
    // multiply-acccumulate
    MULT $t7, $v0
    MADD $t0, $v1
    MADD $t1, $t8
    MADD $t2, $t9
    MADD $t3, $t9
    MADD $t4, $t8
    MADD $t5, $v1
    MADD $t6, $v0    
    // Copy intermediate sample
    SW $t3, 120($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t7, $ac0, 23
    SW $t7, 112($a1)

    // ************ channel pass 9 *********************
    // load next sample
    LW $t7, 120($a0)
    // multiply-acccumulate
    MULT $t0, $v0
    MADD $t1, $v1
    MADD $t2, $t8
    MADD $t3, $t9
    MADD $t4, $t9
    MADD $t5, $t8
    MADD $t6, $v1
    MADD $t7, $v0    
    // Copy intermediate sample
    SW $t4, 136($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t0, $ac0, 23
    SW $t0, 128($a1)
    
    // ************ channel pass 10 *********************
    // load next sample
    LW $t0, 128($a0)
    // multiply-acccumulate
    MULT $t1, $v0
    MADD $t2, $v1
    MADD $t3, $t8
    MADD $t4, $t9
    MADD $t5, $t9
    MADD $t6, $t8
    MADD $t7, $v1
    MADD $t0, $v0
    // Copy intermediate sample
    SW $t5, 152($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t1, $ac0, 23
    SW $t1, 144($a1)
    
    // ************ channel pass 11 *********************
    // load next sample
    LW $t1, 136($a0)
    // multiply-acccumulate
    MULT $t2, $v0
    MADD $t3, $v1
    MADD $t4, $t8
    MADD $t5, $t9
    MADD $t6, $t9
    MADD $t7, $t8
    MADD $t0, $v1
    MADD $t1, $v0    
    // Copy intermediate sample
    SW $t6, 168($a1)    
    // Shift, round and save 32bit result
    EXTR_R.W $t2, $ac0, 23
    SW $t2, 160($a1)
    
    // ************ channel pass 12 *********************
    // load next sample
    LW $t2, 144($a0)
    // multiply-acccumulate
    MULT $t3, $v0
    MADD $t4, $v1
    MADD $t5, $t8
    MADD $t6, $t9
    MADD $t7, $t9
    MADD $t0, $t8
    MADD $t1, $v1
    MADD $t2, $v0    
    // Copy intermediate sample
    SW $t7, 184($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t3, $ac0, 23
    SW $t3, 176($a1)

    // ************ channel pass 13 *********************
    // load next sample
    LW $t3, 152($a0)
    // multiply-acccumulate
    MULT $t4, $v0
    MADD $t5, $v1
    MADD $t6, $t8
    MADD $t7, $t9
    MADD $t0, $t9
    MADD $t1, $t8
    MADD $t2, $v1
    MADD $t3, $v0    
    // Copy intermediate sample
    SW $t0, 200($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t4, $ac0, 23
    SW $t4, 192($a1)
    
    // ************ channel pass 14 *********************
    // load next sample
    LW $t4, 160($a0)
    // multiply-acccumulate
    MULT $t5, $v0
    MADD $t6, $v1
    MADD $t7, $t8
    MADD $t0, $t9
    MADD $t1, $t9
    MADD $t2, $t8
    MADD $t3, $v1
    MADD $t4, $v0    
    // Copy intermediate sample
    SW $t1, 216($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t5, $ac0, 23
    SW $t5, 208($a1)
    
    // ************ channel pass 15 *********************
    // load next sample
    LW $t5, 168($a0)
    // multiply-acccumulate
    MULT $t6, $v0
    MADD $t7, $v1
    MADD $t0, $t8
    MADD $t1, $t9
    MADD $t2, $t9
    MADD $t3, $t8
    MADD $t4, $v1
    MADD $t5, $v0    
    // Copy intermediate sample
    SW $t2, 232($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t6, $ac0, 23
    SW $t6, 224($a1)
    
    // ************ channel pass 16 *********************
    // load next sample
    LW $t6, 176($a0)
    // multiply-acccumulate
    MULT $t7, $v0
    MADD $t0, $v1
    MADD $t1, $t8
    MADD $t2, $t9
    MADD $t3, $t9
    MADD $t4, $t8
    MADD $t5, $v1
    MADD $t6, $v0    
    // Copy intermediate sample
    SW $t3, 248($a1)
    // Shift, round and save 32bit result
    EXTR_R.W $t7, $ac0, 23
    SW $t7, 240($a1)
    
    // check addr channel
    SLL $t0, $a0, 29
    // If Right channel done - exit from func
    BNE $t0, $zero, .fir3_5842_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir3_5842_beg

    .fir3_5842_end:
    // restore address pointer
    J $ra
    
    
      