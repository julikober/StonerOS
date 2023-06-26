#include "VideoMemory/VideoMemory.h"

int main(void) {
  char* str = "Hello World!";
  VideoMemory vmem;
  vmem.location = (VmemUnit*)0xb8000;

  AddVmem(vmem, str, 0x01, 0x0F);
  //vmem.Add(str, 0x01, 0x0F);

  return 0;
}
