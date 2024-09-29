package epikowa.terminal;

@:structAccess
@:unreflective
@:include('./CppTerminal.h')
@:native('CppTerminal')
extern class CppTerminal {
	// @:native('new Test')
	// public static function create():cpp.Star<Test>;

	// @:native('Test')
	public static function init():Void;

	@:native('~Test')
	public function delete():Void;
}