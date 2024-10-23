package xterm.xterm.xterm;

/**
	A range within a buffer.
**/
typedef IBufferRange = {
	/**
		The start position of the range.
	**/
	var start : IBufferCellPosition;
	/**
		The end position of the range.
	**/
	var end : IBufferCellPosition;
};