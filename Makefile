TITLE_ID = NPXS15631
TARGET = PSCodeGrabber
OBJS   = main.o

LIBS = -lSceDisplay_stub -lSceGxm_stub \
	-lSceVshBridge_stub	-lSceSysmodule_stub -lSceCtrl_stub \
	-lSceCommonDialog_stub -lfreetype -lpng -ljpeg -lz -lm -lc \
	-lSceRegistryMgr_stub -lScePower_stub -lSceAppMgr_stub

PREFIX  = arm-vita-eabi
CC      = $(PREFIX)-gcc
CFLAGS  = -Wl,-q -Wall -O3 -std=c99
ASFLAGS = $(CFLAGS)

all: $(TARGET).vpk

%.vpk: eboot.bin
	vita-mksfoex  -s CATEGORY=gdb -s TITLE_ID=$(TITLE_ID) "PSCode" sce_sys/param.sfo
	vita-pack-vpk -s sce_sys/param.sfo -b eboot.bin -a sce_sys/icon0.png=sce_sys/icon0.png -a sce_sys/livearea/contents/bg.png=sce_sys/livearea/contents/bg.png -a sce_sys/livearea/contents/template.xml=sce_sys/livearea/contents/template.xml $@

eboot.bin: $(TARGET).velf
	vita-make-fself $< eboot.bin

%.velf: %.elf
	vita-elf-create $< $@

%.elf: $(OBJS)
	$(CC) $(CFLAGS) $^ $(LIBS) -o $@

clean:
	@rm -rf *.velf *.elf *.vpk $(OBJS) sce_sys/param.sfo eboot.bin
