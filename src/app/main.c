/* 
 * File:   main.c
 * Author: Dortonyan (Aliaksei Fisko)
 *
 */

#include "system.h"



/*
 * 
 */
void main (void)
{    
    sysFreqHz = sysclk_value_get(PRIMARY_CRYSTAL_FREQUENCY_Hz, SECONDARY_CRYSTAL_FREQUENCY_Hz);
    sys_init(sysFreqHz);
    port_init();
    i2s_init();
    dma_init();
    dsp_init();
    uart_init(8200);
    usb_PL_init();
    
    /*
        When enabling the USB PLL, add a three second (For MI32MZxxxEC only!)
        delay before turning on the USB module  */
    //tmr_Task_Delayed_mS_set(SYS_TASK_USB_CONNECT, 3000);
    _System_Task_Set( SYS_TASK_USB_CONNECT );
    
    // Enable Global Interrupts
    __builtin_enable_interrupts();
    
    // Main Loop
    while (true)
    {
        if (_System_Num_Check() <= 0 && _System_Events_Check() == 0)   // If no more system tasks
        {
            GO_TO_IDLE();              // go to idle mode with clocks enabled
        }
        else
        {
            if (_System_Task_Check( SYS_TASK_USB_CONNECT )) {
                _USB_SOFT_CONNECT();        // The USB D+/D- lines are enabled and active
                _System_Task_Clr( SYS_TASK_USB_CONNECT );
            }

            if (_System_Task_Check( SYS_TASK_USB_EP0_ISR )) {
                usb_PL_ReqProcess(); // Process request
                _System_Task_Clr( SYS_TASK_USB_EP0_ISR );
            }

            if (_System_Num_Check() > 0) {
                LATESET = _BIT(4); // debug output SET
                dsp_proc();
                LATECLR = _BIT(4); // debug output CLEARE
            }
        }
    }
}

