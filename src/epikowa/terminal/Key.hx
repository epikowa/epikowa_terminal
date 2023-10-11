package epikowa.terminal;

enum Key {
    ARROW_UP;
    ARROW_DOWN;
    ARROW_LEFT;
    ARROW_RIGHT;
    HOME;
    ENTER;
    BACKSPACE;
    ESCAPE;
    UNKNOWN_ESCAPED(code:Array<Int>);
    CHAR(char:String);
}