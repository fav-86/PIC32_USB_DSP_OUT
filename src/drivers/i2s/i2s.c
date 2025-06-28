

#include "../../app/system.h"
#include "i2s.h"


#if   OUT_FRM_MODE == OUT_FRM_PCM16    
    #define _SPIxCON_MODE32_MASK        0
#else
    #define _SPIxCON_MODE32_MASK        _SPI1CON_MODE32_MASK
#endif


/*
 SPI based I2S modules initialisation  
 */
void i2s_init (void)
{
    /**************************************************************************/
    /* I2S1 output module initialisation                                      */
    /**************************************************************************/
    SPI1CON2 = 0
            | _SPI1CON2_AUDEN_MASK      // Audio protocol enabled
            | (0x1 << _SPI1CON2_AUDMOD_POSITION) // Left-Justified mode
            | _SPI1CON2_IGNTUR_MASK     // Ignore Transmit Underrun
            ;
    SPI1CON = 0
            //| _SPI1CON_FRMPOL_MASK      // Frame Sync Polarity
            | _SPI1CON_MCLKSEL_MASK     // MCLK is used by the Baud Rate Generator
            | _SPI1CON_ENHBUF_MASK      // Enhanced Buffer mode is enabled
            | _SPIxCON_MODE32_MASK      // 32-bit Data, 32-bit FIFO, 32-bit Channel/64-bit Frame
            | _SPI1CON_CKP_MASK         // Idle state for clock is a high level; active state is a low level
            | _SPI1CON_MSTEN_MASK       // Master mode
            | _SPI1CON_DISSDI_MASK      // SDIx pin is not used by the SPI module (pin is controlled by PORT function)
            | (0x3 << _SPI1CON_STXISEL_POSITION) // see lower            
                // STXISEL<1:0>: SPI Transmit Buffer Empty Interrupt Mode bits
                // 11 = Interrupt is generated when the buffer is not full (has one or more empty elements)
                // 10 = Interrupt is generated when the buffer is empty by one-half or more
                // 01 = Interrupt is generated when the buffer is completely empty
                // 00 = Interrupt is generated when the last transfer is shifted out of SPISR and transmit operations are complete
            | _SPI1CON_ON_MASK
            ;
    
    /**************************************************************************/
    /* I2S2 output module initialisation                                      */
    /**************************************************************************/
    SPI2CON2 = 0
            | _SPI2CON2_AUDEN_MASK      // Audio protocol enabled
            | (0x1 << _SPI2CON2_AUDMOD_POSITION) // Left-Justified mode
            | _SPI2CON2_IGNTUR_MASK     // Ignore Transmit Underrun
            ;
    SPI2CON = 0
            //| _SPI2CON_FRMPOL_MASK      // Frame Sync Polarity
            | _SPI2CON_MCLKSEL_MASK     // MCLK is used by the Baud Rate Generator
            | _SPI2CON_ENHBUF_MASK      // Enhanced Buffer mode is enabled
            | _SPIxCON_MODE32_MASK      // 32-bit Data, 32-bit FIFO, 32-bit Channel/64-bit Frame
            | _SPI2CON_CKP_MASK         // Idle state for clock is a high level; active state is a low level
            | _SPI2CON_MSTEN_MASK       // Master mode
            | _SPI2CON_DISSDI_MASK      // SDIx pin is not used by the SPI module (pin is controlled by PORT function)
            | (0x3 << _SPI2CON_STXISEL_POSITION) // see lower            
                // STXISEL<1:0>: SPI Transmit Buffer Empty Interrupt Mode bits
                // 11 = Interrupt is generated when the buffer is not full (has one or more empty elements)
                // 10 = Interrupt is generated when the buffer is empty by one-half or more
                // 01 = Interrupt is generated when the buffer is completely empty
                // 00 = Interrupt is generated when the last transfer is shifted out of SPISR and transmit operations are complete
            | _SPI2CON_ON_MASK
            ;
    
    /**************************************************************************/
    /* I2S3 output module initialisation                                      */
    /**************************************************************************/
    SPI3CON2 = 0
            | _SPI3CON2_AUDEN_MASK      // Audio protocol enabled
            | (0x1 << _SPI3CON2_AUDMOD_POSITION) // Left-Justified mode
            | _SPI3CON2_IGNTUR_MASK     // Ignore Transmit Underrun
            ;
    SPI3CON = 0
            //| _SPI3CON_FRMPOL_MASK      // Frame Sync Polarity
            | _SPI3CON_MCLKSEL_MASK     // MCLK is used by the Baud Rate Generator
            | _SPI3CON_ENHBUF_MASK      // Enhanced Buffer mode is enabled
            | _SPIxCON_MODE32_MASK      // 32-bit Data, 32-bit FIFO, 32-bit Channel/64-bit Frame
            | _SPI3CON_CKP_MASK         // Idle state for clock is a high level; active state is a low level
            | _SPI3CON_MSTEN_MASK       // Master mode
            | _SPI3CON_DISSDI_MASK      // SDIx pin is not used by the SPI module (pin is controlled by PORT function)
            | (0x3 << _SPI3CON_STXISEL_POSITION) // see lower            
                // STXISEL<1:0>: SPI Transmit Buffer Empty Interrupt Mode bits
                // 11 = Interrupt is generated when the buffer is not full (has one or more empty elements)
                // 10 = Interrupt is generated when the buffer is empty by one-half or more
                // 01 = Interrupt is generated when the buffer is completely empty
                // 00 = Interrupt is generated when the last transfer is shifted out of SPISR and transmit operations are complete
            | _SPI3CON_ON_MASK
            ;    
    
    /**************************************************************************/
    /* I2S4 output module initialisation                                      */
    /**************************************************************************/
    SPI4CON2 = 0
            | _SPI4CON2_AUDEN_MASK      // Audio protocol enabled
            | (0x1 << _SPI4CON2_AUDMOD_POSITION) // Left-Justified mode
            | _SPI4CON2_IGNTUR_MASK     // Ignore Transmit Underrun
            ;
    SPI4CON = 0
            //| _SPI4CON_FRMPOL_MASK      // Frame Sync Polarity
            | _SPI4CON_MCLKSEL_MASK     // MCLK is used by the Baud Rate Generator
            | _SPI4CON_ENHBUF_MASK      // Enhanced Buffer mode is enabled
            | _SPIxCON_MODE32_MASK      // 32-bit Data, 32-bit FIFO, 32-bit Channel/64-bit Frame
            | _SPI4CON_CKP_MASK         // Idle state for clock is a high level; active state is a low level
            | _SPI4CON_MSTEN_MASK       // Master mode
            | _SPI4CON_DISSDI_MASK      // SDIx pin is not used by the SPI module (pin is controlled by PORT function)
            | (0x3 << _SPI4CON_STXISEL_POSITION) // see lower            
                // STXISEL<1:0>: SPI Transmit Buffer Empty Interrupt Mode bits
                // 11 = Interrupt is generated when the buffer is not full (has one or more empty elements)
                // 10 = Interrupt is generated when the buffer is empty by one-half or more
                // 01 = Interrupt is generated when the buffer is completely empty
                // 00 = Interrupt is generated when the last transfer is shifted out of SPISR and transmit operations are complete
            | _SPI4CON_ON_MASK
            ;
}


/*
 * i2s_div_set() - Set SPI clock divding ratio
 */
void i2s_div_set (const uint8_t ovsmax, const uint8_t fmode)
{
uint32_t div;

#ifdef I2S_MCLK_1024Fs
    switch (fmode) {
        case OUT_FRM_PCM16: div = (1 << (FIR_OVS_x32 - ovsmax)) >> 1; break;
        case OUT_FRM_PCM32: div = (1 << (FIR_OVS_x32 - ovsmax)) >> 2; break;
        case OUT_FRM_DSD64: div = 4; break;
        case OUT_FRM_DSD128: div = 2; break;
        case OUT_FRM_DSD256: div = 1; break;
        default: return;
    }
#endif

#ifdef I2S_MCLK_512Fs
    switch (fmode) {
        case OUT_FRM_PCM16: div = (1 << (FIR_OVS_x32 - ovsmax)) >> 2; break;
        case OUT_FRM_PCM32: div = (1 << (FIR_OVS_x32 - ovsmax)) >> 3; break;
        case OUT_FRM_DSD64: div = 2; break;
        case OUT_FRM_DSD128: div = 1; break;
        case OUT_FRM_DSD256: div = 0; break;
        default: return;
    }
#endif
        
    REFO1CONbits.ON = 0;
    while (REFO1CONbits.ACTIVE != REFO1CONbits.ON);
    
    REFO1CON = 0
            | (div << _REFO1CON_RODIV_POSITION)
            | (0x08 << _REFO1CON_ROSEL_POSITION)
            | _REFO1CON_OE_MASK
            ;
    
    REFO1CONbits.ON = 1;
}





