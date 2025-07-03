/* ************************************************************************** */
/* DSP processing */
/* ************************************************************************** */
#include "system.h"
#include "dsp.h"

#define DSP_DATA_MODE_PCM       0
#define DSP_DATA_MODE_DoP       1

/* Log Volume array with 70db range */
static const int aVolumeLog[101] = {
    0,1438,1558,1689,1831,1985,2151,2332,2527,2739,
    2969,3219,3489,3781,4099,4443,4816,5220,5658,6133,
    6648,7205,7810,8466,9176,9946,10781,11686,12667,13730,
    14882,16131,17485,18952,20543,22267,24136,26161,28357,30737,
    33317,36113,39144,42429,45990,49849,54033,58568,63483,68811,
    74586,80846,87631,94986,102958,111599,120965,131117,142122,154049,
    166978,180992,196182,212647,230494,249839,270807,293535,318170,344874,
    373818,405191,439198,476058,516012,559319,606261,657143,712295,772076,
    836874,907110,983241,1065761,1155207,1252160,1357250,1471160,1594630,1728462,
    1873527,2030766,2201202,2385942,2586187,2803238,3038505,3293517,3569932,3869545,
    4194304
};

volatile static struct {
    void *pCurr;	// destination curr pointer
    void *pEnd;		// destination end address
    int size;		// destination lenght in bytes
    int volumeL;	// volume value: min - 0, max - 0x40000000
    int volumeR;	// volume value: min - 0, max - 0x40000000
    int lfsr;		// LFSR random generate register
    int off;		// DC offset in 32-bit LSBs
} tAttCtrl;

/* Round control srtucture */
volatile static struct {
    int fqw;		// full quantize width (quantize width + 2)
    int qsh;		// quantize shift (30 - quantize width)
    int oash;		// out align shift (32 - data width)
    int obmsk;		// offset binary mask
    int shL;		// shape feedback value Left
    int shR;		// shape feedback value Left
    int lfsr1;		// LFSR random generate register
    int lfsr2;		// LFSR random generate register to triangle noise generation
} tRndCtrl; 

/* SDM control srtucture */
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

volatile static struct {
    void *pCurr;    // destination pointer
    void *pEnd;	    // destination end address    
    int size;	    // destination size in bytes
    int data[2];    // last data sample
    int zero;	    // zero value
} tDoPunp;

volatile static struct {
    struct {
        uint8_t passnum;
        uint8_t ovs;
        uint8_t ovsmax;
        uint8_t wlen;
        uint16_t outbsize;
    } tFir;
    
    struct {
        uint8_t shpena      :1;
        uint8_t dithen      :1;
        uint8_t roundw      :5;
        uint8_t reserved    :1;
    } tPCM;
    
    struct {
        uint8_t fmode       :3;
        uint8_t format      :1;
        uint8_t fchng       :1;
        uint8_t reserved    :3;
        int cnt;
    } tDoP;
    
    uint8_t fmode;      // output frame mode
    uint8_t sfreq;      // input sampling freqency
} tDspCtrl;

// FIR stage1 buffer and pointers
static uint64_t fir1buf[DSP_FIR1_FIFO_SIZE + DSP_FIR1_CELL_SIZE];
static int rptr1;
// FIR stage2 buffer and pointers
static uint64_t fir2buf[DSP_FIR2_FIFO_SIZE + DSP_FIR2_CELL_SIZE];
static int rptr2;
static int wptr2;
// FIR stage3 buffer and pointers
static uint64_t fir3buf[DSP_FIR3_FIFO_SIZE + DSP_FIR3_CELL_SIZE];
static int rptr3;
static int wptr3;
// FIR stage4 buffer and pointers
static uint64_t fir4buf[DSP_FIR4_FIFO_SIZE + DSP_FIR4_CELL_SIZE];
static int rptr4;
static int wptr4;
// FIR stage5 buffer and pointers
static uint64_t fir5buf[DSP_FIR5_FIFO_SIZE + DSP_FIR5_CELL_SIZE];
static int rptr5;
static int wptr5;
// FIR output round buffer
static uint64_t rndbuf[128];
// DoP recognition buffer
static uint64_t DoPbuf[4];
// Output Data Buffer and pointer
static uint64_t dspOutputFIFO[OUTPUT_BUFFER_bSIZE/8] __attribute__((coherent));
volatile int dspOutPtr; // Global parameter
static int dspOutPtrInc;

// read FIR start buffer pointers
static uint64_t *prFIR1 = fir1buf;
static uint64_t *prFIR2 = fir2buf;
static uint64_t *prFIR3 = fir3buf;
static uint64_t *prFIR4 = fir4buf;
static uint64_t *prFIR5 = fir5buf;
// write FIR start buffer pointers
static uint64_t *pwFIR2 = &fir2buf[DSP_FIR2_CELL_SIZE];
static uint64_t *pwFIR3 = &fir3buf[DSP_FIR3_CELL_SIZE];
static uint64_t *pwFIR4 = &fir4buf[DSP_FIR4_CELL_SIZE];
static uint64_t *pwFIR5 = &fir5buf[DSP_FIR5_CELL_SIZE];

/******************************************************************************/
/************************ DSP assemlber functions *****************************/
/******************************************************************************/
// Input data load & attenuation processing
extern int dsp_att32(volatile void *pUsbFifo, int Size, volatile void *pAtt);
extern int dsp_att32_fmt(volatile void *pUsbFifo, int Size, volatile void *pAtt, void *pBuf);
extern int dsp_att16(volatile void *pUsbFifo, int Size, volatile void *pAtt);
// Copy from tail to head FIR FIFO samples
extern void dsp_scpy(void *pSrc, void *pDst, int num);
// sm5842 FIR stages
extern void fir1_5842(void *pSrc, void *pDst, void *pEnd, int Size);
extern void fir2_5842(void *pSrc, void *pDst, void *pEnd, int Size);
extern void fir3_5842(void *pSrc, void *pDst);
// First x2 interpolation FIR stages to any input sampling frequency
extern void fir1_44SHRP(void *pSrc, void *pDst, void *pEnd, int Size);
extern void fir1_88(void *pSrc, void *pDst, void *pEnd, int Size);
extern void fir1_176(void *pSrc, void *pDst, void *pEnd, int Size);
extern void fir1_352(void *pSrc, void *pDst, void *pEnd, int Size);
// 2 to 5 x2 intertolation stages
extern void fir2(void *pSrc, void *pDst, void *pEnd, int Size);
extern void fir3(void *pSrc, void *pDst);
extern void fir4(void *pSrc, void *pDst);
extern void fir5(void *pSrc, void *pDst);
// Output round processing
extern void dthrnd_f32(void *pSrc, void *pDst, volatile void *pRnd, int Size);
extern void dthrnd_f16(void *pSrc, void *pDst, volatile void *pRnd, int Size);
extern void shprnd_f32(void *pSrc, void *pDst, volatile void *pRnd, int Size);
extern void shprnd_f16(void *pSrc, void *pDst, volatile void *pRnd, int Size);
// DSD64 output
extern void sony5sdm_16x4(void *pSrc, void *pDst, volatile void *pSdm);
extern void sony5sdm_32x2(void *pSrc, void *pDst, volatile void *pSdm);
// DSD128 output
extern void sony5sdm_16x8(void *pSrc, void *pDst, volatile void *pSdm);
extern void sony5sdm_32x4(void *pSrc, void *pDst, volatile void *pSdm);
// DoP processing
extern int dop_check(void *pSrc, int mode, volatile int *pCnt, int Lim);
extern int dop_usb_unpack(volatile void *pUsbFifo, int Size, volatile void *tDoPup, void *pBuf);
/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

/* Local functions */
volatile static void (*FIR1_callback)(void *pSrc, void *pDst, void *pEnd, int Size);
volatile static void (*ORND_callback)(void *pSrc, void *pDst, volatile void *pRnd, int Size);
volatile static void (*SDM5_callback)(void *pSrc, void *pDst, volatile void *pSdm);


/*
 * dsp_init()
 */
void dsp_init (void)
{
    tDspCtrl.fmode = OUT_FRM_MODE;
    tDspCtrl.tFir.ovsmax = FIR_OVS_MAX;
    tDspCtrl.tFir.outbsize = 32 << tDspCtrl.tFir.ovsmax;
    tDspCtrl.tDoP.format = DSP_DATA_MODE_PCM;
    tDspCtrl.tDoP.cnt = 0;  
    tDspCtrl.tPCM.shpena = NOISE_SHAPING_SET;
    tDspCtrl.tPCM.dithen = DITHERING_SET;
    tDspCtrl.tPCM.roundw = ROUND_DATA_WIDTH_bits;
    
#if OUT_FRM_MODE == OUT_FRM_PCM16    
    dspOutPtrInc = 2 << tDspCtrl.tFir.ovsmax;     // set processing samples num    
    if (tDspCtrl.tPCM.shpena)
        ORND_callback = shprnd_f16;
    else
        ORND_callback = dthrnd_f16;
#elif OUT_FRM_MODE == OUT_FRM_PCM32
    dspOutPtrInc = 4 << tDspCtrl.tFir.ovsmax;     // set processing samples num    
    if (tDspCtrl.tPCM.shpena)
        ORND_callback = shprnd_f32;
    else
        ORND_callback = dthrnd_f32;
#elif OUT_FRM_MODE == OUT_FRM_DSD64
    dspOutPtrInc = 8;
    if (tDspCtrl.tFir.ovsmax == FIR_OVS_x16)
        SDM5_callback = sony5sdm_16x4;
    else if (tDspCtrl.tFir.ovsmax == FIR_OVS_x32)
        SDM5_callback = sony5sdm_32x2;
#elif OUT_FRM_MODE == OUT_FRM_DSD128
    dspOutPtrInc = 16;
    if (tDspCtrl.tFir.ovsmax == FIR_OVS_x16)
        SDM5_callback = sony5sdm_16x8;
    else if (tDspCtrl.tFir.ovsmax == FIR_OVS_x32)
        SDM5_callback = sony5sdm_32x4;
#endif
    
    i2s_div_set( tDspCtrl.tFir.ovsmax, tDspCtrl.fmode );
    
#if OUT_FRM_MODE > OUT_FRM_PCM32
    tDoPunp.pEnd = &dspOutputFIFO[OUTPUT_BUFFER_bSIZE/8];
    tDoPunp.size = OUTPUT_BUFFER_bSIZE;
    tDoPunp.data[0] = 0;
    tDoPunp.data[1] = 0;
    tDoPunp.zero = 0x0fa50fa5;
#else
    // Init data to output round
    tRndCtrl.fqw = tDspCtrl.tPCM.roundw + 2;        // set quantize shift (round width + 2)
    tRndCtrl.qsh = 30 - tDspCtrl.tPCM.roundw;       // quantize shift (30 - round width)
    tRndCtrl.oash = 32 - OUTPUT_DATA_WIDTH_bits;    // out data align shift (32 - data width)
    tRndCtrl.obmsk = OFFSET_BINARY << 31;           // set offset binary mask
    tRndCtrl.lfsr1 = tDspCtrl.tPCM.dithen;          // set LFSR1 seed value
    tRndCtrl.lfsr2 = tDspCtrl.tPCM.dithen * 100;    // set LFSR2 seed value
#endif
    
    // Init volume control structure
    tAttCtrl.pEnd = &fir1buf[DSP_FIR1_FIFO_SIZE + DSP_FIR1_CELL_SIZE];
    tAttCtrl.size = DSP_FIR1_FIFO_bSIZE;
    tAttCtrl.lfsr = 100;
    tAttCtrl.off = DC_OFFSET_LSB << (24 - OUTPUT_DATA_WIDTH_bits);
#ifdef ATT_CONST
    tAttCtrl.volumeL = ATT_CONST;
    tAttCtrl.volumeR = ATT_CONST;
#else
    tAttCtrl.volumeL = VOLUME_ATT_0db;
    tAttCtrl.volumeR = VOLUME_ATT_0db;
#endif
    
    // Output data DMA address set
    _DMA_OutputSourceAddress_Set( KVA_TO_PA(dspOutputFIFO) );
}

/*
 * dsp_volume_set() - set volume in range from 0(mute) to 100(0db gain)
 */
void dsp_volume_set (uint8_t volume)
{
#ifndef ATT_CONST
    tAttCtrl.volumeL = aVolumeLog[volume];
    tAttCtrl.volumeR = aVolumeLog[volume];
#endif
}

/*
 * dsp_stop() - 
 */
void dsp_stop (void)
{
    dma_output_stop(OUTPUT_BUFFER_bSIZE);
}

/*
 * dsp_start_init() - 
 */
void dsp_start_init(uint8_t sfreq, uint8_t wlen)
{
#if OUT_FRM_MODE > OUT_FRM_PCM32
    if (tDspCtrl.tDoP.format == DSP_DATA_MODE_DoP)
    {
        if (wlen == 16 || sfreq < USB_SFREQ_176k) // if 16bit data
        {
            tDspCtrl.tDoP.format = DSP_DATA_MODE_PCM;
            tDspCtrl.tDoP.fchng = 1;
            tDspCtrl.tDoP.cnt = 0;
        }
        else if (tDspCtrl.sfreq != sfreq)
            i2s_div_set( tDspCtrl.tFir.ovsmax, tDspCtrl.tDoP.fmode );
    }
    
    if (tDspCtrl.tDoP.fchng) // if data format is caing
    {
        dma_output_stop(OUTPUT_BUFFER_bSIZE);
        tDspCtrl.tDoP.fchng = 0;

        if (tDspCtrl.tDoP.format == DSP_DATA_MODE_PCM)
            i2s_div_set( tDspCtrl.tFir.ovsmax, tDspCtrl.fmode );
        else
            i2s_div_set( tDspCtrl.tFir.ovsmax, tDspCtrl.tDoP.fmode );
    }
    
    // Init SDM control structure
    tSdmCtrl.acc1L = 0;
    tSdmCtrl.acc1R = 0;
    tSdmCtrl.acc2 = 0;
    tSdmCtrl.acc3 = 0;
    tSdmCtrl.acc4 = 0;
    tSdmCtrl.acc5 = 0;
    tSdmCtrl.rMDOL = 0xE0000000;
    tSdmCtrl.rMDOR = 0xE0000000;
    
    tDoPunp.pCurr = &dspOutputFIFO[(OUTPUT_BUFFER_bSIZE/8)*3/4];
#else
    // Cleare Shapers accumulators
    tRndCtrl.shL = 0;
    tRndCtrl.shR = 0;
#endif

    tDspCtrl.sfreq = sfreq;
    tDspCtrl.tFir.wlen = wlen;

    // Set read pointers to begin
    rptr1 = 0;
    rptr2 = 0;
    rptr3 = 0;
    rptr4 = 0;
    rptr5 = 0;
    // Set write pointers to middle
    tAttCtrl.pCurr = &fir1buf[DSP_FIR1_FIFO_SIZE/2 + DSP_FIR1_CELL_SIZE];
    wptr2 = DSP_FIR2_FIFO_SIZE/2;
    wptr3 = DSP_FIR3_FIFO_SIZE/2;
    wptr4 = DSP_FIR4_FIFO_SIZE/2;
    wptr5 = DSP_FIR5_FIFO_SIZE/2;

    // Cleare samples num
    _System_Num_Set(0);
    // Init output data pointer
    uint32_t dmaptr = DMA_OUTPUT_TRANSFET_PTR;
    dmaptr >>= 3;
    dspOutPtr = dmaptr + (OUTPUT_BUFFER_bSIZE/8)*3/4;
    dspOutPtr &= (OUTPUT_BUFFER_bSIZE/8-1);
    // start DMA output
    dma_parallel_output_start(OUTPUT_BUFFER_bSIZE);
}

/*
 * dsp_restart()
 */
void dsp_restart (uint8_t sfreq, uint8_t wlen)
{ 
    switch (sfreq)
    {
        case USB_SFREQ_44k:
        case USB_SFREQ_48k:
            //FIR1_callback = fir1_5842;
            FIR1_callback = fir1_44SHRP;
            tDspCtrl.tFir.passnum = 1 << FIR_OVS_x1;
            tDspCtrl.tFir.ovs = (tDspCtrl.tFir.ovsmax < FIR_OVS_x1) ? FIR_OVS_x1 : (tDspCtrl.tFir.ovsmax - FIR_OVS_x1);
            break;

        case USB_SFREQ_88k:
        case USB_SFREQ_96k:
            FIR1_callback = fir1_88;
            tDspCtrl.tFir.passnum = 1 << FIR_OVS_x2;
            tDspCtrl.tFir.ovs = (tDspCtrl.tFir.ovsmax < FIR_OVS_x2) ? FIR_OVS_x1 : (tDspCtrl.tFir.ovsmax - FIR_OVS_x2);
            break;

        case USB_SFREQ_176k:
        case USB_SFREQ_192k:
            FIR1_callback = fir1_176;
            tDspCtrl.tFir.passnum = 1 << FIR_OVS_x4;
            tDspCtrl.tFir.ovs = (tDspCtrl.tFir.ovsmax < FIR_OVS_x4) ? FIR_OVS_x1 : (tDspCtrl.tFir.ovsmax - FIR_OVS_x4);
            tDspCtrl.tDoP.fmode = OUT_FRM_DSD64;
            break;
            
        case USB_SFREQ_352k:
        case USB_SFREQ_384k:
            FIR1_callback = fir1_352;
            tDspCtrl.tFir.passnum = 1 << FIR_OVS_x8;
            tDspCtrl.tFir.ovs = (tDspCtrl.tFir.ovsmax < FIR_OVS_x8) ? FIR_OVS_x1 : (tDspCtrl.tFir.ovsmax - FIR_OVS_x8);
            tDspCtrl.tDoP.fmode = OUT_FRM_DSD128;
            break;
            
        case USB_SFREQ_705k:
        case USB_SFREQ_768k:
            tDspCtrl.tFir.passnum = 1 << FIR_OVS_x16;
            tDspCtrl.tFir.ovs = (tDspCtrl.tFir.ovsmax < FIR_OVS_x16) ? FIR_OVS_x1 : (tDspCtrl.tFir.ovsmax - FIR_OVS_x16);
            tDspCtrl.tDoP.fmode = OUT_FRM_DSD256;
            break;
            
        default: FIR1_callback = NULL; return;
    }

    dsp_start_init(sfreq, wlen);
}

/*
 * dsp_usb_data_load() - load from USB fifo & attenuate
 */
void dsp_usb_data_load (volatile void *pFifo, uint16_t rxcnt)
{
    if (tDspCtrl.tFir.wlen == 16) // if 16bit data
    {
        rxcnt <<= 1;
        if ( dsp_att16(pFifo, rxcnt, &tAttCtrl) )
            dsp_scpy( &fir1buf[DSP_FIR1_FIFO_SIZE], fir1buf, DSP_FIR1_CELL_bSIZE );
        
        _System_Num_Inc(rxcnt);
    }
#if OUT_FRM_MODE < OUT_FRM_DSD64
    else // if 24 or 32 bit data
    {        
        if ( dsp_att32(pFifo, rxcnt, &tAttCtrl) )
            dsp_scpy( &fir1buf[DSP_FIR1_FIFO_SIZE], fir1buf, DSP_FIR1_CELL_bSIZE );
        
        _System_Num_Inc(rxcnt);
    }
#else
    else if (tDspCtrl.sfreq < USB_SFREQ_176k) // if sampling frequency is lower than 176.4kHz
    {        
        if ( dsp_att32(pFifo, rxcnt, &tAttCtrl) )
            dsp_scpy( &fir1buf[DSP_FIR1_FIFO_SIZE], fir1buf, DSP_FIR1_CELL_bSIZE );
        
        _System_Num_Inc(rxcnt);
    }
    else    // Check DoP data on input
    {
        if (tDspCtrl.tDoP.format == DSP_DATA_MODE_PCM)
        {
            if ( dsp_att32_fmt(pFifo, rxcnt, &tAttCtrl, &DoPbuf) )
                dsp_scpy( &fir1buf[DSP_FIR1_FIFO_SIZE], fir1buf, DSP_FIR1_CELL_bSIZE );
            
            _System_Num_Inc(rxcnt);
        }
        else if (tDspCtrl.tDoP.format == DSP_DATA_MODE_DoP)
        {
            dspOutPtr += dop_usb_unpack(pFifo, rxcnt, &tDoPunp, &DoPbuf);
            dspOutPtr &= (OUTPUT_BUFFER_bSIZE/8-1);
        }
        
        int newMode = dop_check(&DoPbuf, tDspCtrl.tDoP.format, &tDspCtrl.tDoP.cnt, DoP_PCM_SWITCH_HYS);
        
        if (newMode != tDspCtrl.tDoP.format) // if data mode is chainged
        {            
            tDspCtrl.tDoP.format = newMode;
            tDspCtrl.tDoP.fchng = 1;
            dsp_start_init(tDspCtrl.sfreq, tDspCtrl.tFir.wlen);
        }
    }
#endif
}
    
/*******************************************************************************
 * dsp_proc() - FIR processing with input attenuation 
 * and output round with dithering and noise shaping
 ******************************************************************************/
void dsp_proc (void)
{
    // FIR pass num counter - count num of input sapmples processed
    int pass = tDspCtrl.tFir.passnum;
    // Output Round Buffer pointer
    int rndptr = 0;
    
    // Disable Global Interrupts
    __builtin_disable_interrupts();
    // Decrements samples bytes num: (4 bytes Left + 4 bytes Right) * 4 * dspFirPassNum
    _System_Num_Dec(pass << 5);
    // Enable Global Interrupts
    __builtin_enable_interrupts();
    
    while (pass--)
    {
        /************************************************
        ******* One Input Sample Processing *************
        ************************************************/        
        // ************* FIR ByPass processing *******************************
        if (tDspCtrl.tFir.ovs == FIR_OVS_x1) {
            // Copy 4 samples to output buffer
            rndbuf[rndptr] = prFIR1[rptr1];
            rndbuf[rndptr+1] = prFIR1[rptr1+1];
            rndbuf[rndptr+2] = prFIR1[rptr1+2];
            rndbuf[rndptr+3] = prFIR1[rptr1+3];
            // FIR read pointer increment & masking
            rptr1 += 4;
            rptr1 &= (DSP_FIR1_FIFO_SIZE-1);
            rndptr += 4;
            continue;
        }

        // ************* Stage 1 FIR x2 upsampler processing *****************
        if (tDspCtrl.tFir.ovs == FIR_OVS_x2) {
            FIR1_callback( &prFIR1[rptr1], &rndbuf[rndptr], &prFIR1[DSP_FIR1_FIFO_SIZE], DSP_FIR1_FIFO_bSIZE );
            // FIR read pointer increment & masking
            rptr1 += 4;
            rptr1 &= (DSP_FIR1_FIFO_SIZE-1);
            rndptr += 8;
            continue;
        }
        FIR1_callback( &prFIR1[rptr1], &pwFIR2[wptr2], &prFIR1[DSP_FIR1_FIFO_SIZE], DSP_FIR1_FIFO_bSIZE );
        // FIR read pointer increment & masking
        rptr1 += 4;
        rptr1 &= (DSP_FIR1_FIFO_SIZE-1);
        // FIR write pointer increment & masking
        wptr2 += 8;
        wptr2 &= (DSP_FIR2_FIFO_SIZE-1);
        if (wptr2 == 0) // Copy tail to head
            dsp_scpy( &fir2buf[DSP_FIR2_FIFO_SIZE], fir2buf, DSP_FIR2_CELL_bSIZE );

        // ************* Stage 2 FIR x4 upsampler processing *****************
        if (tDspCtrl.tFir.ovs == FIR_OVS_x4) {
            //fir2_5842( &prFIR2[rptr2], &rndbuf[rndptr], &prFIR2[DSP_FIR2_FIFO_SIZE], DSP_FIR2_FIFO_bSIZE );
            fir2( &prFIR2[rptr2], &rndbuf[rndptr], &prFIR2[DSP_FIR2_FIFO_SIZE], DSP_FIR2_FIFO_bSIZE );
            // FIR read pointer increment & masking
            rptr2 += 8;
            rptr2 &= (DSP_FIR2_FIFO_SIZE-1);
            rndptr += 16;
            continue;
        }
        //fir2_5842( &prFIR2[rptr2], &pwFIR3[wptr3], &prFIR2[DSP_FIR2_FIFO_SIZE], DSP_FIR2_FIFO_bSIZE );
        fir2( &prFIR2[rptr2], &pwFIR3[wptr3], &prFIR2[DSP_FIR2_FIFO_SIZE], DSP_FIR2_FIFO_bSIZE );
        // FIR read pointer increment & masking
        rptr2 += 8;
        rptr2 &= (DSP_FIR2_FIFO_SIZE-1);
        // FIR write pointer increment & masking
        wptr3 += 16;
        wptr3 &= (DSP_FIR3_FIFO_SIZE-1);
        if (wptr3 == 0) // Copy tail to head
            dsp_scpy( &fir3buf[DSP_FIR3_FIFO_SIZE], fir3buf, DSP_FIR3_CELL_bSIZE );

        // ************* Stage 3 FIR x8 upsampler processing *****************
        if (tDspCtrl.tFir.ovs == FIR_OVS_x8) {
            //fir3_5842( &prFIR3[rptr3], &rndbuf[rndptr] );
            fir3( &prFIR3[rptr3], &rndbuf[rndptr] );
            // FIR read pointer increment & masking
            rptr3 += 16;
            rptr3 &= (DSP_FIR3_FIFO_SIZE-1);
            rndptr += 32;
            continue;
        }
        //fir3_5842( &prFIR3[rptr3], &pwFIR4[wptr4] );
        fir3( &prFIR3[rptr3], &pwFIR4[wptr4] );
        // FIR read pointer increment & masking
        rptr3 += 16;
        rptr3 &= (DSP_FIR3_FIFO_SIZE-1);
        // FIR write pointer increment & masking
        wptr4 += 32;
        wptr4 &= (DSP_FIR4_FIFO_SIZE-1);
        if (wptr4 == 0) // Copy tail to head
            dsp_scpy( &fir4buf[DSP_FIR4_FIFO_SIZE], fir4buf, DSP_FIR4_CELL_bSIZE );

        // ************* Stage 4 FIR x16 upsampler processing *****************
        if (tDspCtrl.tFir.ovs == FIR_OVS_x16) {
            fir4( &prFIR4[rptr4], &rndbuf[rndptr] );
            // FIR read pointer increment & masking
            rptr4 += 32;
            rptr4 &= (DSP_FIR4_FIFO_SIZE-1);
            rndptr += 64;
            continue;
        }
        fir4( &prFIR4[rptr4], &pwFIR5[wptr5] );
        // FIR read pointer increment & masking
        rptr4 += 32;
        rptr4 &= (DSP_FIR4_FIFO_SIZE-1);
        // FIR write pointer increment & masking
        wptr5 += 64;
        wptr5 &= (DSP_FIR5_FIFO_SIZE-1);
        if (wptr5 == 0) // Copy tail to head
            dsp_scpy( &fir5buf[DSP_FIR5_FIFO_SIZE], fir5buf, DSP_FIR5_CELL_bSIZE );
        
        // ************* Stage 5 FIR x32 upsampler processing *****************
        fir5( &prFIR5[rptr5], &rndbuf[rndptr] );
        // FIR read pointer increment & masking
        rptr5 += 64;
        rptr5 &= (DSP_FIR5_FIFO_SIZE-1);
    };
    
#if OUT_FRM_MODE < OUT_FRM_DSD64
    // Output overflow and round processing
    ORND_callback( rndbuf, &dspOutputFIFO[dspOutPtr], &tRndCtrl, tDspCtrl.tFir.outbsize );
#else
    // Output SDM processing
    SDM5_callback( rndbuf, &dspOutputFIFO[dspOutPtr], &tSdmCtrl );
#endif
    
    // Output pointer increment & masking
    dspOutPtr += dspOutPtrInc;
    dspOutPtr &= (OUTPUT_BUFFER_bSIZE/8-1);
}



