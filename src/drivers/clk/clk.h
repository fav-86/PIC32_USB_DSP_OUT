
#ifndef _CLK_H_    /* Guard against multiple inclusion */
#define _CLK_H_


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
    



int sysclk_value_get (int pfreq, int sfreq);

    /* Provide C++ Compatibility */
#ifdef __cplusplus
}
#endif

#endif /* _CLK_H_ */

