#include "VideoMemory.h"

/*void VideoMemory::Add(char* string, uint8_t fg, uint8_t bg) {
  if (fg >= 16 || bg >= 16) {
    return;
  }

  Vmem tmp = *vmemCurrent_;

  tmp.color = fg << 4;
  tmp.color |= bg;
}*/

void AddVmem(VideoMemory vMem, char* string, uint8_t fg, uint8_t bg) {
  if (fg >= 16 || bg >= 16) {
    return;
  }

  VmemUnit* location = (VmemUnit*)vMem.location;

  for (int64_t i = 0; string[i] != '\0'; i++) {
    location->color = fg << 4;
    location->color |= bg;

    location->c = string[i];
    location++;
  }
}
