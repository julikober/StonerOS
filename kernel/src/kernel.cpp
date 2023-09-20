#include "VideoMemory/VideoMemory.hpp"

int main(void) {
  char* str = "!";
  VideoMemory::Memory vmem(VideoMemory::Color::BLUE);
  vmem.Add(str, VideoMemory::Color::LIGHT_BLUE, VideoMemory::Color::BLACK);
  //vmem.Clear();

  //uint8_t* end = (uint8_t*)0xb8F98;
  //*end = 'a';

  // 0xb8F70 seems to be the maximum
  // vmem.location = (VmemUnit*)0xb8000;

  // AddVmem(vmem, str, 0x01, 0x0F);
  // vmem.Add(str, 0x01, 0x0F);

  return 0;
}
