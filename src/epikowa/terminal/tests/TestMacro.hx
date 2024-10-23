package epikowa.terminal.tests;

import haxe.macro.Context;
import haxe.macro.MacroStringTools;
import haxe.xml.Parser;

class TestMacro {
    public static macro function traceMarkup(markup:haxe.macro.Expr) {
        switch (markup.expr) {
            case EMeta({name: ':markup'}, e):
                trace('METAAAAA');
                switch (e.expr) {
                    case EConst(CString(s, kind)):
                        trace('UNE STRING', s);
                        var xml = Parser.parse(s);
                        try {
                            var elementName = xml.firstElement().nodeName;
                            var complexType = Context.resolveComplexType(MacroStringTools.toComplex(elementName), markup.pos);
                        } catch (ex) {
                            Context.fatalError('Type not found', e.pos);
                        }
                        
                        for (attr in xml.firstElement().attributes()) {
                            var interpolated = MacroStringTools.formatString(xml.firstElement().get(attr), Context.currentPos());
                            return macro var $attr = "hello";
                            return interpolated;
                        }
                        return macro $v{s};
                    default:
                }
            default:
        }
        return macro '';
    }
}
