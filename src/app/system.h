
#ifndef _SYSTEM_H_    /* Guard against multiple inclusion */
#define _SYSTEM_H_


/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif
    
/*******************************************
 * System libriares
 *******************************************/
#include <stdbool.h>
#include <string.h>
#include <sys/attribs.h>
#include <sys/kmem.h>
#include <xc.h>

/*******************************************
 * Project libriares
 *******************************************/
#include "../drivers/port/port.h"
#include "../drivers/clk/clk.h"
#include "../drivers/tmr/tmr.h"
#include "../drivers/dma/dma.h"
#include "../drivers/i2s/i2s.h"
#include "../drivers/usb/usb_LL.h"
#include "../drivers/usb/usb_PL.h"
#include "../drivers/uart/uart.h"
#include "../app/dsp.h"

    
typedef enum {
    eSYSCLK_SPEED_LOW,
    eSYSCLK_SPEED_MID,
    eSYSCLK_SPEED_HIGH
}eSYSCLK_SPEED;
    
typedef union {
    uint32_t dw;
    struct {
        uint16_t w0;
        uint16_t w1;
    }word;
    struct {
        uint8_t b0;
        uint8_t b1;
        uint8_t b2;
        uint8_t b3;
    }byte;
}tDWORD;


typedef struct {
    uint16_t tasks;
    int16_t snum;
} tSYS_EVENTS;



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

#define GO_TO_IDLE()                    asm volatile ( "wait" )

// Define primary clock frequency
#define PRIMARY_CRYSTAL_FREQUENCY_Hz    12000000u
// Define secondary clock frequency
#define SECONDARY_CRYSTAL_FREQUENCY_Hz  0u
    
    
// System task bits list
#define SYS_TASK_USB_CONNECT            (0x01 << 0)
#define SYS_TASK_USB_EP0_ISR            (0x01 << 1)
#define SYS_TASK_USB_STREAM_OUT_INIT    (0x01 << 2)



// System tasks control macroses
#define _System_Task_Set(bit)           systemTasks.tasks |= (uint16_t)(bit)
#define _System_Task_Clr(bit)           systemTasks.tasks &= ~(uint16_t)(bit)
#define _System_Task_Check(bit)         (systemTasks.tasks & (uint16_t)(bit))
#define _System_TaskAll_Check()         systemTasks.tasks

#define _System_Num_Set(num)            systemTasks.snum = (num)
#define _System_Num_Inc(num)            systemTasks.snum += (num)
#define _System_Num_Dec(num)            systemTasks.snum -= (num)
#define _System_Num_Check()             systemTasks.snum





extern volatile tSYS_EVENTS systemTasks;
extern volatile int sysFreqHz;

    
/* System Func */
void sys_init (int sysfreq);



    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _SYSTEM_H_ */

/* *****************************************************************************
 End of File
 */
