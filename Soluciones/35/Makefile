#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>devkitPRO")
endif

ifeq ($(strip $(DESMUME)),)
$(error "Please set DESMUME in your environment. export DESMUME=<path to>DeSmuME")
endif

include $(DEVKITARM)/ds_rules

#---------------------------------------------------------------------------------
# TARGET is the name of the output
# BUILD is the directory where object files & intermediate files will be placed
# SOURCES is a list of directories containing source code
# INCLUDES is a list of directories containing extra header files
#---------------------------------------------------------------------------------
TARGET		:=	$(shell basename $(CURDIR))
BUILD		:=	build
SOURCES		:=	source  
INCLUDES	:=	include

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------
ARCH	:=	-march=armv5te -mlittle-endian

CFLAGS	:=	-Wall -gdwarf-3 -O0 \
			$(ARCH) -mtune=arm946e-s -fomit-frame-pointer -ffast-math
				# -Wall						: enable all warnings
				# -g						: enable debug info generation
				# -O2						: code optimization level 2
				# $(ARCH) -mtune=arm946e-s	: tune code generation for specific machine
				# -fomit-frame-pointer 		: avoid to use a 'frame-pointer' register in functions that do not need it
				# -ffast-math				: optimize math operations

CFLAGS	+=	$(INCLUDE) -DARM9

ASFLAGS	:=	-g $(ARCH)
LDFLAGS	=	-specs=ds_arm9.specs $(ARCH)

#---------------------------------------------------------------------------------
# any extra libraries we wish to link with the project
#---------------------------------------------------------------------------------
LIBS	:=	-lnds9
 
#---------------------------------------------------------------------------------
# list of directories containing libraries, this must be the top level containing
# include and lib
#---------------------------------------------------------------------------------
LIBDIRS	:=	$(LIBNDS)
 
#---------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add additional
# rules for different file extensions
#---------------------------------------------------------------------------------
ifneq ($(BUILD),$(notdir $(CURDIR)))
#---------------------------------------------------------------------------------
 
export OUTPUT	:=	$(CURDIR)/$(TARGET)

export VPATH	:=	$(foreach dir,$(SOURCES),$(CURDIR)/$(dir))
export DEPSDIR	:=	$(CURDIR)/$(BUILD)

CFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
AFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
BINFILES	:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.bin)))

export LIBFILE	:=	$(CURDIR)/lib/p35.a
export ARM7ELF	:=	$(CURDIR)/lib/arm7elf.a

export OFILES	:=	$(BINFILES:.bin=.o) $(CFILES:.c=.o) $(SFILES:.s=.o)
export SFILES	:=	$(AFILES:.s=.o)

export INCLUDE	:=	$(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir)) \
					$(foreach dir,$(LIBDIRS),-I$(dir)/include)

export LIBPATHS	:=	$(foreach dir,$(LIBDIRS),-L$(dir)/lib)

#---------------------------------------------------------------------------------
# use CC for linking standard C projects 
#---------------------------------------------------------------------------------
export LD	:=	$(CC)

export GAME_TITLE	:=	TOUCHSPEED
export GAME_SUBTITLE1	:=	Demostracion velocidad de toque
export GAME_SUBTITLE2	:=	Departamento de Ingenieria Informatica y Matematicas (URV)
export GAME_ICON	:= 	$(DEVKITPRO)/libnds/icon.bmp


.PHONY: $(BUILD) clean
 
#---------------------------------------------------------------------------------
$(BUILD):
	@[ -d $@ ] || mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile
 
#---------------------------------------------------------------------------------
clean:
	@echo clean ...
	@rm -fr $(BUILD) $(TARGET).elf $(TARGET).nds *.pnps 

#---------------------------------------------------------------------------------
run : $(TARGET).nds
	@echo "runing $(TARGET).nds with DesmuME"
	@$(DESMUME)/DeSmuME_dev.exe $(TARGET).nds &

#---------------------------------------------------------------------------------
debug : $(TARGET).nds $(TARGET).elf
	@echo "testing $(TARGET).nds/.elf with DeSmuME_dev/Insight (gdb) through TCP port=1000"
	@$(DESMUME)/DeSmuME_dev.exe --arm9gdb=1000 $(TARGET).nds &
	@$(DEVKITPRO)/insight/bin/arm-eabi-insight $(TARGET).elf &

#---------------------------------------------------------------------------------
else
 
DEPENDS	:=	$(OFILES:.o=.d) $(SFILES:.o=.d)
 
#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------
$(OUTPUT).nds	: 	$(OUTPUT).elf
$(OUTPUT).elf	:	$(OFILES) $(SFILES)

#---------------------------------------------------------------------------------
%.nds: %.elf
	@ndstool -c $@ -7 $(ARM7ELF) -9 $< -b $(GAME_ICON) "$(GAME_TITLE);$(GAME_SUBTITLE1);$(GAME_SUBTITLE2)"
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.elf:
	@echo linking $(notdir $@)
	$(LD)  $(LDFLAGS) $(OFILES) $(LIBFILE) $(LIBPATHS) $(LIBS) $(SFILES) -o $@


#---------------------------------------------------------------------------------
%.o	:	%.bin
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	$(bin2o)


-include $(DEPSDIR)/*.d
 
#---------------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------------
