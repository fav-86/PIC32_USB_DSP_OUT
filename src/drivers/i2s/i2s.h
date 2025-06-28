#ifndef _I2S_H_    /* Guard against multiple inclusion */
#define _I2S_H_


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


#define     _I2S_Input_Transfer_Start()             SPI2CONSET = _SPI2CON_ON_MASK
#define     _I2S_Input_Transfer_Stop()              SPI2CONCLR = _SPI2CON_ON_MASK


void i2s_init (void);
void i2s_div_set (const uint8_t ovsmax, const uint8_t fmode);




    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _I2S_H_ */


