package xterm.xterm.xterm;

/**
	A position within a buffer.
**/
typedef IBufferCellPosition = {
	/**
		The x position within the buffer (1-based).
	**/
	var x : Float;
	/**
		The y position within the buffer (1-based).
	**/
	var y : Float;
};