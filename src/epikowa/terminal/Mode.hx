package epikowa.terminal;

import epikowa.terminal.Colors;

class Mode {
    public static final ESC = Terminal.ESC;
    public static final CSI = Terminal.CSI;

    public function new() {

    }

    public function selectForegroundTrueColor(color:AnyTrueColor) {
        Sys.stdout().writeString('${ESC}${CSI}38;2;${Std.string(color.r)};${Std.string(color.g)};${Std.string(color.b)}m');
        Sys.stdout().flush();
    }

    public function selectBackgroundTrueColor(color:AnyTrueColor) {
        Sys.stdout().writeString('${ESC}${CSI}48;2;${Std.string(color.r)};${Std.string(color.g)};${Std.string(color.b)}m');
        Sys.stdout().flush();
    }

    public function selectForegroundColor16Bit(code:Foreground16BitColors) {
        Sys.stdout().writeString('${ESC}${CSI}${code}m');
        Sys.stdout().flush();
    }

    public function selectBackgroundColor16Bit(code:Background16BitColors) {
        Sys.stdout().writeString('${ESC}${CSI}${code}m');
        Sys.stdout().flush();
    }

    public function setMode(mode:ScreenModes) {
        Sys.stdout().writeString('${ESC}${CSI}=${Std.string(mode)}h');
        Sys.stdout().flush();
    }

    public function setWriteMode(mode:WriteModes) {
        Sys.stdout().writeString('${ESC}${CSI}${Std.string(mode)}m');
        Sys.stdout().flush();
    }
}

/*
ESC[={value}h	Changes the screen width or type to the mode specified by value.
ESC[=0h	40 x 25 monochrome (text)
ESC[=1h	40 x 25 color (text)
ESC[=2h	80 x 25 monochrome (text)
ESC[=3h	80 x 25 color (text)
ESC[=4h	320 x 200 4-color (graphics)
ESC[=5h	320 x 200 monochrome (graphics)
ESC[=6h	640 x 200 monochrome (graphics)
ESC[=7h	Enables line wrapping
ESC[=13h	320 x 200 color (graphics)
ESC[=14h	640 x 200 color (16-color graphics)
ESC[=15h	640 x 350 monochrome (2-color graphics)
ESC[=16h	640 x 350 color (16-color graphics)
ESC[=17h	640 x 480 monochrome (2-color graphics)
ESC[=18h	640 x 480 color (16-color graphics)
ESC[=19h	320 x 200 color (256-color graphics)
ESC[={value}l	Resets the mode by using the same values that Set Mode uses, except for 7, which disables line wrapping. The last character in this escape sequence is a lowercase L.
    */

enum abstract ScreenModes(Int) {
    var MONOCHROME_40x25 = 0;
    var COLOR_40x25 = 1;
    var MONOCHROME_80x25 = 2;
    var COLOR_80x25 = 3;
    var GRAPHICS_4_COLORS_320x200 = 4;
    var MONOCHROME_320x200 = 5;
    var MONOCHROME_640x200 = 6;
    var ENABLE_LINE_WRAPPING = 7;
    var GRAPHICS_320x200 = 13;
    var GRAPHICS_16_COLORS_640x200 = 14;
    var GRAPHICS_2_COLORS_640x350 = 15;
    var GRAPHICS_16_COLORS_640x350 = 16;
    var GRAPHICS_2_COLORS_640x480 = 17;
    var GRAPHICS_16_COLORS_640x480 = 18;
    var GRAPHICS_256_COLORS_640x480 = 19;
}

/*
ESC[1;34;{...}m		Set graphics modes for cell, separated by semicolon (;).
ESC[0m		reset all modes (styles and colors)
ESC[1m	ESC[22m	set bold mode.
ESC[2m	ESC[22m	set dim/faint mode.
ESC[3m	ESC[23m	set italic mode.
ESC[4m	ESC[24m	set underline mode.
ESC[5m	ESC[25m	set blinking mode
ESC[7m	ESC[27m	set inverse/reverse mode
ESC[8m	ESC[28m	set hidden/invisible mode
ESC[9m	ESC[29m	set strikethrough mode.
*/

enum abstract WriteModes(Int) {
    var SET_BOLD = 1;
    var SET_DIM = 2;
    var SET_ITALIC = 3;
    var SET_UNDERLINE = 4;
    var SET_BLINKING = 5;
    var SET_INVERSE = 7;
    var SET_HIDDEN = 8;
    var SET_STRIKETHROUGH = 9;
    var RESET_BOLD = 22;
    var RESET_DIM = 22;
    var RESET_ITALIC = 23;
    var RESET_UNDERLINE = 24;
    var RESET_BLINKING = 25;
    var RESET_INVERSE = 27;
    var RESET_HIDDEN = 28;
    var RESET_STRIKETHROUGH = 29;
}