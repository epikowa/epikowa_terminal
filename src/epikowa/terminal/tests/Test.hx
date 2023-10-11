package epikowa.terminal.tests;

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
    }

    static function gotWindowSize(ws:WindowSize) {
        switch (ws) {
            case Characters(line, col):
                trace('Got window size ${line}, ${col} chars');
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