#include "VideoMemory.hpp"

VideoMemory::Memory::Memory(Color bg) {
  for (Vmem* p = vmemBegin_; p != vmemEnd_; p++) {
    p->color = (uint8_t)bg << 4;
  }
}

void VideoMemory::Memory::Add(const char* string, Color fg, Color bg) {
  /*if (fg >= 16 || bg >= 16) {
    return;
  }*/

  for (int64_t i = 0; string[i] != '\0'; i++) {
    vmemCurrent_->color = (uint8_t)bg << 4;
    vmemCurrent_->color |= (uint8_t)fg;

    vmemCurrent_->c = string[i];
    vmemCurrent_++;
  }
}

void VideoMemory::Memory::Add(const char* string, Color fg) {
  for (int64_t i = 0; string[i] != '\0'; i++) {
    vmemCurrent_->color = (uint8_t)fg << 4;

    vmemCurrent_->c = string[i];
    vmemCurrent_++;
  }
}

void VideoMemory::Memory::Clear() {
  for (Vmem* p = vmemBegin_; p != vmemEnd_; p++) {
    p->c = (char)0;

    p->color = (uint8_t)Color::BLACK << 4;
    p->color |= (uint8_t)Color::WHITE;
  }
  vmemCurrent_ = vmemBegin_;
}

/*extern "C" {
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
}*/
