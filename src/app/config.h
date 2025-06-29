#ifndef _CONFIG_H    /* Guard against multiple inclusion */
#define _CONFIG_H

#include "../app/system.h"



#define OUT_FRM_PCM16   0
#define OUT_FRM_PCM32   1
#define OUT_FRM_DSD64   2 // works with x16 or x32 oversampling only!
#define OUT_FRM_DSD128  3 // works with x16 or x32 oversampling only!
#define OUT_FRM_DSD256  4 // for DoP output only!

#define FIR_OVS_x1      0
#define FIR_OVS_x2      1
#define FIR_OVS_x4      2
#define FIR_OVS_x8      3
#define FIR_OVS_x16     4
#define FIR_OVS_x32     5

#define PCM_NSHAPE_DISABLE      0
#define PCM_NSHAPE_ENABLE       1

#define DITHERING_DISABLE       0
#define DITHERING_ENABLE        1



// *****************************************************************************
// ************* User defines **************************************************
// *****************************************************************************
/* Define I2S masterclock */
// #define I2S_MCLK_512Fs
#define I2S_MCLK_1024Fs
/* Define output frame mode */
#define OUT_FRM_MODE                    OUT_FRM_PCM16
/* Define default max FIR oversampling ratio */
#define FIR_OVS_MAX                     FIR_OVS_x32
// define hysteresis to switch between PCM & DoP input modes
#define DoP_PCM_SWITCH_HYS              10

// ------- PCM frame type config -----------------------------------------------
// Set offset binary data format: 1 - enable, 0 - disable
#define OFFSET_BINARY                   0
// Set round data resolution
#define ROUND_DATA_WIDTH_bits           12
// Set output data lenght
#define OUTPUT_DATA_WIDTH_bits          16
// Set LFSR dither noise seed (zero value turn dithering off)
#define DITHERING_SET                   DITHERING_ENABLE
// Enable noise shaping
#define NOISE_SHAPING_SET               PCM_NSHAPE_ENABLE
// Set output DC offset in 24bit LSB-s
#define DC_OFFSET_LSB                   0
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
extern "C" {
#endif



    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _CONFIG_H */

/* *****************************************************************************
 End of File
 */
