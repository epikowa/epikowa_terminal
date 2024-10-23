package xterm.xterm.xterm;

/**
	A replacement logger for `console`.
**/
typedef ILogger = {
	/**
		Log a trace message, this will only be called if
		{@link ITerminalOptions.logLevel} is set to trace.
	**/
	function trace(message:String, args:haxe.extern.Rest<Dynamic>):Void;
	/**
		Log a debug message, this will only be called if
		{@link ITerminalOptions.logLevel} is set to debug or below.
	**/
	function debug(message:String, args:haxe.extern.Rest<Dynamic>):Void;
	/**
		Log a debug message, this will only be called if
		{@link ITerminalOptions.logLevel} is set to info or below.
	**/
	function info(message:String, args:haxe.extern.Rest<Dynamic>):Void;
	/**
		Log a debug message, this will only be called if
		{@link ITerminalOptions.logLevel} is set to warn or below.
	**/
	function warn(message:String, args:haxe.extern.Rest<Dynamic>):Void;
	/**
		Log a debug message, this will only be called if
		{@link ITerminalOptions.logLevel} is set to error or below.
	**/
	function error(message:ts.AnyOf2<String, js.lib.Error>, args:haxe.extern.Rest<Dynamic>):Void;
};