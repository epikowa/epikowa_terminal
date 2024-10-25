package epikowa.terminal.tests;

#if js
import js.Syntax;
#end
#if cpp
import sys.thread.Thread;
import sys.io.File;
#end
import haxe.crypto.Base64;
import epikowa.terminal.Mode.WriteModes;
import epikowa.terminal.Colors.AnyTrueColor;

class Test {
    static var terminal:HighTerminal;

    public static function main() {

        #if (js && !hxnodejs)
        var term = new xterm.xterm.xterm.Terminal({});
        Streams.xterm = term;
        term.open(js.Browser.document.getElementById('terminal'));
        var pty = Syntax.code('openpty()');
        var slave = pty.slave;
        var master = pty.master;
        var getioctl = slave.ioctl('TCGETS', null);
        getioctl.lflag = getioctl.lflag & ~8 & ~16 & ~2;
        slave.ioctl('TCSETS', getioctl);
        Streams.slave = slave;
        term.loadAddon(master);
        #end

        Terminal.init();
        terminal = new HighTerminal(gotKey, gotCursorPosition, gotWindowSize);
        terminal.eraseScreen();
        terminal.hideCursor();
        terminal.moveCursorToPosition(3, 15);
        terminal.windowSizeReceived.add((ws) -> trace('Triggered WS'));
        Streams.print('Position');
        terminal.moveCursorRight(3);
        Streams.print('Continue');
        terminal.moveCursorDown(1);
        terminal.modes.selectBackgroundTrueColor({r: 100, g: 100, b: 100});
        terminal.modes.setWriteMode(SET_BOLD);
        Streams.print('Err');
        terminal.modes.setWriteMode(RESET_BOLD);
        terminal.modes.selectBackgroundColor16Bit(Default);
        terminal.modes.selectForegroundColor16Bit(Cyan);
        terminal.modes.setWriteMode(SET_STRIKETHROUGH);
        Streams.print('Cyan');
        terminal.modes.setWriteMode(RESET_STRIKETHROUGH);
        terminal.modes.selectForegroundColor16Bit(Default);
        Streams.print('Reset');
        terminal.getCursorPosition();
        // Sys.sleep(5);

        // readPNG();
        // KittyGraphics.transmitPNG(Sys.args()[0], 45);
        // KittyGraphics.placeImage(45);
        #if cpp
        // epikowa.terminal.tests.CppReader.init();
        // CppReader.read();
        // TestMacro.traceMarkup(<String myVar=" " />);
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

    #if cpp
    static function readPNG() {
        var uri = Sys.args()[0];

        var b64 = Base64.encode(File.getBytes(uri));
        var pos = 0;
        final chunkLength = 4096;
        while (pos < b64.length) {
            Streams.print('${Terminal.ESC}_G');
            var chunk = b64.substr(pos, chunkLength);
            if(pos == 0) {
                Streams.print('a=T,f=100,');
            }
            pos = pos + chunkLength;
            if(pos < b64.length) {
                Streams.print('m=1');
            }
            Streams.print(';${chunk}');
            Streams.print('${Terminal.ESC}\\');
        }
    }
    #end

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
                // Streams.print(char);
            case BACKSPACE:
                terminal.writeBackspace();
                Streams.print(' ');
                terminal.moveCursorLeft(1);
            case ENTER:
                terminal.showCursor();
                terminal.askCharactersDimensions();
            case ESCAPE:
                terminal.showCursor();
                trace('Exiting');
                // Sys.exit(0);
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