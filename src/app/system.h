
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
#include "../app/config.h"
    
    
    
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


#define GO_TO_IDLE()                    asm volatile ( "wait" )


    
    
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
