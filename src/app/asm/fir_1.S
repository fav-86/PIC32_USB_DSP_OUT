
.global fir1_44SHRP
.global fir1_88
.global fir1_176
.global fir1_352
    
    
/*
    fir1_44SHRP - FIR 44.1kHz x2 upsampler
	-120db out of band attenuation, +/-0.000015db ripple
	-52db Nyquist Frequency attenuation, -0.05db at 20kHz
	* min. tail addition lenght 15 samples
     
    external declaration:     extern void fir1_44SHRP(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 1 dual channel sample, upsample and return 2 dual channel samples.
*/
fir1_44SHRP:
    .fir1_44SHRP_beg:
    // ----- FIR PASS 1 --------------------------------------------------------
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 856
    BLTU $t9, $a2, .fir1_44SHRP_p1
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p1:
    
    // load coef 1
    LI $v0, 2
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
    LI $v0, -7
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
    LI $v0, 17
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
    LI $v0, -33
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
    LI $v0, 59
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
    LI $v0, -96
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
    LI $v0, 149
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
    LI $v0, -218
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
    LI $v0, 305
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
    LI $v0, -409
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
    LI $v0, 527
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
    LI $v0, -654
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
    BLTU $t8, $a2, .fir1_44SHRP_p2
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p2:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 760
    BLTU $t9, $a2, .fir1_44SHRP_p3
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p3:
    
    // load coef 13
    LI $v0, 780
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
    LI $v0, -890
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
    LI $v0, 967
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
    LI $v0, -986
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
    LI $v0, 918
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
    LI $v0, -729
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
    LI $v0, 384
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
    LI $v0, 156
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
    LI $v0, -929
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
    LI $v0, 1969
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
    LI $v0, -3303
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
    LI $v0, 4949
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
    BLTU $t8, $a2, .fir1_44SHRP_p4
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p4:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 664
    BLTU $t9, $a2, .fir1_44SHRP_p5
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p5:
    
    // load coef 25
    LI $v0, -6908
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
    LI $v0, 9163
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
    LI $v0, -11675
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
    LI $v0, 14376
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
    LI $v0, -17170
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
    LI $v0, 19930
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
    LI $v0, -22493
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
    LI $v0, 24670
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
    LI $v0, -26237
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
    LI $v0, 26952
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
    LI $v0, -26549
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
    LI $v0, 24756
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
    BLTU $t8, $a2, .fir1_44SHRP_p6
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p6:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 568
    BLTU $t9, $a2, .fir1_44SHRP_p7
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p7:
    
    // load coef 37
    LI $v0, -21301
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 88($t9)
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
    LI $v0, 15921
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
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
    LI $v0, -8378
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
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
    LI $v0, -1530
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
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
    LI $v0, 13956
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
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
    LI $v0, -28992
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 42
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 43
    LI $v0, 46659
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 43
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 44
    LI $v0, -66899
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 44
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 45
    LI $v0, 89567
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 45
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 46
    LI $v0, -114429
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 46
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 47
    LI $v0, 141163
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 47
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 48
    LI $v0, -169364
    // load next samples
    LW $t2, 112($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 48
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load address row 1 & check addr overflow
    ADDU $t8, $a0, 384
    BLTU $t8, $a2, .fir1_44SHRP_p8
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p8:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 472
    BLTU $t9, $a2, .fir1_44SHRP_p9
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p9:
    
    // load coef 49
    LI $v0, 198548
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 88($t9)
    // multiply 4 samples to coef 49
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 50
    LI $v0, -228167
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
    // multiply 4 samples to coef 50
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 51
    LI $v0, 257624
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
    // multiply 4 samples to coef 51
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 52
    LI $v0, -286285
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
    // multiply 4 samples to coef 52
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 53
    LI $v0, 313507
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
    // multiply 4 samples to coef 53
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 54
    LI $v0, -338652
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 54
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 55
    LI $v0, 361112
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 55
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 56
    LI $v0, -380331
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 56
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 57
    LI $v0, 395821
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 57
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 58
    LI $v0, -407183
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 58
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 59
    LI $v0, 414122
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 59
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 60
    LI $v0, 7972152
    // load next samples
    LW $t2, 112($t8)
    // multiply 4 samples to coef 60
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 16($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 32($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 48($a1)

    // ----- FIR PASS 2 --------------------------------------------------------
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 864
    BLTU $t9, $a2, .fir1_44SHRP_p10
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p10:
    
    // load coef 1
    LI $v0, 11
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
    LI $v0, -15
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
    LI $v0, 25
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
    LI $v0, -36
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
    LI $v0, 48
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
    LI $v0, -60
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
    LI $v0, 68
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
    LI $v0, -67
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
    LI $v0, 51
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
    LI $v0, -13
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
    LI $v0, -56
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
    LI $v0, 168
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
    BLTU $t8, $a2, .fir1_44SHRP_p11
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p11:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 768
    BLTU $t9, $a2, .fir1_44SHRP_p12
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p12:
    
    // load coef 13
    LI $v0, -333
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
    LI $v0, 563
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
    LI $v0, -868
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
    LI $v0, 1256
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
    LI $v0, -1730
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
    LI $v0, 2288
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
    LI $v0, -2922
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
    LI $v0, 3613
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
    LI $v0, -4330
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
    LI $v0, 5031
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
    LI $v0, -5660
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
    LI $v0, 6148
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
    BLTU $t8, $a2, .fir1_44SHRP_p13
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p13:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 672
    BLTU $t9, $a2, .fir1_44SHRP_p14
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p14:
    
    // load coef 25
    LI $v0, -6412
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
    LI $v0, 6358
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
    LI $v0, -5884
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
    LI $v0, 4881
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
    LI $v0, -3242
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
    LI $v0, 865
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
    LI $v0, 2338
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
    LI $v0, -6436
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
    LI $v0, 11466
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
    LI $v0, -17429
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
    LI $v0, 24281
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
    LI $v0, -31923
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
    BLTU $t8, $a2, .fir1_44SHRP_p15
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p15:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 576
    BLTU $t9, $a2, .fir1_44SHRP_p16
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p16:
    
    // load coef 37
    LI $v0, 40196
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 88($t9)
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
    LI $v0, -48878
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
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
    LI $v0, 57677
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
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
    LI $v0, -66234
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
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
    LI $v0, 74120
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
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
    LI $v0, -80841
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 42
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 43
    LI $v0, 85840
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 43
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 44
    LI $v0, -88505
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 44
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 45
    LI $v0, 88172
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 45
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 46
    LI $v0, -84124
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 46
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 47
    LI $v0, 75595
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 47
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 48
    LI $v0, -61754
    // load next samples
    LW $t2, 112($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 48
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load address row 1 & check addr overflow
    ADDU $t8, $a0, 384
    BLTU $t8, $a2, .fir1_44SHRP_p17
    SUBU $t8, $t8, $a3
    .fir1_44SHRP_p17:
    // load address row 2 & check addr overflow
    ADDU $t9, $a0, 480
    BLTU $t9, $a2, .fir1_44SHRP_p18
    SUBU $t9, $t9, $a3
    .fir1_44SHRP_p18:
    
    // load coef 49
    LI $v0, 41677
    // load 8 data samples
    LW $t3, 24($t8)
    LW $t4, 88($t9)
    // multiply 4 samples to coef 49
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 50
    LI $v0, -14297
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 80($t9)
    // multiply 4 samples to coef 50
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 51
    LI $v0, -21698
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 72($t9)
    // multiply 4 samples to coef 51
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 52
    LI $v0, 68044
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 64($t9)
    // multiply 4 samples to coef 52
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 53
    LI $v0, -127251
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 56($t9)
    // multiply 4 samples to coef 53
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 54
    LI $v0, 203262
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 48($t9)
    // multiply 4 samples to coef 54
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 55
    LI $v0, -302870
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 40($t9)
    // multiply 4 samples to coef 55
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 56
    LI $v0, 439004
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 32($t9)
    // multiply 4 samples to coef 56
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // load coef 57
    LI $v0, -639668
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 24($t9)
    // multiply 4 samples to coef 57
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0
    
    // load coef 58
    LI $v0, 978303
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 16($t9)
    // multiply 4 samples to coef 58
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    MADD $ac0, $t7, $v0
    MADD $ac1, $t4, $v0
    MADD $ac2, $t5, $v0
    MADD $ac3, $t6, $v0
    
    // load coef 59
    LI $v0, -1725550
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 8($t9)
    // multiply 4 samples to coef 59
    MADD $ac0, $t2, $v0
    MADD $ac1, $t3, $v0
    MADD $ac2, $t0, $v0
    MADD $ac3, $t1, $v0
    MADD $ac0, $t6, $v0
    MADD $ac1, $t7, $v0
    MADD $ac2, $t4, $v0
    MADD $ac3, $t5, $v0
    
    // load coef 60
    LI $v0, 5322045
    // load next samples
    LW $t2, 112($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 60
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 8($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 24($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 40($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 56($a1)
    
    // check addr channel
    SLL $v0, $a0, 29
    // If Right channel done - exit from func
    BNE $v0, $zero, .fir1_44SHRP_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir1_44SHRP_beg
    
    .fir1_44SHRP_end:
    // restore address pointer
    J $ra
    

    
    
    
    
    
    
    
    
    
    
    
    
/*
    fir1_88 - FIR 88.2kHz x2 upsampler with 12db attenuation to saturation
	-120db out of band attenuation, +/-0.000005db ripple
	-90db Nyquist Frequency attenuation, -0.05db at 20kHz
	* min. tail addition lenght 11 samples
     
    external declaration:     extern void fir1_88(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 1 dual channel sample, upsample and return 2 dual channel samples.
*/
fir1_88:
    .fir1_88_beg:
    // ----- FIR PASS 1 --------------------------------------------------------
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 88
    BLTU $t9, $a2, .fir1_88_p1
    SUBU $t9, $t9, $a3
    .fir1_88_p1:
    
    // load coef 1
    LI $v0, -244
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 80($t9)
    LW $t5, 88($t9)
    LW $t6, 96($t9)
    LW $t7, 104($t9)
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
    LI $v0, 2280
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 72($t9)
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
    LI $v0, -4820
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 64($t9)
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
    LI $v0, -8448
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 56($t9)
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
    LI $v0, 56096
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 48($t9)
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
    LI $v0, -87436
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 40($t9)
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
    LI $v0, -49716
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 32($t9)
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
    LI $v0, 416980
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 24($t9)
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
    LI $v0, -654752
    // load next samples
    LW $t3, 88($t8)
    LW $t4, 16($t9)
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
    LI $v0, -109832
    // load next samples
    LW $t0, 96($t8)
    LW $t7, 8($t9)
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
    LI $v0, 4634200
    // load next samples
    LW $t1, 104($t8)
    LW $t6, 0($t9)
    // multiply 4 samples to coef 11
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
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 16($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 32($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 48($a1)

    // ----- FIR PASS 2 --------------------------------------------------------
    // load coef 1
    LI $v0, -132
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
    LI $v0, 492
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
    LI $v0, 2016
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
    LI $v0, -14252
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
    LI $v0, 24528
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
    LI $v0, 23716
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
    LI $v0, -166500
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
    LI $v0, 250508
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
    LI $v0, 82080
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
    LI $v0, -1019872
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
    LI $v0, 2155096
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
    LI $v0, 5713256
    // load next samples
    LW $t2, 112($t8)
    // multiply 4 samples to coef 12
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 8($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 24($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 40($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 56($a1)
    
    // check addr channel
    SLL $v0, $a0, 29
    // If Right channel done - exit from func
    BNE $v0, $zero, .fir1_88_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir1_88_beg
    .fir1_88_end:
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/*
    fir1_176 - FIR 176.4kHz x2 upsampler with 12db attenuation to saturation
	-124db out of band attenuation, +/-0.0000025db ripple
	-92db Nyquist Frequency attenuation, -0.05db at 20kHz
	* min. tail addition lenght 7 samples
     
    external declaration:     extern void fir1_176(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 1 dual channel sample, upsample and return 2 dual channel samples.
*/
fir1_176:
    .fir1_176_beg:
    // ----- FIR PASS 1 --------------------------------------------------------
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 56
    BLTU $t9, $a2, .fir1_176_p1
    SUBU $t9, $t9, $a3
    .fir1_176_p1:
    
    // load coef 1
    LI $v0, -2924
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 56($t9)
    LW $t5, 64($t9)
    LW $t6, 72($t9)
    LW $t7, 80($t9)
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
    LI $v0, -7852
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 48($t9)
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
    LI $v0, 56116
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 40($t9)
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
    LI $v0, 64084
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 32($t9)
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
    LI $v0, -411744
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 24($t9)
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
    LI $v0, -187888
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 16($t9)
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
    LI $v0, 2455700
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 8($t9)
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
    LI $v0, 4457624
    // load next samples
    LW $t2, 80($t8)
    // multiply 4 samples to coef 8
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0

    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 16($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 32($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 48($a1)

    // ----- FIR PASS 2 --------------------------------------------------------
    // load symmetric addresses & check addr overflow
    ADDU $t9, $a0, 64
    BLTU $t9, $a2, .fir1_176_p2
    SUBU $t9, $t9, $a3
    .fir1_176_p2:
    
    // load coef 1
    LI $v0, -508
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 56($t9)
    LW $t5, 64($t9)
    LW $t6, 72($t9)
    LW $t7, 80($t9)
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
    LI $v0, -7488
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 48($t9)
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
    LI $v0, 10644
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 40($t9)
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
    LI $v0, 99760
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 32($t9)
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
    LI $v0, -122856
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 24($t9)
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
    LI $v0, -553476
    // load next samples
    LW $t0, 64($t8)
    LW $t7, 16($t9)
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
    LI $v0, 887736
    // load next samples
    LW $t1, 72($t8)
    LW $t6, 8($t9)
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
    LI $v0, 3880492
    // load next samples
    LW $t2, 80($t8)
    LW $t5, 0($t9)
    // multiply 4 samples to coef 8
    MADD $ac0, $t3, $v0
    MADD $ac1, $t0, $v0
    MADD $ac2, $t1, $v0
    MADD $ac3, $t2, $v0
    MADD $ac0, $t5, $v0
    MADD $ac1, $t6, $v0
    MADD $ac2, $t7, $v0
    MADD $ac3, $t4, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 8($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 24($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 40($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 56($a1)
    
    // check addr channel
    SLL $v0, $a0, 29
    // If Right channel done - exit from func
    BNE $v0, $zero, .fir1_176_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir1_176_beg
    .fir1_176_end:
    // restore address pointer
    J $ra

   
    
    
    
    
    
    
    
    
    
    
    
    
/*
    fir1_352 - FIR 352.8kHz x2 upsampler with 12db attenuation to saturation
	-112db out of band attenuation, +/-0.0db ripple
	-90db Nyquist Frequency attenuation, -0.05db at 20kHz
	* min. tail addition lenght 5 samples
     
    external declaration:     extern void fir1_352(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 1 dual channel sample, upsample and return 2 dual channel samples.
*/
fir1_352:
    .fir1_352_beg:
    // ----- FIR PASS 1 --------------------------------------------------------
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 40
    BLTU $t9, $a2, .fir1_352_p1
    SUBU $t9, $t9, $a3
    .fir1_352_p1:
    
    // load coef 1
    LI $v0, -20568
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 32($t9)
    LW $t5, 40($t9)
    LW $t6, 48($t9)
    LW $t7, 56($t9)
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
    LI $v0, -168552
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 24($t9)
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
    LI $v0, -156656
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 16($t9)
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
    LI $v0, 1185992
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 8($t9)
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
    LI $v0, 3354104
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 0($t9)
    // multiply 4 samples to coef 5
    MADD $ac0, $t0, $v0
    MADD $ac1, $t1, $v0
    MADD $ac2, $t2, $v0
    MADD $ac3, $t3, $v0
    MADD $ac0, $t4, $v0
    MADD $ac1, $t5, $v0
    MADD $ac2, $t6, $v0
    MADD $ac3, $t7, $v0

    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 16($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 32($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 48($a1)

    // ----- FIR PASS 2 --------------------------------------------------------
    // load coef 1
    LI $v0, -2888
    // load 8 data samples
    LW $t0, 0($t8)
    LW $t1, 8($t8)
    LW $t2, 16($t8)
    LW $t3, 24($t8)
    LW $t4, 40($t9)
    LW $t5, 48($t9)
    LW $t6, 56($t9)
    LW $t7, 64($t9)
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
    LI $v0, -73856
    // load next samples
    LW $t0, 32($t8)
    LW $t7, 32($t9)
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
    LI $v0, -246752
    // load next samples
    LW $t1, 40($t8)
    LW $t6, 24($t9)
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
    LI $v0, 293552
    // load next samples
    LW $t2, 48($t8)
    LW $t5, 16($t9)
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
    LI $v0, 2346720
    // load next samples
    LW $t3, 56($t8)
    LW $t4, 8($t9)
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
    LI $v0, 3755088
    // load next samples
    LW $t0, 64($t8)
    // multiply 4 samples to coef 6
    MADD $ac0, $t1, $v0
    MADD $ac1, $t2, $v0
    MADD $ac2, $t3, $v0
    MADD $ac3, $t0, $v0
    
    // Shift, round and and save result
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 8($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac1, 23
    SW $v0, 24($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac2, 23
    SW $v0, 40($a1)
    // Shift, round and and save result
    EXTR_R.W $v0, $ac3, 23
    SW $v0, 56($a1)
    
    // check addr channel
    SLL $v0, $a0, 29
    // If Right channel done - exit from func
    BNE $v0, $zero, .fir1_352_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir1_352_beg
    .fir1_352_end:
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
