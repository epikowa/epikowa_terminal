package epikowa.terminal;

import haxe.io.BytesData;
#if (js && !hxnodejs)
import js.html.TextDecoder;
import js.lib.Uint16Array;
#end
import haxe.io.Bytes;
#if cpp
import epikowa.terminal.tests.CppReader;
#end
import epikowa.terminal.CursorPosition;
import epikowa.terminal.Key;
#if hxnodejs
import js.node.Buffer;
import js.Node;
#end

@:nullSafety(Strict)
class ProgressiveInputReader {
    var keyCallback:Key->Void;
    var cursorPositionCallback:CursorPosition->Void;
    var windowSizeCallback:WindowSize->Void;

    public function new(keyCallback:Key->Void, cursorPositionCallback:CursorPosition->Void, windowSizeCallback:WindowSize->Void) {
        this.keyCallback = keyCallback;
        this.cursorPositionCallback = cursorPositionCallback;
        this.windowSizeCallback = windowSizeCallback;
        #if (js && !hxnodejs)
        Streams.slave.onReadable(() -> {
            var read = Streams.slave.read();
            var ar = new js.lib.Uint8Array(read);
            var decoder = new TextDecoder();
            var decodedString = decoder.decode(ar);
            handleData(Bytes.ofString(decodedString));
        });
        #end
        #if hxnodejs
        Node.process.stdin.on('data', (data:Buffer) -> {
            handleData(data.hxToBytes());
        });
        #end
        #if cpp
        //TODO: Start the infinite loop here
        CppReader.init((data:haxe.io.Bytes) -> {
            handleData(data);
        });
        #end
    }

    public function destroy() {
        #if hxnodejs
        Node.process.stdin.off('data', handleData);
        #end
    }

    var treated:Array<Int> = [];
    var currentMode = ParserMode.None;

    function resetParser() {
        treated = [];
        currentP = [];
        currentI = [];
        currentMode = ParserMode.None;
    }

    function parseNone(data:Bytes, byte:Int, index:Int) {
        switch (byte) {
            case 27:
                currentMode = Esc;
            case 13:
                keyCallback(Key.ENTER);
                resetParser();
            case 127:
                keyCallback(Key.BACKSPACE);
                resetParser();
            default:
                var keyBytes = Bytes.alloc(1);
                keyBytes.set(0, byte);
                keyCallback(Key.CHAR(keyBytes.toString()));
                resetParser();
        }
    }

    function parseEsc(data:Bytes, byte:Int, index:Int) {
        trace('parse ESC', byte);
        switch (byte) {
            case 91:
                currentMode = ParserMode.Csi;
            default:
                trace('ESC default');
        }
    }

    var currentP:Array<Int> = [];
    var currentI:Array<Int> = [];
    function parseCsi(data:Bytes, byte:Int, index:Int) {
        trace('parse CSI', byte);
        if (byte >= 48 && byte <= 63) { //P
            trace('IT IS P');
            currentP.push(byte);
        } else if (byte >= 64 && byte <= 126) { //F
            trace('calling handleCompleted');
            handleCompletedCSI();
        } else if (byte >= 32 && byte <= 47) { //I
            trace('It is I');
            currentI.push(byte);
        }
    }
    
    function handleCompletedCSI() {
        var lastByte = treated[treated.length -1];
        trace('handle CSI', lastByte);
        switch (lastByte) {
            case 65:
                keyCallback(Key.ARROW_UP);
                resetParser();
            case 66:
                keyCallback(Key.ARROW_DOWN);
                resetParser();
            case 67:
                keyCallback(Key.ARROW_RIGHT);
                resetParser();
            case 68:
                trace('IT IS LEFT');
                keyCallback(Key.ARROW_LEFT);
                resetParser();
            case 72:
                keyCallback(Key.HOME);
                resetParser();
            case 82: //R
                var pString = currentP.map((b)-> String.fromCharCode(b)).join('');
                var regexp = ~/([0-9]+);([0-9]+)/;
                regexp.match(pString);
                var line = Std.parseInt(regexp.matched(1));
                var col = Std.parseInt(regexp.matched(2));
                if (line == null || col == null) {
                    cursorPositionCallback(Incorrect);
                } else {
                    cursorPositionCallback(Basic(line, col));
                }
            case 116: //t
                var pString = currentP.map((b)-> String.fromCharCode(b)).join('');
                var regexp = ~/([0-9]+);([0-9]+);([0-9]+)/;
                regexp.match(pString);
                var mode = Std.parseInt(regexp.matched(1));
                var line = Std.parseInt(regexp.matched(2)) ?? 0;
                var col = Std.parseInt(regexp.matched(3)) ?? 0;
                
                switch (mode) {
                    case 8: // size of the text area in chars
                        windowSizeCallback(WindowSize.Characters(line, col));
                    default:
                }
            default:
                resetParser();
        }
    }

    public function handleData(data:haxe.io.Bytes) {
        for (i in 0...data.length) {
            var byte = data.get(i);
            trace('handle', byte);
            treated.push(byte);

            if (data.length == 1 && byte == 27) {
                keyCallback(Key.ESCAPE);
                resetParser();
            }

            switch (currentMode) {
                case None:
                    parseNone(data, byte, i);
                case Esc:
                    parseEsc(data, byte, i);
                case Csi:
                    parseCsi(data, byte, i);
                default:
            }
        }

        // switch ([data.get(0), data.length]) {
        //     case [27, 1]:
        //         keyCallback(Key.ESCAPE);
        //     case [27, 3]:
        //         switch([data.get(1), data.get(2)]) {
        //             case [91, 65]:
        //                 keyCallback(Key.ARROW_UP);
        //             case [91, 66]:
        //                 keyCallback(Key.ARROW_DOWN);
        //             case [91, 68]:
        //                 keyCallback(Key.ARROW_LEFT);
        //             case [91, 67]:
        //                 keyCallback(Key.ARROW_RIGHT);
        //             case [91, 72]:
        //                 keyCallback(Key.HOME);
        //             default:
        //                 keyCallback(UNKNOWN_ESCAPED([data.get(1)]));
        //         }
        //     case [27, _]:
        //             Streams.flush();

        //             var last = data.toString().charAt(data.length-1);
        //             // var last = data.toString('utf-8', data.length-1);
        //             if (isKittyGraphics(data)) {
        //                 trace('KITTY GRAPHICS CODE');
        //                 return;
        //             }
        //             switch (last) {
        //                 case 'R':
        //                     var regexp = ~/\[([0-9]+);([0-9]+)/;
        //                     var restString = data.toString().substr(1);
        //                     regexp.match(restString);
        //                     var line = Std.parseInt(regexp.matched(1));
        //                     var col = Std.parseInt(regexp.matched(2));
        //                     if (line == null || col == null) {
        //                         cursorPositionCallback(Incorrect);
        //                     } else {
        //                         cursorPositionCallback(Basic(line, col));
        //                     }
        //                 case 't':
        //                     var regexp = ~/\[([0-9]+);([0-9]+);([0-9]+)/;
        //                     var restString = data.toString().substr(1);
        //                     var asString = restString;
        //                     regexp.match(asString);
        //                     var mode = Std.parseInt(regexp.matched(1));
        //                     var line = Std.parseInt(regexp.matched(2)) ?? 0;
        //                     var col = Std.parseInt(regexp.matched(3)) ?? 0;
                            
        //                     switch (mode) {
        //                         case 8: // size of the text area in chars
        //                             windowSizeCallback(WindowSize.Characters(line, col));
        //                         default:
        //                     }
        //                 default:
        //                     trace('unknown escaped');
        //                     var formattedData = new Array<Int>();
        //                     for (i in 1...data.length) {
        //                         formattedData.push(data.get(i));
        //                     }
        //                     trace(formattedData.map(d->String.fromCharCode(d)));
        //                     keyCallback(UNKNOWN_ESCAPED(formattedData));
        //             }
        //     case [13, _]:
        //         keyCallback(Key.ENTER);
        //     case [127, _]:
        //         keyCallback(Key.BACKSPACE);
        //     default:
        //         keyCallback(Key.CHAR(data.toString()));
        // }
    }

    static function isKittyGraphics(data:haxe.io.Bytes):Bool {
        if (data.length < 2) {
            return false;
        }

        var s = String.fromCharCode(data.get(1)) + String.fromCharCode(data.get(2));
        if (!(s == '_G')) return false;

        

        return true;
    }
}

enum ParserMode {
    None;
    Esc;
    Csi;
}