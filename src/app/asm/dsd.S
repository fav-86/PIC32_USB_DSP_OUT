/*
    *MIPS32 inpstructions assembler code
*/
    
/*
     Control data structure     
volatile static struct {
    int acc1L;
    int acc1R;
    int acc2;
    int acc3;
    int acc4;
    int acc5;
    int rMDOL;
    int rMDOR;
} tSdmCtrl;
*/
    
/* Global functions declarations */
.global sony5sdm_16x4
.global sony5sdm_32x2
.global sony5sdm_16x8
.global sony5sdm_32x4
.global dop_check
.global dop_usb_unpack

    
/*
    sony5sdm_16x4 - SONY 5-th order SD modulator with x4 oversampling ratio.
		One pass generate 4 data bits and shift into shreg[] register.
		Function read four dual channel int32 samples and do 8 passes
		with write 32 bit dual channel resut to output.
     
    external declaration:     extern void sony5sdm_16x4(void *pSrc, void *pDst, volatile void *pSdm);

    input:
    pSrc - int32 source data pointer ($a0)
    pDSDM - sdm delay acc array pointer ($a2)

    output:
    pDest - uint32_t destination data pointer ($a1)
*/
sony5sdm_16x4:
    // save data to stack
    ADDU $sp, $sp, -16
    SW $s0, 0($sp)
    SW $s1, 4($sp)
    SW $s2, 8($sp)
    SW $s3, 12($sp)

    // Load sdm accumulators
    LW $t0, 0($a2)  // acc1 L
    LW $t1, 4($a2)  // acc1 R
    LW $t2, 8($a2)  // acc2
    LW $t3, 12($a2) // acc3
    LW $t4, 16($a2) // acc4
    LW $t5, 20($a2) // acc5
    LW $t7, 24($a2) // reg MDO L
    LW $t8, 28($a2) // reg MDO R
    
    // load quantize mask
    LI $a3, 0x1fffffff
    // calc end addr
    ADDU $s3, $a0, 512
    
    .sdm16x4_wpass:
    // calc pass end addr
    ADDU $s2, $a0, 64
    
    .sdm16x4_bpass:
    // load input data
    LW $v0, 0($a0)
    LW $v1, 4($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1

    // ----------- SDM bit 1 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 2 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 3 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 4 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // load input data
    LW $v0, 8($a0)
    LW $v1, 12($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1
    
    // ----------- SDM bit 5 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 6 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 7 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 8 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc 
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // address input data increment
    ADDU $a0, $a0, 16
    // check pass end address
    BLTU $a0, $s2, .sdm16x4_bpass    
    // save result
    SW $s0, 0($a1)
    SW $s1, 4($a1)
    // output addr inc
    ADDU $a1, $a1, 8
    // check end address
    BLTU $a0, $s3, .sdm16x4_wpass
    
    // Save sdm accumulators
    SW $t0, 0($a2)  // acc1 L
    SW $t1, 4($a2)  // acc1 R
    SW $t2, 8($a2)  // acc2
    SW $t3, 12($a2) // acc3
    SW $t4, 16($a2) // acc4
    SW $t5, 20($a2) // acc5
    SW $t7, 24($a2) // reg MDO L
    SW $t8, 28($a2) // reg MDO R
    
    // restore data from stack   
    LW $s0, 0($sp)
    LW $s1, 4($sp)
    LW $s2, 8($sp)
    LW $s3, 12($sp)
    ADDU $sp, $sp, 16
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/*
    sony5sdm_32x2 - SONY 5-th order SD modulator with x2 oversampling ratio.
		One pass generate 4 data bits and shift into shreg[] register.
		Function read four dual channel int32 samples and do 8 passes
		with write 32 bit dual channel resut to output.
     
    external declaration:     extern void sony5sdm_32x2(void *pSrc, void *pDst, volatile void *pSdm);

    input:
    pSrc - int32 source data pointer ($a0)
    pDSDM - sdm delay acc array pointer ($a2)

    output:
    pDest - uint32_t destination data pointer ($a1)
*/
sony5sdm_32x2:
    // save data to stack
    ADDU $sp, $sp, -16
    SW $s0, 0($sp)
    SW $s1, 4($sp)
    SW $s2, 8($sp)
    SW $s3, 12($sp)

    // Load sdm accumulators
    LW $t0, 0($a2)  // acc1 L
    LW $t1, 4($a2)  // acc1 R
    LW $t2, 8($a2)  // acc2
    LW $t3, 12($a2) // acc3
    LW $t4, 16($a2) // acc4
    LW $t5, 20($a2) // acc5
    LW $t7, 24($a2) // reg MDO L
    LW $t8, 28($a2) // reg MDO R
    
    // load quantize mask
    LI $a3, 0x1fffffff
    // calc end addr
    ADDU $s3, $a0, 1024
    
    .sdm32x2_wpass:
    // calc pass end addr
    ADDU $s2, $a0, 128
    
    .sdm32x2_bpass:
    // load input data
    LW $v0, 0($a0)
    LW $v1, 4($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1

    // ----------- SDM bit 1 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 2 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // load input data
    LW $v0, 8($a0)
    LW $v1, 12($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1
    
    // ----------- SDM bit 3 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 4 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // load input data
    LW $v0, 16($a0)
    LW $v1, 20($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1
    
    // ----------- SDM bit 5 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 6 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // load input data
    LW $v0, 24($a0)
    LW $v1, 28($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1
    
    // ----------- SDM bit 7 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 8 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc 
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // address input data increment
    ADDU $a0, $a0, 32
    // check pass end address
    BLTU $a0, $s2, .sdm32x2_bpass    
    // save result
    SW $s0, 0($a1)
    SW $s1, 4($a1)
    // output addr inc
    ADDU $a1, $a1, 8
    // check end address
    BLTU $a0, $s3, .sdm32x2_wpass
    
    // Save sdm accumulators
    SW $t0, 0($a2)  // acc1 L
    SW $t1, 4($a2)  // acc1 R
    SW $t2, 8($a2)  // acc2
    SW $t3, 12($a2) // acc3
    SW $t4, 16($a2) // acc4
    SW $t5, 20($a2) // acc5
    SW $t7, 24($a2) // reg MDO L
    SW $t8, 28($a2) // reg MDO R
    
    // restore data from stack   
    LW $s0, 0($sp)
    LW $s1, 4($sp)
    LW $s2, 8($sp)
    LW $s3, 12($sp)
    ADDU $sp, $sp, 16
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
/*
    sony5sdm_16x8 - SONY 5-th order SD modulator with x8 oversampling ratio.
		One pass generate 8 data bits and shift into shreg[] register.
		Function read four dual channel int32 samples and do four passes
		with write 32 bit dual channel resut to output.
     
    external declaration:     extern void sony5sdm_16x8(void *pSrc, void *pDst, volatile void *pSdm);

    input:
    pSrc - int32 source data pointer ($a0)
    pDSDM - sdm delay acc array pointer ($a2)

    output:
    pDest - uint32_t destination data pointer ($a1)
*/
sony5sdm_16x8:
    // save data to stack
    ADDU $sp, $sp, -16
    SW $s0, 0($sp)
    SW $s1, 4($sp)
    SW $s2, 8($sp)
    SW $s3, 12($sp)

    // Load sdm accumulators
    LW $t0, 0($a2)  // acc1 L
    LW $t1, 4($a2)  // acc1 R
    LW $t2, 8($a2)  // acc2
    LW $t3, 12($a2) // acc3
    LW $t4, 16($a2) // acc4
    LW $t5, 20($a2) // acc5
    LW $t7, 24($a2) // reg MDO L
    LW $t8, 28($a2) // reg MDO R
    
    // load quantize mask
    LI $a3, 0x1fffffff
    // calc end addr
    ADDU $s3, $a0, 512
    
    .sdm16x8_wpass:
    // calc pass end addr
    ADDU $s2, $a0, 32
    
    .sdm16x8_bpass:
    // load input data
    LW $v0, 0($a0)
    LW $v1, 4($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1

    // ----------- SDM bit 1 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 2 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 3 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 4 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 5 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 6 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 7 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 8 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc 
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // address input data increment
    ADDU $a0, $a0, 8
    // check pass end address
    BLTU $a0, $s2, .sdm16x8_bpass    
    // save result
    SW $s0, 0($a1)
    SW $s1, 4($a1)
    // output addr inc
    ADDU $a1, $a1, 8
    // check end address
    BLTU $a0, $s3, .sdm16x8_wpass
    
    // Save sdm accumulators
    SW $t0, 0($a2)  // acc1 L
    SW $t1, 4($a2)  // acc1 R
    SW $t2, 8($a2)  // acc2
    SW $t3, 12($a2) // acc3
    SW $t4, 16($a2) // acc4
    SW $t5, 20($a2) // acc5
    SW $t7, 24($a2) // reg MDO L
    SW $t8, 28($a2) // reg MDO R
    
    // restore data from stack   
    LW $s0, 0($sp)
    LW $s1, 4($sp)
    LW $s2, 8($sp)
    LW $s3, 12($sp)
    ADDU $sp, $sp, 16
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
/*
    sony5sdm_32x4 - SONY 5-th order SD modulator with x4 oversampling ratio.
		One pass generate 4 data bits and shift into shreg[] register.
		Function read four dual channel int32 samples and do 8 passes
		with write 32 bit dual channel resut to output.
     
    external declaration:     extern void sony5sdm_32x4(void *pSrc, void *pDst, volatile void *pSdm);

    input:
    pSrc - int32 source data pointer ($a0)
    pDSDM - sdm delay acc array pointer ($a2)

    output:
    pDest - uint32_t destination data pointer ($a1)
*/
sony5sdm_32x4:
    // save data to stack
    ADDU $sp, $sp, -16
    SW $s0, 0($sp)
    SW $s1, 4($sp)
    SW $s2, 8($sp)
    SW $s3, 12($sp)

    // Load sdm accumulators
    LW $t0, 0($a2)  // acc1 L
    LW $t1, 4($a2)  // acc1 R
    LW $t2, 8($a2)  // acc2
    LW $t3, 12($a2) // acc3
    LW $t4, 16($a2) // acc4
    LW $t5, 20($a2) // acc5
    LW $t7, 24($a2) // reg MDO L
    LW $t8, 28($a2) // reg MDO R
    
    // load quantize mask
    LI $a3, 0x1fffffff
    // calc end addr
    ADDU $s3, $a0, 1024
    
    .sdm32x4_wpass:
    // calc pass end addr
    ADDU $s2, $a0, 64
    
    .sdm32x4_bpass:
    // load input data
    LW $v0, 0($a0)
    LW $v1, 4($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1

    // ----------- SDM bit 1 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 2 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 3 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 4 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // load input data
    LW $v0, 8($a0)
    LW $v1, 12($a0)
    // Gain correct (-6db)
    SHRA_R.W $v0, $v0, 1
    SHRA_R.W $v1, $v1, 1
    
    // ----------- SDM bit 5 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 6 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 7 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // ----------- SDM bit 8 ---------------------------
    // acc1 L proc
    SUBU $t9, $v0, $t7
    ADDU $t0, $t0, $t9    
    // acc1 R proc
    SUBU $t9, $v1, $t8
    ADDU $t1, $t1, $t9
    // Pack 16bit data to 32bit vector
    PRECRQ.PH.W $t6, $t0, $t1
    // acc2 proc
    SHRA_R.PH	$t9, $t6, 1
    ADDU.PH	$t2, $t2, $t9
    SHRA_R.PH	$t9, $t3, 9
    SUBU.PH	$t2, $t2, $t9
    // acc3 proc
    SHRA_R.PH	$t9, $t2, 2
    ADDU.PH	$t3, $t3, $t9
    // acc4 proc 
    SHRA_R.PH	$t9, $t3, 3
    ADDU.PH	$t4, $t4, $t9
    SHRA_R.PH	$t9, $t5, 5
    SUBU.PH	$t4, $t4, $t9
    // acc5 proc
    SHRA_R.PH	$t9, $t4, 4
    ADDU.PH	$t5, $t5, $t9
    // Update MDO proc
    ADDU.PH	$t6, $t6, $t2
    ADDU.PH	$t6, $t6, $t3
    ADDU.PH	$t6, $t6, $t4
    ADDU.PH	$t6, $t6, $t5
    // Extract 16bit data from 32bit vector
    PRECEQ.W.PHR $t8, $t6
    // quantize output L
    SRA $t7, $t6, 31
    XOR $t7, $t7, $a3
    // quantize output R
    SRA $t8, $t8, 31
    XOR $t8, $t8, $a3
    // shift and load new bit in output bitsream register
    APPEND $s0, $t7, 1
    APPEND $s1, $t8, 1
    
    // address input data increment
    ADDU $a0, $a0, 16
    // check pass end address
    BLTU $a0, $s2, .sdm32x4_bpass    
    // save result
    SW $s0, 0($a1)
    SW $s1, 4($a1)
    // output addr inc
    ADDU $a1, $a1, 8
    // check end address
    BLTU $a0, $s3, .sdm32x4_wpass
    
    // Save sdm accumulators
    SW $t0, 0($a2)  // acc1 L
    SW $t1, 4($a2)  // acc1 R
    SW $t2, 8($a2)  // acc2
    SW $t3, 12($a2) // acc3
    SW $t4, 16($a2) // acc4
    SW $t5, 20($a2) // acc5
    SW $t7, 24($a2) // reg MDO L
    SW $t8, 28($a2) // reg MDO R
    
    // restore data from stack   
    LW $s0, 0($sp)
    LW $s1, 4($sp)
    LW $s2, 8($sp)
    LW $s3, 12($sp)
    ADDU $sp, $sp, 16
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
  
    
    
    
/*
// DoP recognition variables     
static int dspDoPcnt = 0;
static int dspMode = 0;	    // 0 - PCM, 1 - DoP
*/   

/*
    dop_check - DoP data format recognition
     
    external declaration:     extern int dop_check(void *pSrc, int mode, int *pCnt, int Lim);

    input:
    pSrc - int32 source data pointer ($a0)
    mode - data mod (DoP/PCM) ($a1)
    pCnt - mode chainge hysteresis counter pointer
    Lim - counter check limit
    
    output:
    int result: 0 - PCM data mode, 1 - DoP data mode ($v0)
*/
dop_check:
    // Set check header value
    LI $v1, 0x000000ff
    // Init recognition mode value
    LI $t8, 0
    // Load counter value
    LW $t9, ($a2)
    // Copy result from input
    ADDU $v0, $a1, $zero
    
    // Load 1 sample headers
    LBU $t0, 3($a0)
    LBU $t1, 7($a0)
    // If headers are not equal
    BNE $t0, $t1, .dop_check_done
    // check headers value
    BEQ $t0, $zero, .dop_check_done
    BEQ $t0, $v1, .dop_check_done

    // Load 2 sample headers
    LBU $t2, 11($a0)
    LBU $t3, 15($a0)
    // If headers are not equal
    BNE $t2, $t3, .dop_check_done
    // check inversion
    XOR $a1, $t2, $v1
    // If headers are not equal
    BNE $a1, $t0, .dop_check_done
    
    // Load 3 sample headers
    LBU $t4, 19($a0)
    LBU $t5, 23($a0)
    // If headers are not equal
    BNE $t4, $t5, .dop_check_done
    // If headers are not equal
    BNE $t0, $t4, .dop_check_done
    
    // Load 4 sample headers
    LBU $t6, 27($a0)
    LBU $t7, 31($a0)
    // If headers are not equal
    BNE $t6, $t7, .dop_check_done
    // If headers are not equal
    BNE $t2, $t6, .dop_check_done
    
    // If all checks pass - Set DoP flag
    ADDU $t8, $t8, 1    

    .dop_check_done:
    // check new format
    BNE $t8, $a1, .dop_check_fmt
    // If no format chainged - cleare counter & return
    ADDU $t9, $zero, $zero
    J .dop_check_return
    
    .dop_check_fmt: // if format is chainged
    // ounter inc
    ADDU $t9, $t9, 1
    // if counter lower than limit - return
    BLTU $t9, $a3, .dop_check_return
    // If counter reach limit - cleare counter
    ADDU $t9, $zero, $zero
    // set new result to return
    ADDU $v0, $t8, $zero
    
    .dop_check_return:
    // Save counter value
    SW $t9, ($a2)
    // return result
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
    
/*
    DoP  unpack control structure     
volatile static struct {
    void *pCurr;    // destination pointer
    void *pEnd;	    // destination end address    
    int size;	    // destination size in bytes
    int data[2];    // last data sample
    int zero;	    // zero value
} tDoPunp;
*/
    
/*
    dop_usb_unpack - copy DoP data unpack
     
    external declaration:     extern int dop_usb_unpack(volatile void *pUsbFifo, int Size, volatile void *tDoPunp, void *pBuf);
     
    input:
    pUsbFifo - USB FIFO pointer ($a0)
    Size - USB pckt size in bytes ($a1)
    tDoPunp - pointer to destination buffer control ($a2)
    pBuf - pointer to DoP recognition buffer ($a3)
     
    output:
    tDoPCtrl->pCurr - destination data pointer to DSD bitstream
    pBuf - data biffer to DoP recognition ($a3)
    return num of destination write bytes ($v0)
*/
dop_usb_unpack:
    // load destination pointers
    LW $t4, 0($a2)    
    // load destination end address
    LW $t5, 4($a2)
    // load destination size
    LW $t6, 8($a2)    
    // load previos packet data
    LW $t0, 12($a2)
    LW $t1, 16($a2)
    // load rezo value
    LW $t7, 20($a2)

    // If prevois packet data saved
    BNE $t0, $zero, .dop_usb_unpack_p1
    // Load two samples to DoP recognition
    LW $t0, ($a0)
    LW $t1, ($a0)
    // decrement pckt data size
    ADDU $a1, $a1, -8
    .dop_usb_unpack_p1:
    LW $t2, ($a0)
    LW $t3, ($a0)
    // save to buffer
    SW $t0, 0($a3)
    SW $t1, 4($a3)
    SW $t2, 8($a3)
    SW $t3, 12($a3)
    // align data to 16bit
    SRL $t0, $t0, 8
    SRL $t1, $t1, 8
    SRL $t2, $t2, 8
    SRL $t3, $t3, 8
    // append words
    APPEND $t0, $t2, 16
    APPEND $t1, $t3, 16
    // check zero value
    BNE $t0, $zero, .dop_usb_zero_pass1
    ADDU $t0, $zero, $t7
    .dop_usb_zero_pass1:
    BNE $t1, $zero, .dop_usb_zero_pass2
    ADDU $t1, $zero, $t7
    .dop_usb_zero_pass2:
    // save result
    SW $t0, 0($t4)
    SW $t1, 4($t4)

    // destination addr inc
    ADDU $t4, $t4, 8
    // check destination buffer overflow
    BLTU $t4, $t5, .dop_usb_unpack_p2
    SUBU $t4, $t4, $t6
    .dop_usb_unpack_p2:
    
    // Load two samples to DoP recognition
    LW $t0, ($a0)
    LW $t1, ($a0)
    LW $t2, ($a0)
    LW $t3, ($a0)
    // save to buffer
    SW $t0, 16($a3)
    SW $t1, 20($a3)
    SW $t2, 24($a3)
    SW $t3, 28($a3)
    // align data to 16bit
    SRL $t0, $t0, 8
    SRL $t1, $t1, 8
    SRL $t2, $t2, 8
    SRL $t3, $t3, 8
    // append words
    APPEND $t0, $t2, 16
    APPEND $t1, $t3, 16
    // check zero value
    BNE $t0, $zero, .dop_usb_zero_pass3
    ADDU $t0, $zero, $t7
    .dop_usb_zero_pass3:
    BNE $t1, $zero, .dop_usb_zero_pass4
    ADDU $t1, $zero, $t7
    .dop_usb_zero_pass4:
    // save result
    SW $t0, 0($t4)
    SW $t1, 4($t4)
    
    // destination addr inc
    ADDU $t4, $t4, 8
    // check destination buffer overflow
    BLTU $t4, $t5, .dop_usb_unpack_p3
    SUBU $t4, $t4, $t6
    .dop_usb_unpack_p3:
    
    // decrement pckt data size
    ADDU $a1, $a1, -24
    // inc destination words num
    ADDU $v0, $zero, 2

    .dop_usb_unpack_loop:
    // Load two samples to DoP recognition
    LW $t0, ($a0)
    LW $t1, ($a0)
    LW $t2, ($a0)
    LW $t3, ($a0)
    // align data to 16bit
    SRL $t0, $t0, 8
    SRL $t1, $t1, 8
    SRL $t2, $t2, 8
    SRL $t3, $t3, 8
    // append words
    APPEND $t0, $t2, 16
    APPEND $t1, $t3, 16
    // check zero value
    BNE $t0, $zero, .dop_usb_zero_pass5
    ADDU $t0, $zero, $t7
    .dop_usb_zero_pass5:
    BNE $t1, $zero, .dop_usb_zero_pass6
    ADDU $t1, $zero, $t7
    .dop_usb_zero_pass6:
    // save result
    SW $t0, 0($t4)
    SW $t1, 4($t4)
    
    // inc destination words num
    ADDU $v0, $v0, 1
    // destination addr inc
    ADDU $t4, $t4, 8
    // check destination buffer overflow
    BLTU $t4, $t5, .dop_usb_unpack_p4
    SUBU $t4, $t4, $t6
    .dop_usb_unpack_p4:
    // decrement pckt data size
    ADDU $a1, $a1, -16
    // check finish processing
    BGEU $a1, 16, .dop_usb_unpack_loop
    
    // cleare data register
    ADDU $t0, $zero, $zero
    // if no more source data
    BEQ $a1, $zero, .dop_usb_unpack_finish
    // Load last sample
    LW $t0, ($a0)
    LW $t1, ($a0)

    .dop_usb_unpack_finish:
    // save destination pointer
    SW $t4, 0($a2)
    // save previos packet data
    SW $t0, 12($a2)
    SW $t1, 16($a2)
    // return result
    J $ra
    
    
    
    
    
    
    
    
