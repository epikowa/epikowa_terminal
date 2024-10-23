package xterm.xterm.xterm;

/**
	An object representing a cell position within the viewport of the terminal.
**/
typedef IViewportRangePosition = {
	/**
		The x position of the cell. This is a 0-based index that refers to the
		space in between columns, not the column itself. Index 0 refers to the
		left side of the viewport, index `Terminal.cols` refers to the right side
		of the viewport. This can be thought of as how a cursor is positioned in
		a text editor.
	**/
	var x : Float;
	/**
		The y position of the cell. This is a 0-based index that refers to a
		specific row.
	**/
	var y : Float;
};