#ifndef __TEST_H
#define __TEST_H

#include <iostream>
#include <termios.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

class CppTerminal {
private:
    inline static struct termios orig_termios;  
public:
	CppTerminal() {}

    
    static void disableRawMode() {
        tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios);
    }

    static void init() {
        if (tcgetattr(0,&orig_termios) < 0) fatal("can't get tty settings");
        atexit(disableRawMode);

        struct termios raw;

        raw = orig_termios;  /* copy original and then modify below */

        /* input modes - clear indicated ones giving: no break, no CR to NL, 
        no parity check, no strip char, no start/stop output (sic) control */
        raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);

        /* output modes - clear giving: no post processing such as NL to CR+NL */
        // raw.c_oflag &= ~(OPOST);

        /* control modes - set 8 bit chars */
        // raw.c_cflag |= (CS8);

        /* local modes - clear giving: echoing off, canonical off (no erase with 
        backspace, ^U,...),  no extended functions, no signal chars (^Z,^C) */
        raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);

        /* control chars - set return condition: min number of bytes and timer */
        // raw.c_cc[VMIN] = 5; raw.c_cc[VTIME] = 8; /* after 5 bytes or .8 seconds
                                                    // after first byte seen      */
        // raw.c_cc[VMIN] = 0; raw.c_cc[VTIME] = 0; /* immediate - anything       */
        // raw.c_cc[VMIN] = 2; raw.c_cc[VTIME] = 0; /* after two bytes, no timer  */
        // raw.c_cc[VMIN] = 0; raw.c_cc[VTIME] = 8; /* after a byte or .8 seconds */

        // fprintf(0, "done");
        /* put terminal in raw mode after flushing */
        // if (tcsetattr(0,TCSAFLUSH,&raw) < 0) fatal("can't set raw mode");
        tcsetattr(0,TCSAFLUSH,&raw);
    }

    static void fatal(char *message)
    {
        fprintf(stderr,"fatal error: %s\n",message);
        exit(1);
    }

	~CppTerminal() {}
};
#endif
