package xterm.xterm.xterm;

/**
	Pty information for Windows.
**/
typedef IWindowsPty = {
	/**
		What pty emulation backend is being used.
	**/
	@:optional
	var backend : String;
	/**
		The Windows build version (eg. 19045)
	**/
	@:optional
	var buildNumber : Float;
};