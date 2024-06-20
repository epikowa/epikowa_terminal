package epikowa.terminal;

#if cpp
import epikowa.terminal.ext.cpp.TermIOs;
#end

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
            TermIOs.enableRawMode();
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

        #if hxnodejs
        new NodeInputReader(handleKeyPress, handleCursorPosition, handleWindowSize);
        #elseif cpp
        new CppInputReader(handleKeyPress, handleCursorPosition, handleWindowSize);
        #end
    }

    public function moveCursorToPosition(line:Int, col:Int) {
        Sys.print('${ESC}${CSI}${line};${col}H');
        Sys.stdout().flush();
    }

    public function moveCursorUp(count:Int) {
        Sys.print('${ESC}${CSI}${count}A');
        Sys.stdout().flush();
    }

    public function moveCursorDown(count:Int) {
        Sys.print('${ESC}${CSI}${count}B');
        Sys.stdout().flush();
    }

    public function moveCursorLeft(count:Int) {
        Sys.print('${ESC}${CSI}${count}D');
        Sys.stdout().flush();
    }

    public function moveCursorRight(count:Int) {
        Sys.print('${ESC}${CSI}${count}C');
        Sys.stdout().flush();
    }

    public function eraseScreen() {
        Sys.stdout().writeString('${ESC}${CSI}2J');
        Sys.stdout().flush();
    }

    public function getCursorPosition() {
        Sys.print('${ESC}${CSI}6n');
        Sys.stdout().flush();
    }

    public function hideCursor() {
        Sys.print('${ESC}${CSI}?25l');
        Sys.stdout().flush();
    }

    public function showCursor() {
        Sys.print('${ESC}${CSI}?25h');
        Sys.stdout().flush();
    }

    public function writeBackspace() {
        Sys.print('\x08');
        Sys.stdout().flush();
    }

    public function writeBell() {
        Sys.print('\x07');
        Sys.stdout().flush();
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
        Sys.print('${ESC}${CSI}18t');
        Sys.stdout().flush();
    }
}