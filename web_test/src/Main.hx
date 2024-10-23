import js.Syntax;
import js.Browser;
import xterm.xterm.xterm.Terminal;

class Main {
    public static function main() {
        trace('Hello');
        var terminal = new Terminal();
        terminal.open(Browser.document.getElementById('terminal'));
        var pty = openpty();
        terminal.loadAddon(pty.master);
    }

    static function openpty():Dynamic {
        return Syntax.code('openpty()');
    }
}