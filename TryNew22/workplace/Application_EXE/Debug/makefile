################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
Application_EXE.elf.size \

ELFCHECK += \
Application_EXE.elf.elfcheck \


# All Target
all: Application_EXE.elf secondary-outputs

# Tool invocations
Application_EXE.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: PowerPC gcc linker'
	powerpc-eabi-gcc -Wl,-T -Wl,../src/lscript.ld -L../../xilkernel_bsp_0/ppc405_0/lib -o "Application_EXE.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

Application_EXE.elf.size: Application_EXE.elf
	@echo 'Invoking: PowerPC Print Size'
	powerpc-eabi-size Application_EXE.elf  |tee "Application_EXE.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

Application_EXE.elf.elfcheck: Application_EXE.elf
	@echo 'Invoking: Xilinx ELF Check'
	elfcheck Application_EXE.elf -hw ../../TryNew22_hw_platform/system.xml -pe ppc405_0  |tee "Application_EXE.elf.elfcheck"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS)$(C_DEPS)$(EXECUTABLES)$(ELFSIZE)$(ELFCHECK)$(S_UPPER_DEPS) Application_EXE.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE) $(ELFCHECK)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
