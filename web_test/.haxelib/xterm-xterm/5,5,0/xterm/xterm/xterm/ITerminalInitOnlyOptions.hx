package xterm.xterm.xterm;

/**
	An object containing additional options for the terminal that can only be
	set on start up.
**/
typedef ITerminalInitOnlyOptions = {
	/**
		The number of columns in the terminal.
	**/
	@:optional
	var cols : Float;
	/**
		The number of rows in the terminal.
	**/
	@:optional
	var rows : Float;
};