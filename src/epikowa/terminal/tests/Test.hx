package epikowa.terminal.tests;

import sys.thread.Thread;
import haxe.crypto.Base64;
import sys.io.File;
import epikowa.terminal.Mode.WriteModes;
import epikowa.terminal.Colors.AnyTrueColor;

class Test {
    static var terminal:HighTerminal;

    public static function main() {
        Terminal.init();
        terminal = new HighTerminal(gotKey, gotCursorPosition, gotWindowSize);
        terminal.eraseScreen();
        terminal.hideCursor();
        terminal.moveCursorToPosition(3, 15);
        terminal.windowSizeReceived.add((ws) -> trace('Triggered WS'));
        Sys.print('Position');
        terminal.moveCursorRight(3);
        Sys.print('Continue');
        terminal.moveCursorDown(1);
        terminal.modes.selectBackgroundTrueColor({r: 100, g: 100, b: 100});
        terminal.modes.setWriteMode(SET_BOLD);
        Sys.print('Err');
        terminal.modes.setWriteMode(RESET_BOLD);
        terminal.modes.selectBackgroundColor16Bit(Default);
        terminal.modes.selectForegroundColor16Bit(Cyan);
        terminal.modes.setWriteMode(SET_STRIKETHROUGH);
        Sys.print('Cyan');
        terminal.modes.setWriteMode(RESET_STRIKETHROUGH);
        terminal.modes.selectForegroundColor16Bit(Default);
        Sys.print('Reset');
        terminal.getCursorPosition();
        // Sys.sleep(5);

        // readPNG();
        // KittyGraphics.transmitPNG(Sys.args()[0], 45);
        // KittyGraphics.placeImage(45);
        #if cpp
        // epikowa.terminal.tests.CppReader.init();
        // CppReader.read();
        while (true) {
            Thread.processEvents();
        }
        #end
    }

    static function gotWindowSize(ws:WindowSize) {
        switch (ws) {
            case Characters(line, col):
                trace('Got window size ${line}, ${col} chars');
        }
    }

    static function readPNG() {
        var uri = Sys.args()[0];

        var b64 = Base64.encode(File.getBytes(uri));
        var pos = 0;
        final chunkLength = 4096;
        while (pos < b64.length) {
            Sys.print('${Terminal.ESC}_G');
            var chunk = b64.substr(pos, chunkLength);
            if(pos == 0) {
                Sys.print('a=T,f=100,');
            }
            pos = pos + chunkLength;
            if(pos < b64.length) {
                Sys.print('m=1');
            }
            Sys.print(';${chunk}');
            Sys.print('${Terminal.ESC}\\');
        }
    }

    static function gotCursorPosition(cp:CursorPosition) {
        switch (cp) {
            case Basic(line, col):
                trace('Cursor at ${line}:${col}');
            default:
        }
    }

    static function gotKey(k:Key) {
        switch (k) {
            case CHAR(char):
                Sys.print(char);
            case BACKSPACE:
                terminal.writeBackspace();
                Sys.print(' ');
                terminal.moveCursorLeft(1);
            case ENTER:
                terminal.showCursor();
                terminal.askCharactersDimensions();
            case ESCAPE:
                terminal.showCursor();
                Sys.exit(0);
            case ARROW_LEFT:
                terminal.moveCursorLeft(1);
            case ARROW_RIGHT:
                terminal.moveCursorRight(1);
            case ARROW_UP:
                terminal.moveCursorUp(1);
                // terminal.cursorPositionReceived.addOnce((cp) -> {
                //     trace('CURSOR EVENT');
                // });
                // terminal.getCursorPosition();
            case ARROW_DOWN:
                terminal.moveCursorDown(1);
            default:
        }
    }
}