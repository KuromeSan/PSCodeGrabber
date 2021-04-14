#include <psp2/power.h>
#include <psp2/io/fcntl.h>
#include <psp2/kernel/processmgr.h>
#include <psp2/kernel/threadmgr.h>
#include <psp2/appmgr.h>
#include <psp2/types.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int _vshSblAimgrGetPscode(char*);
int _vshSblAimgrGetPscode2(char*);

int WriteFile(char *file, void *buf, int size) {
	SceUID fd = sceIoOpen(file, SCE_O_WRONLY | SCE_O_CREAT | SCE_O_TRUNC, 0777);
	if (fd < 0)
		return fd;

	int written = sceIoWrite(fd, buf, size);

	sceIoClose(fd);
	return written;
}


int main(int argc, const char *argv[]) {
	char PSCode[0x8];
	char PSCode2[0x8];
	memset(PSCode, 0xFF, 0x8);
	memset(PSCode2, 0xFF, 0x8);
	_vshSblAimgrGetPscode(PSCode);
	_vshSblAimgrGetPscode2(PSCode2);
	WriteFile("ux0:/pscode.bin", PSCode, 0x8);
	WriteFile("ux0:/pscode2.bin", PSCode2, 0x8);
	sceKernelDelayThread(1 * 1000 * 1000);
	sceKernelExitProcess(0);
	return 0;
}