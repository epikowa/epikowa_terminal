package xterm.xterm.xterm;

/**
	(EXPERIMENTAL) Unicode version provider.
	Used to register custom Unicode versions with `Terminal.unicode.register`.
**/
typedef IUnicodeVersionProvider = {
	/**
		String indicating the Unicode version provided.
	**/
	final version : String;
	/**
		Unicode version dependent wcwidth implementation.
	**/
	function wcwidth(codepoint:Float):Int;
	function charProperties(codepoint:Float, preceding:Float):Float;
};