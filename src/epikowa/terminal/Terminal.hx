package epikowa.terminal;

#if hxnodejs
import js.Syntax;
#end

@:nullSafety(Strict)
class Terminal {
    public static final ESC = '\x1b';
    public static final CSI = '[';

    public static function init() {
        #if hxnodejs
        Syntax.code('process.stdin.setRawMode(true)');
        #end
        #if cpp
        CppTerminal.init();
        #end
    }

    var keyCallBack:Null<Key->Void>;
    var cursorPositionCallback:Null<CursorPosition->Void>;
    var windowSizeCallback:Null<WindowSize->Void>;

    public var modes(default, never):Mode = new Mode();

    public function new(?keyCallback:Key->Void, ?cursorPositionCallback:CursorPosition->Void, ?windowSizeCallback:WindowSize->Void) {
        this.keyCallBack = keyCallback;
        this.cursorPositionCallback = cursorPositionCallback;
        this.windowSizeCallback = windowSizeCallback;

        // new NodeInputReader(handleKeyPress, handleCursorPosition, handleWindowSize);
        // new NewInputReader(handleKeyPress, handleCursorPosition, handleWindowSize);
        new ProgressiveInputReader(handleKeyPress, handleCursorPosition, handleWindowSize);

    }

    public function moveCursorToPosition(line:Int, col:Int) {
        Streams.print('${ESC}${CSI}${line};${col}H');
        Streams.flush();
    }

    public function moveCursorUp(count:Int) {
        Streams.print('${ESC}${CSI}${count}A');
        Streams.flush();
    }

    public function moveCursorDown(count:Int) {
        Streams.print('${ESC}${CSI}${count}B');
        Streams.flush();
    }

    public function moveCursorLeft(count:Int) {
        Streams.print('${ESC}${CSI}${count}D');
        Streams.flush();
    }

    public function moveCursorRight(count:Int) {
        Streams.print('${ESC}${CSI}${count}C');
        Streams.flush();
    }

    public function eraseScreen() {
        Streams.writeString('${ESC}${CSI}2J');
        Streams.flush();
    }

    public function getCursorPosition() {
        trace('DO');
        Streams.flush();
        Streams.print('${ESC}${CSI}6n');
        Streams.flush();
        trace('DO2');
    }

    public function hideCursor() {
        Streams.print('${ESC}${CSI}?25l');
        Streams.flush();
    }

    public function showCursor() {
        Streams.print('${ESC}${CSI}?25h');
        Streams.flush();
    }

    public function writeBackspace() {
        Streams.print('\x08');
        Streams.flush();
    }

    public function writeBell() {
        Streams.print('\x07');
        Streams.flush();
    }

    function handleKeyPress(k:Key) {
        keyCallBack != null ? keyCallBack(k) : null;
    }

    function handleCursorPosition(cp:CursorPosition) {
        cursorPositionCallback != null ? cursorPositionCallback(cp) : null;
    }

    function handleWindowSize(ws:WindowSize) {
        windowSizeCallback != null ? windowSizeCallback(ws) : null;
    }

    public function askCharactersDimensions() {
        Streams.print('${ESC}${CSI}18t');
        Streams.flush();
    }

    public function askPrimaryDeviceAttributes() {
        Streams.print('${ESC}${CSI}0c');
        Streams.flush();
    }
}