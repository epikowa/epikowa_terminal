package epikowa.terminal.ext.cpp;

@:cppFileCode('#include <termios.h>
#include <unistd.h>
#include <sys/ioctl.h>

uint64_t is_stdin_empty() {
    uint64_t bytes;
    ioctl(0,FIONREAD, &bytes);
    return bytes;
  }

void _enableRawMode() {
  struct termios raw;
  tcgetattr(STDIN_FILENO, &raw);
  raw.c_lflag &= ~(ECHO | ICANON);
  tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
}

bool __dataAvailable() {
    uint64_t available_bytes = 0;
    available_bytes = is_stdin_empty();

    return available_bytes > 0;
}

uint64_t ___countDataAvailable() {
    uint64_t available_bytes = 0;
    available_bytes = is_stdin_empty();


    return available_bytes;
}
')
class TermIOs {
    static public function enableRawMode():Void {
        untyped __cpp__('_enableRawMode()');
    }

    static public function dataAvailable():Bool {
        return untyped __cpp__('__dataAvailable()');
    }

    static public function countDataAvailable():cpp.UInt64 {
        return untyped __cpp__('___countDataAvailable()');
    }
}