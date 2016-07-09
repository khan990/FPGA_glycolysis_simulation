################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/my_newip_22.c \
../src/platform.c \
../src/source.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/my_newip_22.o \
./src/platform.o \
./src/source.o 

C_DEPS += \
./src/my_newip_22.d \
./src/platform.d \
./src/source.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: PowerPC gcc compiler'
	powerpc-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -D __XMK__ -I../../xilkernel_bsp_0/ppc405_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


