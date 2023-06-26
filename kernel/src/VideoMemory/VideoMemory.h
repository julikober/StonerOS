#pragma once

#include <stdint.h>

/*class VideoMemory {
 private:
  struct Vmem {
    char c;
    uint8_t color;
  };

  Vmem* vmemBegin_ = (Vmem*)0xb8000;
  Vmem* vmemCurrent_ = (Vmem*)0xb8000;

 public:
  VideoMemory() = default;

  void Clear();
  void Add(char* string, uint8_t fg, uint8_t bg);

 private:
};*/

typedef struct VmemUnit {
  char c;
  uint8_t color;
} VmemUnit;

typedef struct VideoMemory {
  VmemUnit* location;
} VideoMemory;

void AddVmem(VideoMemory vMem, char* string, uint8_t fg, uint8_t bg);
