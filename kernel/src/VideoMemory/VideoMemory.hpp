#pragma once

#include <stdint.h>

namespace VideoMemory {
enum class Color : uint8_t {
  BLACK,
  BLUE,
  GREEN,
  CYAN,
  RED,
  PURPLE,
  BROWN,
  GRAY,
  DARK_GREY,
  LIGHT_BLUE,
  LIGHT_GREEN,
  LIGHT_CYAN,
  LIGHT_RED,
  LIGHT_PURPLE,
  YELLOW,
  WHITE
};

class Memory {
 private:
  struct __attribute__((packed)) Vmem {
    char c;
    uint8_t color;
  };

  Vmem* vmemBegin_ = (Vmem*)0xb8000;
  Vmem* vmemEnd_ = (Vmem*)0xb8F9C;

  Vmem* vmemCurrent_ = (Vmem*)0xb8000;

 public:
  Memory() = default;
  Memory(Color bg);

  void Clear();
  void Add(const char* string, Color fg, Color bg);
  void Add(const char* string, Color fg);

 private:
 public:
  static const Vmem* Begin;
};
}  // namespace VideoMemory
