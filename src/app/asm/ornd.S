/*
    *MIPS32 inpstructions assembler code
*/
    
    
/* Input data structure
volatile static struct {
    int fqw;		// full quantize width (quantize width + 2)
    int qsh;		// quantize shift (30 - quantize width)
    int oash;		// out align shift (32 - data width)
    int obmsk;		// offset binary mask
    int shL;		// shape feedback value Left
    int shR;		// shape feedback value Left
    int lfsr1;		// LFSR random generate register
    int lfsr2;		// LFSR random generate register to triangle noise generation
}tRndCtrl;    
*/
    
    
/* Global functions declarations */
.global dthrnd_f32
.global dthrnd_f16
.global shprnd_f32
.global shprnd_f16
    
    
    
    
    
    
    
    
    
/*
    dthrnd_f32 - overflow processing and and round with dithering
     
    external declaration:     extern void dthrnd_f32(void *pSrc, void *pDst, volatile void *pRnd, int Size);

    input:
    pSrc - int source data pointer ($a0)
    pRnd - control structure pointer ($a2)
    Size - size of input samples in bytes ($a3)

    output:
    pDst - int result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
*/    
dthrnd_f32:
    // load full quantize width (quantize width + 2)
    LW $t1, 0($a2)
    // load quantize shift (30 - quantize width)
    LW $t2, 4($a2)
    // load out data align shift (32 - data width)
    LW $t4, 8($a2)
    // load offset binary mask
    LW $t5, 12($a2)
    // load LFSR1 value
    LW $t8, 24($a2)
    // load LFSR2 value
    LW $t9, 28($a2)
    
    // calc end address
    ADDU $a3, $a0, $a3
    // calcl saturation shift (quantize shift + 2)
    ADDU $t3, $t2, 2

    .dthproc32:
    // LFSR1 one shift processing with 0xa3000000 polynome
    AND $v1, $t8, 1
    MUL $v1, $v1, 0xa3000000
    SRL $t8, $t8, 1
    XOR $t8, $t8, $v1
    // Noise width align
    SRA $t0, $t8, $t1
    // LFSR2 one shift processing with 0x94100000 polynome
    AND $v1, $t9, 1
    MUL $v1, $v1, 0x94100000
    SRL $t9, $t9, 1
    XOR $t9, $t9, $v1
    // Noise width align
    SRA $v1, $t9, $t1
    // summing of two dither noise values to triangle distribution
    ADDU $t0, $t0, $v1
    
    // *********** Left channel processing ***********
    // load input data
    LW $v0, 0($a0)
    // sum dither noise
    ADDU $v0, $v0, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    // restore gain with saturation
    SHLLV_S.W $v0, $v0, $t3
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save result
    SW $v0, 0($a1)
        
    // *********** Right channel processing **********
    // load input data
    LW $v0, 4($a0)
    // sum dither noise
    ADDU $v0, $v0, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    // restore gain with saturation
    SHLLV_S.W $v0, $v0, $t3
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save result
    SW $v0, 4($a1)
    
    // pointers increment
    ADDU $a0, $a0, 8
    ADDU $a1, $a1, 8
    // check end address
    BLTU $a0, $a3, .dthproc32
    // *********** Finish processing ***********
    // save LFSR1 value
    SW $t8, 24($a2)
    // save LFSR2 value
    SW $t9, 28($a2)
    // restore address pointer
    J $ra

    
    
    
    
    

    
    
    
    
/*
    dthrnd_f16 - overflow processing and and round with dithering
     
    external declaration:     extern void dthrnd_f16(void *pSrc, void *pDst, volatile void *pRnd, int Size);

    input:
    pSrc - int source data pointer ($a0)
    pRnd - control structure pointer ($a2)
    Size - size of input samples in bytes ($a3)

    output:
    pDst - int result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
*/    
dthrnd_f16:
    // load full quantize width (quantize width + 2)
    LW $t1, 0($a2)
    // load quantize shift (30 - quantize width)
    LW $t2, 4($a2)
    // load out data align shift (32 - data width)
    LW $t4, 8($a2)
    // load offset binary mask
    LW $t5, 12($a2)
    // load LFSR1 value
    LW $t8, 24($a2)
    // load LFSR2 value
    LW $t9, 28($a2)
    
    // calc end address
    ADDU $a3, $a0, $a3
    // calcl saturation shift (quantize shift + 2)
    ADDU $t3, $t2, 2

    .dthproc16:
    // LFSR1 one shift processing with 0xa3000000 polynome
    AND $v1, $t8, 1
    MUL $v1, $v1, 0xa3000000
    SRL $t8, $t8, 1
    XOR $t8, $t8, $v1
    // Noise width align
    SRA $t0, $t8, $t1
    // LFSR2 one shift processing with 0x94100000 polynome
    AND $v1, $t9, 1
    MUL $v1, $v1, 0x94100000
    SRL $t9, $t9, 1
    XOR $t9, $t9, $v1
    // Noise width align
    SRA $v1, $t9, $t1
    // summing of two dither noise values to triangle distribution
    ADDU $t0, $t0, $v1
    
    // *********** Left channel processing ***********
    // load input data
    LW $v0, 0($a0)
    // sum dither noise
    ADDU $v0, $v0, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    // restore gain with saturation
    SHLLV_S.W $v0, $v0, $t3
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save half word LSB
    SH $v0, 0($a1)
        
    // *********** Right channel processing **********
    // load input data
    LW $v0, 4($a0)
    // sum dither noise
    ADDU $v0, $v0, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    // restore gain with saturation
    SHLLV_S.W $v0, $v0, $t3
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save half word LSB
    SH $v0, 2($a1)
    
    // pointers increment
    ADDU $a0, $a0, 8
    ADDU $a1, $a1, 4
    // check end address
    BLTU $a0, $a3, .dthproc16
    // *********** Finish processing ***********
    // save LFSR1 value
    SW $t8, 24($a2)
    // save LFSR2 value
    SW $t9, 28($a2)
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
/*
    shprnd_f32 - overflow processing and and round with dithering and saping
     
    external declaration:     extern void shprnd_f32(void *pSrc, void *pDst, volatile void *pRnd, int Size);

    input:
    pSrc - int source data pointer ($a0)
    pRnd - control structure pointer ($a2)
    Size - size of input samples in bytes ($a3)

    output:
    pDst - int result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
*/    
shprnd_f32:
    // load full quantize width (quantize width + 2)
    LW $t1, 0($a2)
    // load quantize shift (30 - quantize width)
    LW $t2, 4($a2)
    // load out data align shift (32 - data width)
    LW $t4, 8($a2)
    // load offset binary mask
    LW $t5, 12($a2)
    // load ShapeL value
    LW $t6, 16($a2)
    // load ShapeR value
    LW $t7, 20($a2)
    // load LFSR1 value
    LW $t8, 24($a2)
    
    // calc end address
    ADDU $a3, $a0, $a3 

    .shproc32:
    // LFSR1 one shift processing with 0xa3000000 polynome
    AND $v1, $t8, 1
    MUL $v1, $v1, 0xa3000000
    SRL $t8, $t8, 1
    XOR $t8, $t8, $v1
    // Noise width align
    SRA $t0, $t8, $t1
    
    // *********** Left channel processing ***********
    // load input data
    LW $v1, 0($a0)
    // sum shape feedback
    ADDU $v1, $v1, $t6
    // sum dither noise
    ADDU $v0, $v1, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    SLL $v0, $v0, $t2
    // Update shaping feedback
    SUBU $t6, $v1, $v0
    // restore gain with saturation
    SHLL_S.W $v0, $v0, 2
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save result
    SW $v0, 0($a1)
        
    // *********** Right channel processing **********
    // load input data
    LW $v1, 4($a0)
    // sum shape feedback
    ADDU $v1, $v1, $t7
    // sum dither noise
    ADDU $v0, $v1, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    SLL $v0, $v0, $t2
    // Update shaping feedback
    SUBU $t7, $v1, $v0
    // restore gain with saturation
    SHLL_S.W $v0, $v0, 2
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save result
    SW $v0, 4($a1)
    
    // pointers increment
    ADDU $a0, $a0, 8
    ADDU $a1, $a1, 8
    // check end address
    BLTU $a0, $a3, .shproc32
    // *********** Finish processing ***********
    // save ShapeL value
    SW $t6, 16($a2)
    // save ShapeR value
    SW $t7, 20($a2)
    // save LFSR1 value
    SW $t8, 24($a2)
    // restore address pointer
    J $ra
    
    
    
    
    
    
    
    
    
    
    
    
/*
    shprnd_f16 - overflow processing and and round with dithering and saping
     
    external declaration:     extern void shprnd_f16(void *pSrc, void *pDst, volatile void *pRnd, int Size);

    input:
    pSrc - int source data pointer ($a0)
    pRnd - control structure pointer ($a2)
    Size - size of input samples in bytes ($a3)

    output:
    pDst - int result destination data pointer ($a1)

    Source data array must contain dual channel int32 data samples.
*/
shprnd_f16:
    // load full quantize width (quantize width + 2)
    LW $t1, 0($a2)
    // load quantize shift (30 - quantize width)
    LW $t2, 4($a2)
    // load out data align shift (32 - data width)
    LW $t4, 8($a2)
    // load offset binary mask
    LW $t5, 12($a2)
    // load ShapeL value
    LW $t6, 16($a2)
    // load ShapeR value
    LW $t7, 20($a2)
    // load LFSR1 value
    LW $t8, 24($a2)
    
    // calc end address
    ADDU $a3, $a0, $a3 

    .shproc16:
    // LFSR1 one shift processing with 0xa3000000 polynome
    AND $v1, $t8, 1
    MUL $v1, $v1, 0xa3000000
    SRL $t8, $t8, 1
    XOR $t8, $t8, $v1
    // Noise width align
    SRA $t0, $t8, $t1
    
    // *********** Left channel processing ***********
    // load input data
    LW $v1, 0($a0)
    // sum shape feedback
    ADDU $v1, $v1, $t6
    // sum dither noise
    ADDU $v0, $v1, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    SLL $v0, $v0, $t2
    // Update shaping feedback
    SUBU $t6, $v1, $v0
    // restore gain with saturation
    SHLL_S.W $v0, $v0, 2
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save half word LSB
    SH $v0, 0($a1)
        
    // *********** Right channel processing **********
    // load input data
    LW $v1, 4($a0)
    // sum shape feedback
    ADDU $v1, $v1, $t7
    // sum dither noise
    ADDU $v0, $v1, $t0
    // quantize - right shift with round
    SHRAV_R.W $v0, $v0, $t2
    SLL $v0, $v0, $t2
    // Update shaping feedback
    SUBU $t7, $v1, $v0
    // restore gain with saturation
    SHLL_S.W $v0, $v0, 2
    // Apply offset binary mask
    XOR $v0, $v0, $t5
    // Align output data to RJ
    SRL $v0, $v0, $t4
    // save half word LSB
    SH $v0, 2($a1)
    
    // pointers increment
    ADDU $a0, $a0, 8
    ADDU $a1, $a1, 4
    // check end address
    BLTU $a0, $a3, .shproc16    
    // *********** Finish processing ***********
    // save ShapeL value
    SW $t6, 16($a2)
    // save ShapeR value
    SW $t7, 20($a2)
    // save LFSR1 value
    SW $t8, 24($a2)
    // restore address pointer
    J $ra
