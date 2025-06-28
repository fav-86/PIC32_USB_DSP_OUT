
#include "../../app/system.h"
#include "dma.h"

#if OUT_FRM_MODE == OUT_FRM_PCM16
    #define WCK_VAL     0x0001u
    #define DG_VAL      0xFF81u
    #define WSIZ        2
    #define ZERO_VAL    0
    #define WCKO_ENA
    #define DGO_ENA
#elif OUT_FRM_MODE == OUT_FRM_PCM32
    #define WCK_VAL     0x00000001
    #define DG_VAL      0xFFFFE001
    #define WSIZ        4
    #define ZERO_VAL    0
    #define WCKO_ENA
    #define DGO_ENA
#else
    #define WCK_VAL     0
    #define DG_VAL      0
    #define WSIZ        4
    #define ZERO_VAL    0x0fa50fa5
#endif


// One sample dual channel data buffer
static uint32_t sampleBuffer[2] __attribute__((coherent));
// One sample buffer to mute data generation
static uint32_t zeroData __attribute__((coherent));
// WordClock frame data
static uint32_t wckData __attribute__((coherent));
// Deglitcher frame data
static uint32_t dgData __attribute__((coherent));


/*
 * dma_init()
 */
void dma_init (void)
{
    // cleare zero data and sample buffer    
    zeroData = ZERO_VAL;
    sampleBuffer[0] = ZERO_VAL;
    sampleBuffer[1] = ZERO_VAL;
    wckData = WCK_VAL;
    dgData = DG_VAL;
    
    // Enable DMA controller
    DMACONbits.ON = 1;
    
    /**************************************************************************/
    /* Channel 0 config - to copy left ch data from sample buffer to SPI1     */
    /**************************************************************************/    
    DCH0SSA = KVA_TO_PA( sampleBuffer );        // Source start address
    DCH0DSA = KVA_TO_PA( &SPI1BUF );            // Destination start address
    DCH0SSIZ = WSIZ;                            // Source size
    DCH0DSIZ = WSIZ;                            // Destination size
    DCH0CSIZ = WSIZ;                            // Cell data size: channel audio data size (4 bytes)
    DCH0CONbits.CHPRI = 2;                      // Channel priority
    DCH0CONbits.CHAEN = 1;                      // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
    // Only separate fields support!!!!
    DCH0ECONbits.CHSIRQ = _SPI1_TX_VECTOR;      // Channel Transfer Start IRQ
    DCH0ECONbits.SIRQEN = 1;                    // Enable transfer IRQ
    DCH0CONbits.CHEN = 1;                       // Enable DMA channel
    
    /**************************************************************************/
    /* Channel 1 config - to copy right ch data from sample buffer to SPI3    */
    /**************************************************************************/
    DCH1SSA = KVA_TO_PA( (void*)sampleBuffer + WSIZ ); // Source start address
    DCH1DSA = KVA_TO_PA( &SPI3BUF );            // Destination start address
    DCH1SSIZ = WSIZ;                            // Source size
    DCH1DSIZ = WSIZ;                            // Destination size
    DCH1CSIZ = WSIZ;                            // Cell data size: channel audio data size (4 bytes)
    DCH1CONbits.CHPRI = 2;                      // Channel priority
    DCH1CONbits.CHAEN = 1;                      // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
     // Only separate fields support!!!!
    DCH1ECONbits.CHSIRQ = _SPI1_TX_VECTOR;      // Channel Transfer Start IRQ
    DCH1ECONbits.SIRQEN = 1;                    // Enable transfer IRQ
    DCH1CONbits.CHEN = 1;                       // Enable DMA channel
    
    /**************************************************************************/
    /* Channel 2 config - to copy word clock data to SPI4                     */
    /**************************************************************************/
#ifdef WCKO_ENA
    DCH2SSA = KVA_TO_PA( &wckData );            // Source start address
    DCH2DSA = KVA_TO_PA( &SPI4BUF );            // Destination start address
    DCH2SSIZ = WSIZ;                            // Source size
    DCH2DSIZ = WSIZ;                            // Destination size
    DCH2CSIZ = WSIZ;                            // Cell data size: channel audio data size (4 bytes)
    DCH2CONbits.CHPRI = 2;                      // Channel priority
    DCH2CONbits.CHAEN = 1;                      // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
     // Only separate fields support!!!!
    DCH2ECONbits.CHSIRQ = _SPI1_TX_VECTOR;      // Channel Transfer Start IRQ
    DCH2ECONbits.SIRQEN = 1;                    // Enable transfer IRQ
    DCH2CONbits.CHEN = 1;                       // Enable DMA channel
#endif
    /**************************************************************************/
    /* Channel 3 config - to copy deglitcher clock data to SPI2               */
    /**************************************************************************/
#ifdef DGO_ENA
    DCH3SSA = KVA_TO_PA( &dgData );             // Source start address
    DCH3DSA = KVA_TO_PA( &SPI2BUF );            // Destination start address
    DCH3SSIZ = WSIZ;                            // Source size
    DCH3DSIZ = WSIZ;                            // Destination size
    DCH3CSIZ = WSIZ;                            // Cell data size: channel audio data size (4 bytes)
    DCH3CONbits.CHPRI = 2;                      // Channel priority
    DCH3CONbits.CHAEN = 1;                      // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
     // Only separate fields support!!!!
    DCH3ECONbits.CHSIRQ = _SPI1_TX_VECTOR;      // Channel Transfer Start IRQ
    DCH3ECONbits.SIRQEN = 1;                    // Enable transfer IRQ
    //DCH3CONbits.CHEN = 1;                     // Enable DMA channel
#endif
    /**************************************************************************/
    /* Channel 4 config - to copy one sample from OUTPUT FIFO to sample buffer*/
    /**************************************************************************/
    DCH4DSA = KVA_TO_PA( sampleBuffer );        // Destination address (sample buffer)    
    DCH4DSIZ = WSIZ*2;                          // Destination size (one stereo sample size)
    DCH4CSIZ = WSIZ*2;                          // Cell data size: channel audio data size (8 bytes)
    DCH4CONbits.CHPRI = 1;                      // Channel priority
    DCH4CONbits.CHAEN = 1;                      // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
    // Only separate fields support!!!!
    DCH4ECONbits.CHSIRQ = _SPI1_TX_VECTOR;      // Channel Transfer Start IRQ
    DCH4ECONbits.SIRQEN = 1;                    // Enable transfer IRQ

    /**************************************************************************/
    /* Channel 5 config - to copy zero data to OUTPUT FIFO                    */
    /**************************************************************************/
    DCH5SSA = KVA_TO_PA( &zeroData );           // Source data start address
    DCH5SSIZ = 4;                               // Source size    
    // Only separate fields support!!!!
    DCH5ECONbits.CHSIRQ = _SPI1_TX_VECTOR;      // Channel Transfer Start IRQ    

}

/*
 * dma_parallel_output_start()
 */
void dma_parallel_output_start (const uint16_t size)
{   
    DCH5ECONbits.CABORT = 1;        
    while (DCH5CONbits.CHBUSY);
    
    DCH4SSIZ = size;                // Source size    
    DCH5DSIZ = size;                // Destination size
    DCH5CSIZ = WSIZ*2;              // Cell data size
    DCH5CONbits.CHAEN = 1;          // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
    DCH5ECONbits.SIRQEN = 1;        // Enable transfer IRQ
    
    // Enable DMA channel
    DCH4CONbits.CHEN = 1;    
    DCH5CONbits.CHEN = 1;
}


/*
 * dma_output_stop()
 */
void dma_output_stop (const uint16_t size)
{    
    DCH4ECONbits.CABORT = 1;
    DCH5ECONbits.CABORT = 1;
    
    while (DCH4CONbits.CHBUSY);
    while (DCH5CONbits.CHBUSY);
    
    // Cleare intermediate sample buffer
    sampleBuffer[0] = ZERO_VAL;
    sampleBuffer[1] = ZERO_VAL;
    
    // Cleare all output FIFO buffer
    DCH5CSIZ = size;                    // Cell data size
    DCH5CONbits.CHAEN = 0;              // Channel is continuously enabled, and not automatically disabled after a block transfer is complete
    DCH5ECONbits.SIRQEN = 0;            // Disable transfer IRQ
    DCH5CONbits.CHEN = 1;               // Enable DMA channel
    DCH5ECONbits.CFORCE = 1;            // Force start channel
}


