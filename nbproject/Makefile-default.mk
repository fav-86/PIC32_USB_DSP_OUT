#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=src/app/asm/att.S src/app/asm/dsd.S src/app/asm/fir_1.S src/app/asm/fir_2345.S src/app/asm/fir_5842.S src/app/asm/ornd.S src/app/asm/scpy.S src/app/main.c src/app/system.c src/app/dsp.c src/drivers/usb/usb_LL.c src/drivers/usb/usb_PL.c src/drivers/i2s/i2s.c src/drivers/port/port.c src/drivers/tmr/tmr.c src/drivers/dma/dma.c src/drivers/clk/clk.c src/drivers/uart/uart.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/app/asm/att.o ${OBJECTDIR}/src/app/asm/dsd.o ${OBJECTDIR}/src/app/asm/fir_1.o ${OBJECTDIR}/src/app/asm/fir_2345.o ${OBJECTDIR}/src/app/asm/fir_5842.o ${OBJECTDIR}/src/app/asm/ornd.o ${OBJECTDIR}/src/app/asm/scpy.o ${OBJECTDIR}/src/app/main.o ${OBJECTDIR}/src/app/system.o ${OBJECTDIR}/src/app/dsp.o ${OBJECTDIR}/src/drivers/usb/usb_LL.o ${OBJECTDIR}/src/drivers/usb/usb_PL.o ${OBJECTDIR}/src/drivers/i2s/i2s.o ${OBJECTDIR}/src/drivers/port/port.o ${OBJECTDIR}/src/drivers/tmr/tmr.o ${OBJECTDIR}/src/drivers/dma/dma.o ${OBJECTDIR}/src/drivers/clk/clk.o ${OBJECTDIR}/src/drivers/uart/uart.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/app/asm/att.o.d ${OBJECTDIR}/src/app/asm/dsd.o.d ${OBJECTDIR}/src/app/asm/fir_1.o.d ${OBJECTDIR}/src/app/asm/fir_2345.o.d ${OBJECTDIR}/src/app/asm/fir_5842.o.d ${OBJECTDIR}/src/app/asm/ornd.o.d ${OBJECTDIR}/src/app/asm/scpy.o.d ${OBJECTDIR}/src/app/main.o.d ${OBJECTDIR}/src/app/system.o.d ${OBJECTDIR}/src/app/dsp.o.d ${OBJECTDIR}/src/drivers/usb/usb_LL.o.d ${OBJECTDIR}/src/drivers/usb/usb_PL.o.d ${OBJECTDIR}/src/drivers/i2s/i2s.o.d ${OBJECTDIR}/src/drivers/port/port.o.d ${OBJECTDIR}/src/drivers/tmr/tmr.o.d ${OBJECTDIR}/src/drivers/dma/dma.o.d ${OBJECTDIR}/src/drivers/clk/clk.o.d ${OBJECTDIR}/src/drivers/uart/uart.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/app/asm/att.o ${OBJECTDIR}/src/app/asm/dsd.o ${OBJECTDIR}/src/app/asm/fir_1.o ${OBJECTDIR}/src/app/asm/fir_2345.o ${OBJECTDIR}/src/app/asm/fir_5842.o ${OBJECTDIR}/src/app/asm/ornd.o ${OBJECTDIR}/src/app/asm/scpy.o ${OBJECTDIR}/src/app/main.o ${OBJECTDIR}/src/app/system.o ${OBJECTDIR}/src/app/dsp.o ${OBJECTDIR}/src/drivers/usb/usb_LL.o ${OBJECTDIR}/src/drivers/usb/usb_PL.o ${OBJECTDIR}/src/drivers/i2s/i2s.o ${OBJECTDIR}/src/drivers/port/port.o ${OBJECTDIR}/src/drivers/tmr/tmr.o ${OBJECTDIR}/src/drivers/dma/dma.o ${OBJECTDIR}/src/drivers/clk/clk.o ${OBJECTDIR}/src/drivers/uart/uart.o

# Source Files
SOURCEFILES=src/app/asm/att.S src/app/asm/dsd.S src/app/asm/fir_1.S src/app/asm/fir_2345.S src/app/asm/fir_5842.S src/app/asm/ornd.S src/app/asm/scpy.S src/app/main.c src/app/system.c src/app/dsp.c src/drivers/usb/usb_LL.c src/drivers/usb/usb_PL.c src/drivers/i2s/i2s.c src/drivers/port/port.c src/drivers/tmr/tmr.c src/drivers/dma/dma.c src/drivers/clk/clk.c src/drivers/uart/uart.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MZ1024EFG064
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/app/asm/att.o: src/app/asm/att.S  .generated_files/flags/default/4749afb869ebaa01884a8604411f61f99ac4c42 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.ok ${OBJECTDIR}/src/app/asm/att.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/att.o.d"  -o ${OBJECTDIR}/src/app/asm/att.o src/app/asm/att.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/att.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/att.o.d" "${OBJECTDIR}/src/app/asm/att.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/dsd.o: src/app/asm/dsd.S  .generated_files/flags/default/e65f4948e08e68fbeab485d1c79d497a72b7b09f .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.ok ${OBJECTDIR}/src/app/asm/dsd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/dsd.o.d"  -o ${OBJECTDIR}/src/app/asm/dsd.o src/app/asm/dsd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/dsd.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/dsd.o.d" "${OBJECTDIR}/src/app/asm/dsd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_1.o: src/app/asm/fir_1.S  .generated_files/flags/default/3cc54bed2ebed9dce55b8bed54859d626e46672c .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.ok ${OBJECTDIR}/src/app/asm/fir_1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_1.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_1.o src/app/asm/fir_1.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_1.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_1.o.d" "${OBJECTDIR}/src/app/asm/fir_1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_2345.o: src/app/asm/fir_2345.S  .generated_files/flags/default/3cabd0e01adc56de4714733090bc1352aba7ebdd .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.ok ${OBJECTDIR}/src/app/asm/fir_2345.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_2345.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_2345.o src/app/asm/fir_2345.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_2345.o.d" "${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_5842.o: src/app/asm/fir_5842.S  .generated_files/flags/default/b57d9728e6dfdc94b31e1078eb6c9718b2c52fc5 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.ok ${OBJECTDIR}/src/app/asm/fir_5842.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_5842.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_5842.o src/app/asm/fir_5842.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_5842.o.d" "${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/ornd.o: src/app/asm/ornd.S  .generated_files/flags/default/bb55faf221b64427c658d2065e91641b1a11935c .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.ok ${OBJECTDIR}/src/app/asm/ornd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/ornd.o.d"  -o ${OBJECTDIR}/src/app/asm/ornd.o src/app/asm/ornd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/ornd.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/ornd.o.d" "${OBJECTDIR}/src/app/asm/ornd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/scpy.o: src/app/asm/scpy.S  .generated_files/flags/default/7bfb63388524332df9b11e1a0a8c45b74ad4711b .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o.ok ${OBJECTDIR}/src/app/asm/scpy.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/scpy.o.d"  -o ${OBJECTDIR}/src/app/asm/scpy.o src/app/asm/scpy.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/scpy.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/scpy.o.d" "${OBJECTDIR}/src/app/asm/scpy.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/src/app/asm/att.o: src/app/asm/att.S  .generated_files/flags/default/7d516f3a7c371cfd2b7f57ad361b5745593b3ee1 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.ok ${OBJECTDIR}/src/app/asm/att.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/att.o.d"  -o ${OBJECTDIR}/src/app/asm/att.o src/app/asm/att.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/att.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/att.o.d" "${OBJECTDIR}/src/app/asm/att.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/dsd.o: src/app/asm/dsd.S  .generated_files/flags/default/618b91562062e281c949a6f7498222de38d3ff32 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.ok ${OBJECTDIR}/src/app/asm/dsd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/dsd.o.d"  -o ${OBJECTDIR}/src/app/asm/dsd.o src/app/asm/dsd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/dsd.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/dsd.o.d" "${OBJECTDIR}/src/app/asm/dsd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_1.o: src/app/asm/fir_1.S  .generated_files/flags/default/384fa169c13ae2f8dfb42a3e1181d81fcd867f6f .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.ok ${OBJECTDIR}/src/app/asm/fir_1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_1.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_1.o src/app/asm/fir_1.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_1.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_1.o.d" "${OBJECTDIR}/src/app/asm/fir_1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_2345.o: src/app/asm/fir_2345.S  .generated_files/flags/default/397da84092282751e718dffeaf62c7c3c16de94d .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.ok ${OBJECTDIR}/src/app/asm/fir_2345.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_2345.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_2345.o src/app/asm/fir_2345.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_2345.o.d" "${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_5842.o: src/app/asm/fir_5842.S  .generated_files/flags/default/a857fc7a83dea9bd170a5e4cacada4d1aa9385f3 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.ok ${OBJECTDIR}/src/app/asm/fir_5842.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_5842.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_5842.o src/app/asm/fir_5842.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_5842.o.d" "${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/ornd.o: src/app/asm/ornd.S  .generated_files/flags/default/a76b726160d0c4a355bda36e8481d56f9848d868 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.ok ${OBJECTDIR}/src/app/asm/ornd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/ornd.o.d"  -o ${OBJECTDIR}/src/app/asm/ornd.o src/app/asm/ornd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/ornd.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/ornd.o.d" "${OBJECTDIR}/src/app/asm/ornd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/scpy.o: src/app/asm/scpy.S  .generated_files/flags/default/f6ec51796a61daa7420c79e220eb7f4f18f54bcc .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o.ok ${OBJECTDIR}/src/app/asm/scpy.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/scpy.o.d"  -o ${OBJECTDIR}/src/app/asm/scpy.o src/app/asm/scpy.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/scpy.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/scpy.o.d" "${OBJECTDIR}/src/app/asm/scpy.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/app/main.o: src/app/main.c  .generated_files/flags/default/abaade1d645ee112c3ce76f115fce64c3629c3fe .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/main.o.d 
	@${RM} ${OBJECTDIR}/src/app/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/main.o.d" -o ${OBJECTDIR}/src/app/main.o src/app/main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/system.o: src/app/system.c  .generated_files/flags/default/5cd80a43bef647fdd2e19e1ee65e299df873bf .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/system.o.d 
	@${RM} ${OBJECTDIR}/src/app/system.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/system.o.d" -o ${OBJECTDIR}/src/app/system.o src/app/system.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/dsp.o: src/app/dsp.c  .generated_files/flags/default/bb930a3574ece406addc2267438d66903e2d8290 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/dsp.o.d 
	@${RM} ${OBJECTDIR}/src/app/dsp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/dsp.o.d" -o ${OBJECTDIR}/src/app/dsp.o src/app/dsp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_LL.o: src/drivers/usb/usb_LL.c  .generated_files/flags/default/3497727cf0d35d739042a407a210f79621eadeda .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_LL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_LL.o src/drivers/usb/usb_LL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_PL.o: src/drivers/usb/usb_PL.c  .generated_files/flags/default/cc7d5129cdd8457e5a41df7a2cc7f9de9316730c .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_PL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_PL.o src/drivers/usb/usb_PL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/i2s/i2s.o: src/drivers/i2s/i2s.c  .generated_files/flags/default/12969566bcd4f7edf8628b6e2b0977b42c15bab2 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/i2s" 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/i2s/i2s.o.d" -o ${OBJECTDIR}/src/drivers/i2s/i2s.o src/drivers/i2s/i2s.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/port/port.o: src/drivers/port/port.c  .generated_files/flags/default/6c93ceeaecf3f3829910823938f842b2a1332e55 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/port" 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/port/port.o.d" -o ${OBJECTDIR}/src/drivers/port/port.o src/drivers/port/port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/tmr/tmr.o: src/drivers/tmr/tmr.c  .generated_files/flags/default/dc406f1179d864e2c3ef39ba40b3c42a70783da7 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/tmr" 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/tmr/tmr.o.d" -o ${OBJECTDIR}/src/drivers/tmr/tmr.o src/drivers/tmr/tmr.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/dma/dma.o: src/drivers/dma/dma.c  .generated_files/flags/default/98fc1cd3f307e50d7ed4397261733440502a34a2 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/dma" 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/dma/dma.o.d" -o ${OBJECTDIR}/src/drivers/dma/dma.o src/drivers/dma/dma.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/clk/clk.o: src/drivers/clk/clk.c  .generated_files/flags/default/40698c323472d968ebccf233984b3abad1400047 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/clk" 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/clk/clk.o.d" -o ${OBJECTDIR}/src/drivers/clk/clk.o src/drivers/clk/clk.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/uart/uart.o: src/drivers/uart/uart.c  .generated_files/flags/default/c16fd581bd87aa7c052cd6989e61826aafc8c666 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/uart" 
	@${RM} ${OBJECTDIR}/src/drivers/uart/uart.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/uart/uart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/uart/uart.o.d" -o ${OBJECTDIR}/src/drivers/uart/uart.o src/drivers/uart/uart.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/src/app/main.o: src/app/main.c  .generated_files/flags/default/797f7ee05a1fac8920434f537b0c5a2ebbf41f00 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/main.o.d 
	@${RM} ${OBJECTDIR}/src/app/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/main.o.d" -o ${OBJECTDIR}/src/app/main.o src/app/main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/system.o: src/app/system.c  .generated_files/flags/default/d6c4b9759eeb800056604b0684c0baee7e93cd46 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/system.o.d 
	@${RM} ${OBJECTDIR}/src/app/system.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/system.o.d" -o ${OBJECTDIR}/src/app/system.o src/app/system.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/dsp.o: src/app/dsp.c  .generated_files/flags/default/a1b8b38e92c02fbce6a78bc071774a4ef7f51e31 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/dsp.o.d 
	@${RM} ${OBJECTDIR}/src/app/dsp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/dsp.o.d" -o ${OBJECTDIR}/src/app/dsp.o src/app/dsp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_LL.o: src/drivers/usb/usb_LL.c  .generated_files/flags/default/97f877c509ec68b1d4d1fee9b8751bc5868e27a1 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_LL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_LL.o src/drivers/usb/usb_LL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_PL.o: src/drivers/usb/usb_PL.c  .generated_files/flags/default/ec1f9d22344e92e34e4e358fe908f17709ba42fc .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_PL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_PL.o src/drivers/usb/usb_PL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/i2s/i2s.o: src/drivers/i2s/i2s.c  .generated_files/flags/default/98da7e15d8464ed2fad7b957e53c4db152b69884 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/i2s" 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/i2s/i2s.o.d" -o ${OBJECTDIR}/src/drivers/i2s/i2s.o src/drivers/i2s/i2s.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/port/port.o: src/drivers/port/port.c  .generated_files/flags/default/c373061b2c2f6a3b7b62168f982cf9af8d27a1fe .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/port" 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/port/port.o.d" -o ${OBJECTDIR}/src/drivers/port/port.o src/drivers/port/port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/tmr/tmr.o: src/drivers/tmr/tmr.c  .generated_files/flags/default/b6e7155b8b5b7a5b40faace69655ad6b939ab498 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/tmr" 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/tmr/tmr.o.d" -o ${OBJECTDIR}/src/drivers/tmr/tmr.o src/drivers/tmr/tmr.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/dma/dma.o: src/drivers/dma/dma.c  .generated_files/flags/default/dfb4622b19ed0ee23aecdc3a51aaf034f75a6d1b .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/dma" 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/dma/dma.o.d" -o ${OBJECTDIR}/src/drivers/dma/dma.o src/drivers/dma/dma.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/clk/clk.o: src/drivers/clk/clk.c  .generated_files/flags/default/9325499a832bb3e968c7f57e24536cd2562ad2ed .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/clk" 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/clk/clk.o.d" -o ${OBJECTDIR}/src/drivers/clk/clk.o src/drivers/clk/clk.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/uart/uart.o: src/drivers/uart/uart.c  .generated_files/flags/default/6636fd18345720b6e97559bbc180ab13df00d697 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/uart" 
	@${RM} ${OBJECTDIR}/src/drivers/uart/uart.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/uart/uart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/uart/uart.o.d" -o ${OBJECTDIR}/src/drivers/uart/uart.o src/drivers/uart/uart.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)      -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=4096,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=4096,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/PIC32_USB_DSP_OUT.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
