package epikowa.terminal;

import js.lib.Promise;
import epikowa.events.SimpleEvent;

@:nullSafety(Strict)
class HighTerminal extends Terminal {
    public var cursorPositionReceived(default, null):SimpleEvent<CursorPosition> = new SimpleEvent();
    public var windowSizeReceived(default, null):SimpleEvent<WindowSize> = new SimpleEvent();

    public function new(?kc:Key->Void, ?cursorPositionCallback:CursorPosition->Void, ?windowSizeCallback:WindowSize->Void) {
        super(kc, cursorPositionCallback, windowSizeCallback);
    }

    override function handleCursorPosition(cp:CursorPosition) {
        super.handleCursorPosition(cp);

        cursorPositionReceived.trigger(cp);
    }

    override function handleWindowSize(ws:WindowSize) {
        super.handleWindowSize(ws);
        windowSizeReceived.trigger(ws);
    }

    override function handleKeyPress(k:Key) {
        super.handleKeyPress(k);
    }

    public function getCursorPositionPromise():Promise<CursorPosition> {
        return new Promise((res, reject) -> {
            this.cursorPositionReceived.addOnce((position) -> {
                res(position);
            });
            this.getCursorPosition();
        });
    }
}