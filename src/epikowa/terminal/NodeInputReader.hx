package epikowa.terminal;

import epikowa.terminal.CursorPosition;
import epikowa.terminal.Key;
import js.node.Buffer;
import js.Node;

@:nullSafety(Strict)
class NodeInputReader {
    var keyCallback:Key->Void;
    var cursorPositionCallback:CursorPosition->Void;
    var windowSizeCallback:WindowSize->Void;

    public function new(keyCallback:Key->Void, cursorPositionCallback:CursorPosition->Void, windowSizeCallback:WindowSize->Void) {
        this.keyCallback = keyCallback;
        this.cursorPositionCallback = cursorPositionCallback;
        this.windowSizeCallback = windowSizeCallback;
        Node.process.stdin.on('data', handleData);
    }

    public function destroy() {
        Node.process.stdin.off('data', handleData);
    }

    public function handleData(data:Buffer) {
        switch ([data.readInt8(), data.length]) {
            case [27, 1]:
                keyCallback(Key.ESCAPE);
            case [27, 3]:
                switch([data.readInt8(1), data.readInt8(2)]) {
                    case [91, 65]:
                        keyCallback(Key.ARROW_UP);
                    case [91, 66]:
                        keyCallback(Key.ARROW_DOWN);
                    case [91, 68]:
                        keyCallback(Key.ARROW_LEFT);
                    case [91, 67]:
                        keyCallback(Key.ARROW_RIGHT);
                    case [91, 72]:
                        keyCallback(Key.HOME);
                    default:
                        keyCallback(UNKNOWN_ESCAPED([data.readInt8(1)]));
                }
            case [27, _]:
                    var last = data.toString('utf-8', data.length-1);
                    switch (last) {
                        case 'R':
                            var regexp = ~/\[([0-9]+);([0-9]+)/;
                            regexp.match(data.toString('utf-8', 1));
                            var line = Std.parseInt(regexp.matched(1));
                            var col = Std.parseInt(regexp.matched(2));
                            if (line == null || col == null) {
                                cursorPositionCallback(Incorrect);
                            } else {
                                cursorPositionCallback(Basic(line, col));
                            }
                        case 't':
                            var regexp = ~/\[([0-9]+);([0-9]+);([0-9]+)/;
                            var asString = data.toString('utf-8', 1);
                            regexp.match(asString);
                            var mode = Std.parseInt(regexp.matched(1));
                            var line = Std.parseInt(regexp.matched(2)) ?? 0;
                            var col = Std.parseInt(regexp.matched(3)) ?? 0;
                            
                            switch (mode) {
                                case 8: // size of the text area in chars
                                    windowSizeCallback(WindowSize.Characters(line, col));
                                default:
                            }
                        default:
                            trace('unknown escaped');
                            var formattedData = new Array<Int>();
                            for (i in 1...data.length) {
                                formattedData.push(data.readInt8(i));
                            }
                            keyCallback(UNKNOWN_ESCAPED(formattedData));
                    }
            case [13, _]:
                keyCallback(Key.ENTER);
            case [127, _]:
                keyCallback(Key.BACKSPACE);
            default:
                keyCallback(Key.CHAR(data.toString()));
        }
    }
}