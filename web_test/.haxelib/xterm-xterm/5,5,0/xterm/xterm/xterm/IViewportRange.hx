package xterm.xterm.xterm;

/**
	An object representing a range within the viewport of the terminal.
**/
typedef IViewportRange = {
	/**
		The start of the range.
	**/
	var start : IViewportRangePosition;
	/**
		The end of the range.
	**/
	var end : IViewportRangePosition;
};