package epikowa.terminal;

import sys.io.File;
import haxe.crypto.Base64;

class KittyGraphics {
    public static function transmitPNG(uri:String, identifier:Int) {
        if (identifier < 1) {
            throw 'Identifier must be > 0';
        }
        var b64 = Base64.encode(File.getBytes(uri));
        var pos = 0;
        final chunkLength = 4096;
        // trace('badaboum');
        while (pos < b64.length) {
            Sys.stdout().writeString('${Terminal.ESC}_G');
            var chunk = b64.substr(pos, chunkLength);
            if(pos == 0) {
                Sys.stdout().writeString('f=100,i=${identifier},');
            }
            pos = pos + chunkLength;
            if(pos < b64.length) {
                Sys.stdout().writeString('m=1');
            } else {
                Sys.stdout().writeString('m=0');
            }
            Sys.stdout().writeString(';${chunk}');
            Sys.stdout().writeString('${Terminal.ESC}\\');

            // trace('chunk');
        }
        // trace('polop');
        Sys.stdout().flush();
    }

    public static function placeImage(identifier:Int) {
        Sys.print('${Terminal.ESC}_Ga=p,i=${identifier}${Terminal.ESC}\\');
    }
}