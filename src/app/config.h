#ifndef _CONFIG_H    /* Guard against multiple inclusion */
#define _CONFIG_H

/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif


#define OUT_FRM_PCM16       0
#define OUT_FRM_PCM32       1
#define OUT_FRM_DSD64       2 // works with x16 or x32 oversampling only!
#define OUT_FRM_DSD128      3 // works with x16 or x32 oversampling only!
#define OUT_FRM_DSD256      4 // for DoP output only!

#define FIR_OVS_x1          0
#define FIR_OVS_x2          1
#define FIR_OVS_x4          2
#define FIR_OVS_x8          3
#define FIR_OVS_x16         4
#define FIR_OVS_x32         5

#define PCM_NSHAPE_DISABLE  0
#define PCM_NSHAPE_ENABLE   1

#define DITHERING_DISABLE   0
#define DITHERING_ENABLE    1

#define DG_OUT_DISABLE      0
#define DG_OUT_ENABLE       1

// *****************************************************************************
// ************* User defines **************************************************
// *****************************************************************************
// Define MCU series
//#define PIC32MZxxxxEC
#define PIC32MZxxxxEF

// Define primary clock frequency
#define PRIMARY_CRYSTAL_FREQUENCY_Hz    12000000u
// Define secondary clock frequency
#define SECONDARY_CRYSTAL_FREQUENCY_Hz  0u

/* Define I2S masterclock */
// #define I2S_MCLK_512Fs
#define I2S_MCLK_1024Fs

/* Define output frame mode */
#define OUT_FRM_MODE                    OUT_FRM_PCM16
/* Define default max FIR oversampling ratio */
#define FIR_OVS_MAX                     FIR_OVS_x32
// define hysteresis to switch between PCM & DoP input modes
#define DoP_PCM_SWITCH_HYS              10

/* Set SPI modules to output */
#define SPI_BUF_DL      SPI1BUF     // SPI_SDO to data Left
#define SPI_BUF_DR      SPI3BUF     // SPI_SDO to data Right
#define SPI_BUF_WC      SPI4BUF     // SPI_SDO to data Word Clock
#define SPI_BUF_DG      SPI2BUF     // SPI_SDO to data Deglitcher Clock

// ------- PCM frame type config -----------------------------------------------
// Set offset binary data format: 1 - enable, 0 - disable
#define OFFSET_BINARY                   0
// Set round data resolution in bits
#define ROUND_DATA_WIDTH_bits           12
// Set output data width in bits
#define OUTPUT_DATA_WIDTH_bits          16
// Set LFSR dither noise seed (zero value turn dithering off)
#define DITHERING_SET                   DITHERING_ENABLE
// Enable noise shaping
#define NOISE_SHAPING_SET               PCM_NSHAPE_ENABLE
// Set output DC offset in output width LSB-s
#define DC_OFFSET_LSB                   0
// Enable deglitcher output
#define DGO_ENA                         DG_OUT_DISABLE
// Set 16bit frame word-clock & deglitcher waves values
#define WCK16_VAL                       0x0001u
#define DG16_VAL                        0xFF81u
// Set 32bit frame word-clock & deglitcher waves values
#define WCK32_VAL                       0x00000001u
#define DG32_VAL                        0xFFFFE001u
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************


#if OUT_FRM_MODE == OUT_FRM_PCM16
    #define OUTPUT_BUFFER_bSIZE         (1024u << FIR_OVS_MAX)
#elif OUT_FRM_MODE == OUT_FRM_PCM32
    #define OUTPUT_BUFFER_bSIZE         (2048u << FIR_OVS_MAX)
#elif OUT_FRM_MODE == OUT_FRM_DSD64
    #define OUTPUT_BUFFER_bSIZE         4096u
#elif OUT_FRM_MODE == OUT_FRM_DSD128
    #define OUTPUT_BUFFER_bSIZE         8192u
#endif



/* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _CONFIG_H */

/* *****************************************************************************
 End of File
 */
