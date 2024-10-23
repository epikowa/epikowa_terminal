package xterm.xterm.xterm;

/**
	An addon that can provide additional functionality to the terminal.
**/
typedef ITerminalAddon = {
	/**
		This is called when the addon is activated.
	**/
	function activate(terminal:Terminal):Void;
	function dispose():Void;
};