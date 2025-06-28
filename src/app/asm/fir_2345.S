

.global fir2
.global fir3
.global fir4
.global fir5

    
/*
    fir2 - FIR x2 half-band upsampler
     
    external declaration:     extern void fir2(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 2 dual channel samples, upsample and return 4 dual channel samples.
*/    
fir2:    
    .fir2_beg:
    // load symmetric addresses & check addr overflow
    ADDU $t8, $a0, 0
    ADDU $t9, $a0, 56
    BLTU $t9, $a2, .fir2_p1
    SUBU $t9, $t9, $a3
    .fir2_p1:
    
    // load coef 1
    LI $v0, 1816
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
    LI $v0, -14896
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
    LI $v0, 66664
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
    LI $v0, -214896
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
    LI $v0, 569848
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
    LI $v0, -1425432
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
    LI $v0, 5211200
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
    BLTU $t8, $a2, .fir2_p2
    SUBU $t8, $t8, $a3
    .fir2_p2:
    ADDU $t9, $a0, 88    
    BLTU $t9, $a2, .fir2_p3
    SUBU $t9, $t9, $a3
    .fir2_p3:
    
    // load coef 1
    LI $v0, 1816
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
    LI $v0, -14896
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
    LI $v0, 66664
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
    LI $v0, -214896
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
    LI $v0, 569848
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
    LI $v0, -1425432
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
    LI $v0, 5211200
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
    BNE $v0, $zero, .fir2_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir2_beg
    
    .fir2_end:
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    

    
    
    
/*
    fir3 - FIR x2 half-band upsampler
     
    external declaration:     extern void fir3(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 4 dual channel samples, upsample and return 8 dual channel samples.
*/
fir3:
    // load coefficients
    LI $v0, -25056
    LI $v1, 222264
    LI $t8, -1040860
    LI $t9, 5037956
    
    .fir3_beg:    
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
    BNE $t0, $zero, .fir3_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir3_beg

    .fir3_end:
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
/*
    fir4 - FIR x2 half-band upsampler
     
    external declaration:     extern void fir4(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 8 dual channel samples, upsample and return 16 dual channel samples.
*/
fir4:
    // load 3 coefficients
    LI $t6, 100522
    LI $t7, -825796
    LI $t8, 4919578

    .fir4_beg:
    // ********************** channel pass 1 ******************************
    // load 6 data samples
    LW $t0, 0($a0)
    LW $t1, 8($a0)
    LW $t2, 16($a0)
    LW $t3, 24($a0)
    LW $t4, 32($a0)
    LW $t5, 40($a0)
    // multiply-acccumulate
    MULT $t0, $t6
    MADD $t1, $t7
    MADD $t2, $t8
    MADD $t3, $t8
    MADD $t4, $t7
    MADD $t5, $t6    
    // Left channel sample copy
    SW $t3, 8($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($a1)

    // ********************** channel pass 2 ******************************
    // load data sample
    LW $t0, 48($a0)
    // multiply-acccumulate
    MULT $t1, $t6
    MADD $t2, $t7
    MADD $t3, $t8
    MADD $t4, $t8
    MADD $t5, $t7
    MADD $t0, $t6    
    // Left channel sample copy
    SW $t4, 24($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 16($a1)

    // ********************** channel pass 3 ******************************
    // load data sample
    LW $t1, 56($a0)
    // multiply-acccumulate
    MULT $t2, $t6
    MADD $t3, $t7
    MADD $t4, $t8
    MADD $t5, $t8
    MADD $t0, $t7
    MADD $t1, $t6    
    // Left channel sample copy
    SW $t5, 40($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 32($a1)

    // ********************** channel pass 4 ******************************
    // load data sample
    LW $t2, 64($a0)
    // multiply-acccumulate
    MULT $t3, $t6
    MADD $t4, $t7
    MADD $t5, $t8
    MADD $t0, $t8
    MADD $t1, $t7
    MADD $t2, $t6    
    // Left channel sample copy
    SW $t0, 56($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 48($a1)

    // ********************** channel pass 5 ******************************
    // load data sample
    LW $t3, 72($a0)
    // multiply-acccumulate
    MULT $t4, $t6
    MADD $t5, $t7
    MADD $t0, $t8
    MADD $t1, $t8
    MADD $t2, $t7
    MADD $t3, $t6    
    // Left channel sample copy
    SW $t1, 72($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 64($a1)

    // ********************** channel pass 6 ******************************
    // load data sample
    LW $t4, 80($a0)
    // multiply-acccumulate
    MULT $t5, $t6
    MADD $t0, $t7
    MADD $t1, $t8
    MADD $t2, $t8
    MADD $t3, $t7
    MADD $t4, $t6    
    // Left channel sample copy
    SW $t2, 88($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 80($a1)

    // ********************** channel pass 7 ******************************
    // load data sample
    LW $t5, 88($a0)
    // multiply-acccumulate
    MULT $t0, $t6
    MADD $t1, $t7
    MADD $t2, $t8
    MADD $t3, $t8
    MADD $t4, $t7
    MADD $t5, $t6    
    // Left channel sample copy
    SW $t3, 104($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 96($a1)

    // ********************** channel pass 8 ******************************
    // load data sample
    LW $t0, 96($a0)
    // multiply-acccumulate
    MULT $t1, $t6
    MADD $t2, $t7
    MADD $t3, $t8
    MADD $t4, $t8
    MADD $t5, $t7
    MADD $t0, $t6    
    // Left channel sample copy
    SW $t4, 120($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 112($a1)
    
    // ********************** channel pass 9 ******************************
    // load data sample
    LW $t1, 104($a0)
    // multiply-acccumulate
    MULT $t2, $t6
    MADD $t3, $t7
    MADD $t4, $t8
    MADD $t5, $t8
    MADD $t0, $t7
    MADD $t1, $t6    
    // Left channel sample copy
    SW $t5, 136($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 128($a1)

    // ********************** channel pass 10 ******************************
    // load data sample
    LW $t2, 112($a0)
    // multiply-acccumulate
    MULT $t3, $t6
    MADD $t4, $t7
    MADD $t5, $t8
    MADD $t0, $t8
    MADD $t1, $t7
    MADD $t2, $t6    
    // Left channel sample copy
    SW $t0, 152($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 144($a1)

    // ********************** channel pass 11 ******************************
    // load data sample
    LW $t3, 120($a0)
    // multiply-acccumulate
    MULT $t4, $t6
    MADD $t5, $t7
    MADD $t0, $t8
    MADD $t1, $t8
    MADD $t2, $t7
    MADD $t3, $t6    
    // Left channel sample copy
    SW $t1, 168($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 160($a1)

    // ********************** channel pass 12 ******************************
    // load data sample
    LW $t4, 128($a0)
    // multiply-acccumulate
    MULT $t5, $t6
    MADD $t0, $t7
    MADD $t1, $t8
    MADD $t2, $t8
    MADD $t3, $t7
    MADD $t4, $t6    
    // Left channel sample copy
    SW $t2, 184($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 176($a1)

    // ********************** channel pass 13 ******************************
    // load data sample
    LW $t5, 136($a0)
    // multiply-acccumulate
    MULT $t0, $t6
    MADD $t1, $t7
    MADD $t2, $t8
    MADD $t3, $t8
    MADD $t4, $t7
    MADD $t5, $t6    
    // Left channel sample copy
    SW $t3, 200($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 192($a1)

    // ********************** channel pass 14 ******************************
    // load data sample
    LW $t0, 144($a0)
    // multiply-acccumulate
    MULT $t1, $t6
    MADD $t2, $t7
    MADD $t3, $t8
    MADD $t4, $t8
    MADD $t5, $t7
    MADD $t0, $t6    
    // Left channel sample copy
    SW $t4, 216($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 208($a1)
    
    // ********************** channel pass 15 ******************************
    // load data sample
    LW $t1, 152($a0)
    // multiply-acccumulate
    MULT $t2, $t6
    MADD $t3, $t7
    MADD $t4, $t8
    MADD $t5, $t8
    MADD $t0, $t7
    MADD $t1, $t6    
    // Left channel sample copy
    SW $t5, 232($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 224($a1)

    // ********************** channel pass 16 ******************************
    // load data sample
    LW $t2, 160($a0)
    // multiply-acccumulate
    MULT $t3, $t6
    MADD $t4, $t7
    MADD $t5, $t8
    MADD $t0, $t8
    MADD $t1, $t7
    MADD $t2, $t6    
    // Left channel sample copy
    SW $t0, 248($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 240($a1)

    // ********************** channel pass 17 ******************************
    // load data sample
    LW $t3, 168($a0)
    // multiply-acccumulate
    MULT $t4, $t6
    MADD $t5, $t7
    MADD $t0, $t8
    MADD $t1, $t8
    MADD $t2, $t7
    MADD $t3, $t6    
    // Left channel sample copy
    SW $t1, 264($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 256($a1)

    // ********************** channel pass 18 ******************************
    // load data sample
    LW $t4, 176($a0)
    // multiply-acccumulate
    MULT $t5, $t6
    MADD $t0, $t7
    MADD $t1, $t8
    MADD $t2, $t8
    MADD $t3, $t7
    MADD $t4, $t6    
    // Left channel sample copy
    SW $t2, 280($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 272($a1)

    // ********************** channel pass 19 ******************************
    // load data sample
    LW $t5, 184($a0)
    // multiply-acccumulate
    MULT $t0, $t6
    MADD $t1, $t7
    MADD $t2, $t8
    MADD $t3, $t8
    MADD $t4, $t7
    MADD $t5, $t6    
    // Left channel sample copy
    SW $t3, 296($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 288($a1)

    // ********************** channel pass 20 ******************************
    // load data sample
    LW $t0, 192($a0)
    // multiply-acccumulate
    MULT $t1, $t6
    MADD $t2, $t7
    MADD $t3, $t8
    MADD $t4, $t8
    MADD $t5, $t7
    MADD $t0, $t6    
    // Left channel sample copy
    SW $t4, 312($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 304($a1)
    
    // ********************** channel pass 21 ******************************
    // load data sample
    LW $t1, 200($a0)
    // multiply-acccumulate
    MULT $t2, $t6
    MADD $t3, $t7
    MADD $t4, $t8
    MADD $t5, $t8
    MADD $t0, $t7
    MADD $t1, $t6    
    // Left channel sample copy
    SW $t5, 328($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 320($a1)

    // ********************** channel pass 22 ******************************
    // load data sample
    LW $t2, 208($a0)
    // multiply-acccumulate
    MULT $t3, $t6
    MADD $t4, $t7
    MADD $t5, $t8
    MADD $t0, $t8
    MADD $t1, $t7
    MADD $t2, $t6    
    // Left channel sample copy
    SW $t0, 344($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 336($a1)

    // ********************** channel pass 23 ******************************
    // load data sample
    LW $t3, 216($a0)
    // multiply-acccumulate
    MULT $t4, $t6
    MADD $t5, $t7
    MADD $t0, $t8
    MADD $t1, $t8
    MADD $t2, $t7
    MADD $t3, $t6    
    // Left channel sample copy
    SW $t1, 360($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 352($a1)

    // ********************** channel pass 24 ******************************
    // load data sample
    LW $t4, 224($a0)
    // multiply-acccumulate
    MULT $t5, $t6
    MADD $t0, $t7
    MADD $t1, $t8
    MADD $t2, $t8
    MADD $t3, $t7
    MADD $t4, $t6    
    // Left channel sample copy
    SW $t2, 376($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 368($a1)

    // ********************** channel pass 25 ******************************
    // load data sample
    LW $t5, 232($a0)
    // multiply-acccumulate
    MULT $t0, $t6
    MADD $t1, $t7
    MADD $t2, $t8
    MADD $t3, $t8
    MADD $t4, $t7
    MADD $t5, $t6    
    // Left channel sample copy
    SW $t3, 392($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 384($a1)

    // ********************** channel pass 26 ******************************
    // load data sample
    LW $t0, 240($a0)
    // multiply-acccumulate
    MULT $t1, $t6
    MADD $t2, $t7
    MADD $t3, $t8
    MADD $t4, $t8
    MADD $t5, $t7
    MADD $t0, $t6    
    // Left channel sample copy
    SW $t4, 408($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 400($a1)

    // ********************** channel pass 27 ******************************
    // load data sample
    LW $t1, 248($a0)
    // multiply-acccumulate
    MULT $t2, $t6
    MADD $t3, $t7
    MADD $t4, $t8
    MADD $t5, $t8
    MADD $t0, $t7
    MADD $t1, $t6    
    // Left channel sample copy
    SW $t5, 424($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 416($a1)

    // ********************** channel pass 28 ******************************
    // load data sample
    LW $t2, 256($a0)
    // multiply-acccumulate
    MULT $t3, $t6
    MADD $t4, $t7
    MADD $t5, $t8
    MADD $t0, $t8
    MADD $t1, $t7
    MADD $t2, $t6    
    // Left channel sample copy
    SW $t0, 440($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 432($a1)

    // ********************** channel pass 29 ******************************
    // load data sample
    LW $t3, 264($a0)
    // multiply-acccumulate
    MULT $t4, $t6
    MADD $t5, $t7
    MADD $t0, $t8
    MADD $t1, $t8
    MADD $t2, $t7
    MADD $t3, $t6    
    // Left channel sample copy
    SW $t1, 456($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 448($a1)

    // ********************** channel pass 30 ******************************
    // load data sample
    LW $t4, 272($a0)
    // multiply-acccumulate
    MULT $t5, $t6
    MADD $t0, $t7
    MADD $t1, $t8
    MADD $t2, $t8
    MADD $t3, $t7
    MADD $t4, $t6    
    // Left channel sample copy
    SW $t2, 472($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 464($a1)

    // ********************** channel pass 31 ******************************
    // load data sample
    LW $t5, 280($a0)
    // multiply-acccumulate
    MULT $t0, $t6
    MADD $t1, $t7
    MADD $t2, $t8
    MADD $t3, $t8
    MADD $t4, $t7
    MADD $t5, $t6    
    // Left channel sample copy
    SW $t3, 488($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 480($a1)

    // ********************** channel pass 32 ******************************
    // load data sample
    LW $t0, 288($a0)
    // multiply-acccumulate
    MULT $t1, $t6
    MADD $t2, $t7
    MADD $t3, $t8
    MADD $t4, $t8
    MADD $t5, $t7
    MADD $t0, $t6    
    // Left channel sample copy
    SW $t4, 504($a1)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 496($a1)
    
    // check addr channel
    SLL $t0, $a0, 29
    // If Right channel done - exit from func
    BNE $t0, $zero, .fir4_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir4_beg

    .fir4_end:
    // restore address pointer
    J $ra

    
    
    
    
    
    
    
    
    
    
    
/*
    fir5 - FIR x2 half-band upsampler
     
    external declaration:     extern void fir5(void *pSrc, void *pDst, void *pEnd, int Size);

    input:
    pSrc - int32 source data pointer ($a0)
    pEng - end FIFO read address ($a2)
    Size - FIR FIFO buffer size in bytes ($a3)

    output:
    pDst - int32 result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
    Function read 16 dual channel samples, upsample and return 32 dual channel samples.
*/
fir5:
    // load 2 coefficients
    LI $t4, -524787
    LI $t5, 4719091
    
    .fir5_beg:
    // load 3 data samples
    LW $t0, 0($a0)
    LW $t1, 8($a0)
    LW $t2, 16($a0)
    // load addresses
    ADDU $t8, $a0, $zero
    ADDU $t9, $a1, $zero
    // calc source end address
    ADDU $t7, $a0, 512
    
    .fir5_rep:
    // ********************** channel pass 1 ******************************
    // load data sample
    LW $t3, 24($t8)
    // multiply-acccumulate
    MULT $t0, $t4
    MADD $t1, $t5
    MADD $t2, $t5
    MADD $t3, $t4
    // next sample copy
    SW $t2, 8($t9)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 0($t9)

    // ********************** channel pass 2 ******************************
    // load data sample
    LW $t0, 32($t8)
    // multiply-acccumulate
    MULT $t1, $t4
    MADD $t2, $t5
    MADD $t3, $t5
    MADD $t0, $t4
    // next sample copy
    SW $t3, 24($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 16($t9)

    // ********************** channel pass 3 ******************************
    // load data sample
    LW $t1, 40($t8)
    // multiply-acccumulate
    MULT $t2, $t4
    MADD $t3, $t5
    MADD $t0, $t5
    MADD $t1, $t4
    // next sample copy
    SW $t0, 40($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 32($t9)

    // ********************** channel pass 4 ******************************
    // load data sample
    LW $t2, 48($t8)
    // multiply-acccumulate
    MULT $t3, $t4
    MADD $t0, $t5
    MADD $t1, $t5
    MADD $t2, $t4
    // next sample copy
    SW $t1, 56($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 48($t9)

    // ********************** channel pass 5 ******************************
    // load data sample
    LW $t3, 56($t8)
    // multiply-acccumulate
    MULT $t0, $t4
    MADD $t1, $t5
    MADD $t2, $t5
    MADD $t3, $t4
    // next sample copy
    SW $t2, 72($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 64($t9)

    // ********************** channel pass 6 ******************************
    // load data sample
    LW $t0, 64($t8)
    // multiply-acccumulate
    MULT $t1, $t4
    MADD $t2, $t5
    MADD $t3, $t5
    MADD $t0, $t4
    // next sample copy
    SW $t3, 88($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 80($t9)

    // ********************** channel pass 7 ******************************
    // load data sample
    LW $t1, 72($t8)
    // multiply-acccumulate
    MULT $t2, $t4
    MADD $t3, $t5
    MADD $t0, $t5
    MADD $t1, $t4
    // next sample copy
    SW $t0, 104($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 96($t9)

    // ********************** channel pass 8 ******************************
    // load data sample
    LW $t2, 80($t8)
    // multiply-acccumulate
    MULT $t3, $t4
    MADD $t0, $t5
    MADD $t1, $t5
    MADD $t2, $t4
    // next sample copy
    SW $t1, 120($t9)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 112($t9)
    
    // ********************** channel pass 9 ******************************
    // load data sample
    LW $t3, 88($t8)
    // multiply-acccumulate
    MULT $t0, $t4
    MADD $t1, $t5
    MADD $t2, $t5
    MADD $t3, $t4
    // next sample copy
    SW $t2, 136($t9)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 128($t9)

    // ********************** channel pass 10 *****************************
    // load data sample
    LW $t0, 96($t8)
    // multiply-acccumulate
    MULT $t1, $t4
    MADD $t2, $t5
    MADD $t3, $t5
    MADD $t0, $t4
    // next sample copy
    SW $t3, 152($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 144($t9)

    // ********************** channel pass 11 *****************************
    // load data sample
    LW $t1, 104($t8)
    // multiply-acccumulate
    MULT $t2, $t4
    MADD $t3, $t5
    MADD $t0, $t5
    MADD $t1, $t4
    // next sample copy
    SW $t0, 168($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 160($t9)

    // ********************** channel pass 12 *****************************
    // load data sample
    LW $t2, 112($t8)
    // multiply-acccumulate
    MULT $t3, $t4
    MADD $t0, $t5
    MADD $t1, $t5
    MADD $t2, $t4
    // next sample copy
    SW $t1, 184($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 176($t9)

    // ********************** channel pass 13 *****************************
    // load data sample
    LW $t3, 120($t8)
    // multiply-acccumulate
    MULT $t0, $t4
    MADD $t1, $t5
    MADD $t2, $t5
    MADD $t3, $t4
    // next sample copy
    SW $t2, 200($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 192($t9)

    // ********************** channel pass 14 *****************************
    // load data sample
    LW $t0, 128($t8)
    // multiply-acccumulate
    MULT $t1, $t4
    MADD $t2, $t5
    MADD $t3, $t5
    MADD $t0, $t4
    // next sample copy
    SW $t3, 216($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 208($t9)

    // ********************** channel pass 15 *****************************
    // load data sample
    LW $t1, 136($t8)
    // multiply-acccumulate
    MULT $t2, $t4
    MADD $t3, $t5
    MADD $t0, $t5
    MADD $t1, $t4
    // next sample copy
    SW $t0, 232($t9)    
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 224($t9)

    // ********************** channel pass 16 *****************************
    // load data sample
    LW $t2, 144($t8)
    // multiply-acccumulate
    MULT $t3, $t4
    MADD $t0, $t5
    MADD $t1, $t5
    MADD $t2, $t4
    // next sample copy
    SW $t1, 248($t9)
    // Restore gain, round and get 32bit value
    EXTR_R.W $v0, $ac0, 23
    SW $v0, 240($t9)

    // inc addr
    ADDU $t8, $t8, 128
    ADDU $t9, $t9, 256
    // check end addr
    BLTU $t8, $t7, .fir5_rep
    
    // check addr channel
    SLL $t0, $a0, 29
    // If Right channel done - exit from func
    BNE $t0, $zero, .fir5_end
    // If Left channel done - turn address pointers to right channel & repeat
    ADDU $a0, $a0, 4
    ADDU $a1, $a1, 4
    J .fir5_beg

    .fir5_end:
    // restore address pointer
    J $ra