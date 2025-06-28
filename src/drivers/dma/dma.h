#ifndef _DMA_H_    /* Guard against multiple inclusion */
#define _DMA_H_


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

#define _DMA_SUSPEND_ALL()                          {   DMACONbits.SUSPEND = 1;\
                                                        while (DMACONbits.DMABUSY); }
#define _DMA_RESUME_ALL()                               DMACONbits.SUSPEND = 0

/******************* Output transfer defines *******************************/
#define _DMA_OutputSourceAddress_Set(adr)           {   DCH4SSA = adr; DCH5DSA = adr; }
#define DMA_OUTPUT_TRANSFET_PTR                         DCH4SPTR





// DMA initialization
void dma_init (void);

// DMA control
void dma_parallel_output_start (const uint16_t size);
void dma_output_stop (const uint16_t size);



    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _DMA_H_ */


