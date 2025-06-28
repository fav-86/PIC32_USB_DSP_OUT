#ifndef _DSP_H_    /* Guard against multiple inclusion */
#define _DSP_H_


/* ************************************************************************** */
/* ************************************************************************** */
/* Section: Included Files                                                    */
/* ************************************************************************** */
/* ************************************************************************** */

/* This section lists the other files that are included in this file.
 */

/* TODO:  Include other files here if needed. */


/* Provide C++ Compatibility */
#ifdef __cplusplus
extern "C" {
#endif

#define DSP_FIR1_FIFO_SIZE          512
#define DSP_FIR1_FIFO_bSIZE         (DSP_FIR1_FIFO_SIZE*8)
#define DSP_FIR1_CELL_SIZE          14
#define DSP_FIR1_CELL_bSIZE         (DSP_FIR1_CELL_SIZE*8)

#define DSP_FIR2_FIFO_SIZE          128
#define DSP_FIR2_FIFO_bSIZE         (DSP_FIR2_FIFO_SIZE*8)
#define DSP_FIR2_CELL_SIZE          10
#define DSP_FIR2_CELL_bSIZE         (DSP_FIR2_CELL_SIZE*8)

#define DSP_FIR3_FIFO_SIZE          128
#define DSP_FIR3_FIFO_bSIZE         (DSP_FIR3_FIFO_SIZE*8)
#define DSP_FIR3_CELL_SIZE          7
#define DSP_FIR3_CELL_bSIZE         (DSP_FIR3_CELL_SIZE*8)

#define DSP_FIR4_FIFO_SIZE          128
#define DSP_FIR4_FIFO_bSIZE         (DSP_FIR4_FIFO_SIZE*8)
#define DSP_FIR4_CELL_SIZE          5
#define DSP_FIR4_CELL_bSIZE         (DSP_FIR4_CELL_SIZE*8)
    
#define DSP_FIR5_FIFO_SIZE          256
#define DSP_FIR5_FIFO_bSIZE         (DSP_FIR5_FIFO_SIZE*8)
#define DSP_FIR5_CELL_SIZE          3
#define DSP_FIR5_CELL_bSIZE         (DSP_FIR5_CELL_SIZE*8)

#define DSP_OUTPUT_TRANSFET_PTR     (dspOutPtr << 3)




uint32_t dsp_AttAdr_get(void);
void dsp_usb_data_load (volatile void *pFifo, uint16_t rxcnt);
void dsp_init (void);
void dsp_volume_set (uint8_t volume);
void dsp_stop (void);
void dsp_restart (uint8_t sfreq, uint8_t wlen);
void dsp_proc (void);

extern volatile int dspOutPtr;



    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _DSP_H_ */