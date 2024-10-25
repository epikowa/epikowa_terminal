package epikowa.terminal;

class Streams {
    public static var slave:Dynamic;

    #if (js && !hxnodejs)
    public static var xterm:xterm.xterm.xterm.Terminal;
    #end

    public static function writeString(str:String):Void {
        #if (js && !hxnodejs)
        slave.write(str);
        #else
        Sys.stdout().writeString(str);
        #end
    }

    public static function flush():Void {
        #if (js && !hxnodejs)
        #else
        Sys.stdout().flush();
        #end
    }

    public static function print(str:String):Void {
        #if (js && !hxnodejs)
        slave.write(str);
        #else
        Sys.print(str);
        #end
    }
}