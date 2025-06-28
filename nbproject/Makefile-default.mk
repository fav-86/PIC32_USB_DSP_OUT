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
FINAL_IMAGE=${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=src/app/main.c src/app/system.c src/app/dsp.c src/drivers/usb/usb_LL.c src/drivers/usb/usb_PL.c src/drivers/i2s/i2s.c src/drivers/port/port.c src/drivers/tmr/tmr.c src/drivers/dma/dma.c src/drivers/clk/clk.c src/app/asm/att.S src/app/asm/dsd.S src/app/asm/fir_1.S src/app/asm/fir_2345.S src/app/asm/fir_5842.S src/app/asm/ornd.S src/app/asm/scpy.S src/drivers/uart/uart.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/app/main.o ${OBJECTDIR}/src/app/system.o ${OBJECTDIR}/src/app/dsp.o ${OBJECTDIR}/src/drivers/usb/usb_LL.o ${OBJECTDIR}/src/drivers/usb/usb_PL.o ${OBJECTDIR}/src/drivers/i2s/i2s.o ${OBJECTDIR}/src/drivers/port/port.o ${OBJECTDIR}/src/drivers/tmr/tmr.o ${OBJECTDIR}/src/drivers/dma/dma.o ${OBJECTDIR}/src/drivers/clk/clk.o ${OBJECTDIR}/src/app/asm/att.o ${OBJECTDIR}/src/app/asm/dsd.o ${OBJECTDIR}/src/app/asm/fir_1.o ${OBJECTDIR}/src/app/asm/fir_2345.o ${OBJECTDIR}/src/app/asm/fir_5842.o ${OBJECTDIR}/src/app/asm/ornd.o ${OBJECTDIR}/src/app/asm/scpy.o ${OBJECTDIR}/src/drivers/uart/uart.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/app/main.o.d ${OBJECTDIR}/src/app/system.o.d ${OBJECTDIR}/src/app/dsp.o.d ${OBJECTDIR}/src/drivers/usb/usb_LL.o.d ${OBJECTDIR}/src/drivers/usb/usb_PL.o.d ${OBJECTDIR}/src/drivers/i2s/i2s.o.d ${OBJECTDIR}/src/drivers/port/port.o.d ${OBJECTDIR}/src/drivers/tmr/tmr.o.d ${OBJECTDIR}/src/drivers/dma/dma.o.d ${OBJECTDIR}/src/drivers/clk/clk.o.d ${OBJECTDIR}/src/app/asm/att.o.d ${OBJECTDIR}/src/app/asm/dsd.o.d ${OBJECTDIR}/src/app/asm/fir_1.o.d ${OBJECTDIR}/src/app/asm/fir_2345.o.d ${OBJECTDIR}/src/app/asm/fir_5842.o.d ${OBJECTDIR}/src/app/asm/ornd.o.d ${OBJECTDIR}/src/app/asm/scpy.o.d ${OBJECTDIR}/src/drivers/uart/uart.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/app/main.o ${OBJECTDIR}/src/app/system.o ${OBJECTDIR}/src/app/dsp.o ${OBJECTDIR}/src/drivers/usb/usb_LL.o ${OBJECTDIR}/src/drivers/usb/usb_PL.o ${OBJECTDIR}/src/drivers/i2s/i2s.o ${OBJECTDIR}/src/drivers/port/port.o ${OBJECTDIR}/src/drivers/tmr/tmr.o ${OBJECTDIR}/src/drivers/dma/dma.o ${OBJECTDIR}/src/drivers/clk/clk.o ${OBJECTDIR}/src/app/asm/att.o ${OBJECTDIR}/src/app/asm/dsd.o ${OBJECTDIR}/src/app/asm/fir_1.o ${OBJECTDIR}/src/app/asm/fir_2345.o ${OBJECTDIR}/src/app/asm/fir_5842.o ${OBJECTDIR}/src/app/asm/ornd.o ${OBJECTDIR}/src/app/asm/scpy.o ${OBJECTDIR}/src/drivers/uart/uart.o

# Source Files
SOURCEFILES=src/app/main.c src/app/system.c src/app/dsp.c src/drivers/usb/usb_LL.c src/drivers/usb/usb_PL.c src/drivers/i2s/i2s.c src/drivers/port/port.c src/drivers/tmr/tmr.c src/drivers/dma/dma.c src/drivers/clk/clk.c src/app/asm/att.S src/app/asm/dsd.S src/app/asm/fir_1.S src/app/asm/fir_2345.S src/app/asm/fir_5842.S src/app/asm/ornd.S src/app/asm/scpy.S src/drivers/uart/uart.c



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
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

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
${OBJECTDIR}/src/app/asm/att.o: src/app/asm/att.S  .generated_files/flags/default/b98e986f63cf7f815f0db580a8d9894ef0636c57 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.ok ${OBJECTDIR}/src/app/asm/att.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/att.o.d"  -o ${OBJECTDIR}/src/app/asm/att.o src/app/asm/att.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/att.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/att.o.d" "${OBJECTDIR}/src/app/asm/att.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/dsd.o: src/app/asm/dsd.S  .generated_files/flags/default/ca32b45d37029585e455751c46b40f6458df64f4 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.ok ${OBJECTDIR}/src/app/asm/dsd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/dsd.o.d"  -o ${OBJECTDIR}/src/app/asm/dsd.o src/app/asm/dsd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/dsd.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/dsd.o.d" "${OBJECTDIR}/src/app/asm/dsd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_1.o: src/app/asm/fir_1.S  .generated_files/flags/default/57e43499524bd402b7ef218f3ef71d35cff3d12b .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.ok ${OBJECTDIR}/src/app/asm/fir_1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_1.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_1.o src/app/asm/fir_1.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_1.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_1.o.d" "${OBJECTDIR}/src/app/asm/fir_1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_2345.o: src/app/asm/fir_2345.S  .generated_files/flags/default/6241a1aa3cd9c54a8fd1a90d1d01f8851e3b5481 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.ok ${OBJECTDIR}/src/app/asm/fir_2345.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_2345.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_2345.o src/app/asm/fir_2345.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_2345.o.d" "${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_5842.o: src/app/asm/fir_5842.S  .generated_files/flags/default/f342f5b9a4a87f46e5ba3ba1d1a00a6bd912de43 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.ok ${OBJECTDIR}/src/app/asm/fir_5842.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_5842.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_5842.o src/app/asm/fir_5842.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_5842.o.d" "${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/ornd.o: src/app/asm/ornd.S  .generated_files/flags/default/71364ba39055754dd4216747a4cca1d792057869 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.ok ${OBJECTDIR}/src/app/asm/ornd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/ornd.o.d"  -o ${OBJECTDIR}/src/app/asm/ornd.o src/app/asm/ornd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/ornd.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/ornd.o.d" "${OBJECTDIR}/src/app/asm/ornd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/scpy.o: src/app/asm/scpy.S  .generated_files/flags/default/82d46d4240285231e07f9a7735f87c1b8855978b .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o 
	@${RM} ${OBJECTDIR}/src/app/asm/scpy.o.ok ${OBJECTDIR}/src/app/asm/scpy.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/scpy.o.d"  -o ${OBJECTDIR}/src/app/asm/scpy.o src/app/asm/scpy.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/scpy.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/scpy.o.d" "${OBJECTDIR}/src/app/asm/scpy.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/src/app/asm/att.o: src/app/asm/att.S  .generated_files/flags/default/45005c2bf191336fedbd6024e03e52419b28a964 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o 
	@${RM} ${OBJECTDIR}/src/app/asm/att.o.ok ${OBJECTDIR}/src/app/asm/att.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/att.o.d"  -o ${OBJECTDIR}/src/app/asm/att.o src/app/asm/att.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/att.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/att.o.d" "${OBJECTDIR}/src/app/asm/att.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/dsd.o: src/app/asm/dsd.S  .generated_files/flags/default/82052e24e89e0484bfe3531099dcf772247d7e56 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/dsd.o.ok ${OBJECTDIR}/src/app/asm/dsd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/dsd.o.d"  -o ${OBJECTDIR}/src/app/asm/dsd.o src/app/asm/dsd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/dsd.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/dsd.o.d" "${OBJECTDIR}/src/app/asm/dsd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_1.o: src/app/asm/fir_1.S  .generated_files/flags/default/30518beb557c158d175778b44e61103af33ef6dd .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_1.o.ok ${OBJECTDIR}/src/app/asm/fir_1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_1.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_1.o src/app/asm/fir_1.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_1.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_1.o.d" "${OBJECTDIR}/src/app/asm/fir_1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_2345.o: src/app/asm/fir_2345.S  .generated_files/flags/default/2f3b050c71feeed28a9052694e4658a8b9028683 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_2345.o.ok ${OBJECTDIR}/src/app/asm/fir_2345.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_2345.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_2345.o src/app/asm/fir_2345.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_2345.o.d" "${OBJECTDIR}/src/app/asm/fir_2345.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/fir_5842.o: src/app/asm/fir_5842.S  .generated_files/flags/default/21c40fe381b7430755b40a2ee4ca58088579697 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o 
	@${RM} ${OBJECTDIR}/src/app/asm/fir_5842.o.ok ${OBJECTDIR}/src/app/asm/fir_5842.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/fir_5842.o.d"  -o ${OBJECTDIR}/src/app/asm/fir_5842.o src/app/asm/fir_5842.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/fir_5842.o.d" "${OBJECTDIR}/src/app/asm/fir_5842.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/ornd.o: src/app/asm/ornd.S  .generated_files/flags/default/d82b875ad4a909cc95d67aefbdf387b8fcc16bc9 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app/asm" 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.d 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o 
	@${RM} ${OBJECTDIR}/src/app/asm/ornd.o.ok ${OBJECTDIR}/src/app/asm/ornd.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/src/app/asm/ornd.o.d"  -o ${OBJECTDIR}/src/app/asm/ornd.o src/app/asm/ornd.S  -DXPRJ_default=$(CND_CONF)    -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/src/app/asm/ornd.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/src/app/asm/ornd.o.d" "${OBJECTDIR}/src/app/asm/ornd.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/src/app/asm/scpy.o: src/app/asm/scpy.S  .generated_files/flags/default/a52dcdd9a1736fd230d5d0d1892c2909ece29c0f .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
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
${OBJECTDIR}/src/app/main.o: src/app/main.c  .generated_files/flags/default/1ef50a291ac246883cd9b9b568811564035f873a .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/main.o.d 
	@${RM} ${OBJECTDIR}/src/app/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/main.o.d" -o ${OBJECTDIR}/src/app/main.o src/app/main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/system.o: src/app/system.c  .generated_files/flags/default/dfd36f1820128a0d44f8b6bc5d0e468398afd9fb .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/system.o.d 
	@${RM} ${OBJECTDIR}/src/app/system.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/system.o.d" -o ${OBJECTDIR}/src/app/system.o src/app/system.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/dsp.o: src/app/dsp.c  .generated_files/flags/default/5a73dea55f5db79d2e76b589b5630cdcdb725b2f .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/dsp.o.d 
	@${RM} ${OBJECTDIR}/src/app/dsp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/dsp.o.d" -o ${OBJECTDIR}/src/app/dsp.o src/app/dsp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_LL.o: src/drivers/usb/usb_LL.c  .generated_files/flags/default/e6f1beb8b11039c7156a3d5c93bbcce26393f749 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_LL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_LL.o src/drivers/usb/usb_LL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_PL.o: src/drivers/usb/usb_PL.c  .generated_files/flags/default/1dae6929c41ca407fee79a04019f7777f1527c0a .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_PL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_PL.o src/drivers/usb/usb_PL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/i2s/i2s.o: src/drivers/i2s/i2s.c  .generated_files/flags/default/781748fdf54bf8166668c0f866a7bd390d4af613 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/i2s" 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/i2s/i2s.o.d" -o ${OBJECTDIR}/src/drivers/i2s/i2s.o src/drivers/i2s/i2s.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/port/port.o: src/drivers/port/port.c  .generated_files/flags/default/d0b72ad817c0169fa67473298b47aeebb4fa33d7 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/port" 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/port/port.o.d" -o ${OBJECTDIR}/src/drivers/port/port.o src/drivers/port/port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/tmr/tmr.o: src/drivers/tmr/tmr.c  .generated_files/flags/default/a5b91449787fd752e19d8da945f22066a879a1e3 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/tmr" 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/tmr/tmr.o.d" -o ${OBJECTDIR}/src/drivers/tmr/tmr.o src/drivers/tmr/tmr.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/dma/dma.o: src/drivers/dma/dma.c  .generated_files/flags/default/c8f0e3a7cef29dd83e4129ba40cb456ee57ddd88 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/dma" 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/dma/dma.o.d" -o ${OBJECTDIR}/src/drivers/dma/dma.o src/drivers/dma/dma.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/clk/clk.o: src/drivers/clk/clk.c  .generated_files/flags/default/8f55b97232fe64861e8e3260e723643a0995c153 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/clk" 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/clk/clk.o.d" -o ${OBJECTDIR}/src/drivers/clk/clk.o src/drivers/clk/clk.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/uart/uart.o: src/drivers/uart/uart.c  .generated_files/flags/default/933e8be5aa2bd691cf477c3e3157af9fb8784304 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/uart" 
	@${RM} ${OBJECTDIR}/src/drivers/uart/uart.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/uart/uart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/uart/uart.o.d" -o ${OBJECTDIR}/src/drivers/uart/uart.o src/drivers/uart/uart.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
else
${OBJECTDIR}/src/app/main.o: src/app/main.c  .generated_files/flags/default/2008345cd4bda70ea2c508389342cfc7b939a6 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/main.o.d 
	@${RM} ${OBJECTDIR}/src/app/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/main.o.d" -o ${OBJECTDIR}/src/app/main.o src/app/main.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/system.o: src/app/system.c  .generated_files/flags/default/77b96679b1cab66b912fa7d814592fb12a8f065a .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/system.o.d 
	@${RM} ${OBJECTDIR}/src/app/system.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/system.o.d" -o ${OBJECTDIR}/src/app/system.o src/app/system.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/app/dsp.o: src/app/dsp.c  .generated_files/flags/default/782a3bbd019d333d3d21536bc0634b4992cb35d9 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/app" 
	@${RM} ${OBJECTDIR}/src/app/dsp.o.d 
	@${RM} ${OBJECTDIR}/src/app/dsp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/app/dsp.o.d" -o ${OBJECTDIR}/src/app/dsp.o src/app/dsp.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_LL.o: src/drivers/usb/usb_LL.c  .generated_files/flags/default/5bdec9c8b3e1b07dc55a32f00bc76a33586243df .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_LL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_LL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_LL.o src/drivers/usb/usb_LL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/usb/usb_PL.o: src/drivers/usb/usb_PL.c  .generated_files/flags/default/37c19066d8ea54aaa229e285fe5d5d437f0c6c3a .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/usb" 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/usb/usb_PL.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/usb/usb_PL.o.d" -o ${OBJECTDIR}/src/drivers/usb/usb_PL.o src/drivers/usb/usb_PL.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/i2s/i2s.o: src/drivers/i2s/i2s.c  .generated_files/flags/default/8cee230155bce8ee915de6f89fa453623ce0ea0f .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/i2s" 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/i2s/i2s.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/i2s/i2s.o.d" -o ${OBJECTDIR}/src/drivers/i2s/i2s.o src/drivers/i2s/i2s.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/port/port.o: src/drivers/port/port.c  .generated_files/flags/default/61d29c89dafe7c36a566a2b042abd5e8eb6bcba3 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/port" 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/port/port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/port/port.o.d" -o ${OBJECTDIR}/src/drivers/port/port.o src/drivers/port/port.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/tmr/tmr.o: src/drivers/tmr/tmr.c  .generated_files/flags/default/cf50e530e01967766a6be76a01ab6e083e4b5dc0 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/tmr" 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/tmr/tmr.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/tmr/tmr.o.d" -o ${OBJECTDIR}/src/drivers/tmr/tmr.o src/drivers/tmr/tmr.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/dma/dma.o: src/drivers/dma/dma.c  .generated_files/flags/default/7d7811e56720456e07f2d1f6e8fd161c5ba2a4b4 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/dma" 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/dma/dma.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/dma/dma.o.d" -o ${OBJECTDIR}/src/drivers/dma/dma.o src/drivers/dma/dma.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/clk/clk.o: src/drivers/clk/clk.c  .generated_files/flags/default/4c95580e14c5574d440698513a0bec44ebcb7c2b .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
	@${MKDIR} "${OBJECTDIR}/src/drivers/clk" 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o.d 
	@${RM} ${OBJECTDIR}/src/drivers/clk/clk.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -O2 -MP -MMD -MF "${OBJECTDIR}/src/drivers/clk/clk.o.d" -o ${OBJECTDIR}/src/drivers/clk/clk.o src/drivers/clk/clk.c    -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}"  
	
${OBJECTDIR}/src/drivers/uart/uart.o: src/drivers/uart/uart.c  .generated_files/flags/default/25296fc0d2cf0e32156371f5494bc00d242b978 .generated_files/flags/default/c24b72d7bee263215258d3ef55fcfe58c1441450
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
${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x0:0x37F   -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=4096,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o ${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=4096,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/PIC32MZ_USB_OUT_DSP.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
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
