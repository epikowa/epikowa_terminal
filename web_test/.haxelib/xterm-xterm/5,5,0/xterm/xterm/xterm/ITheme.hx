package xterm.xterm.xterm;

/**
	Contains colors to theme the terminal with.
**/
typedef ITheme = {
	/**
		The default foreground color
	**/
	@:optional
	var foreground : String;
	/**
		The default background color
	**/
	@:optional
	var background : String;
	/**
		The cursor color
	**/
	@:optional
	var cursor : String;
	/**
		The accent color of the cursor (fg color for a block cursor)
	**/
	@:optional
	var cursorAccent : String;
	/**
		The selection background color (can be transparent)
	**/
	@:optional
	var selectionBackground : String;
	/**
		The selection foreground color
	**/
	@:optional
	var selectionForeground : String;
	/**
		The selection background color when the terminal does not have focus (can
		be transparent)
	**/
	@:optional
	var selectionInactiveBackground : String;
	/**
		ANSI black (eg. `\x1b[30m`)
	**/
	@:optional
	var black : String;
	/**
		ANSI red (eg. `\x1b[31m`)
	**/
	@:optional
	var red : String;
	/**
		ANSI green (eg. `\x1b[32m`)
	**/
	@:optional
	var green : String;
	/**
		ANSI yellow (eg. `\x1b[33m`)
	**/
	@:optional
	var yellow : String;
	/**
		ANSI blue (eg. `\x1b[34m`)
	**/
	@:optional
	var blue : String;
	/**
		ANSI magenta (eg. `\x1b[35m`)
	**/
	@:optional
	var magenta : String;
	/**
		ANSI cyan (eg. `\x1b[36m`)
	**/
	@:optional
	var cyan : String;
	/**
		ANSI white (eg. `\x1b[37m`)
	**/
	@:optional
	var white : String;
	/**
		ANSI bright black (eg. `\x1b[1;30m`)
	**/
	@:optional
	var brightBlack : String;
	/**
		ANSI bright red (eg. `\x1b[1;31m`)
	**/
	@:optional
	var brightRed : String;
	/**
		ANSI bright green (eg. `\x1b[1;32m`)
	**/
	@:optional
	var brightGreen : String;
	/**
		ANSI bright yellow (eg. `\x1b[1;33m`)
	**/
	@:optional
	var brightYellow : String;
	/**
		ANSI bright blue (eg. `\x1b[1;34m`)
	**/
	@:optional
	var brightBlue : String;
	/**
		ANSI bright magenta (eg. `\x1b[1;35m`)
	**/
	@:optional
	var brightMagenta : String;
	/**
		ANSI bright cyan (eg. `\x1b[1;36m`)
	**/
	@:optional
	var brightCyan : String;
	/**
		ANSI bright white (eg. `\x1b[1;37m`)
	**/
	@:optional
	var brightWhite : String;
	/**
		ANSI extended colors (16-255)
	**/
	@:optional
	var extendedAnsi : Array<String>;
};