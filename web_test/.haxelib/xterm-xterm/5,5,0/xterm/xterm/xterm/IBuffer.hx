package xterm.xterm.xterm;

/**
	Represents a terminal buffer.
**/
typedef IBuffer = {
	/**
		The type of the buffer.
	**/
	final type : String;
	/**
		The y position of the cursor. This ranges between `0` (when the
		cursor is at baseY) and `Terminal.rows - 1` (when the cursor is on the
		last row).
	**/
	final cursorY : Float;
	/**
		The x position of the cursor. This ranges between `0` (left side) and
		`Terminal.cols` (after last cell of the row).
	**/
	final cursorX : Float;
	/**
		The line within the buffer where the top of the viewport is.
	**/
	final viewportY : Float;
	/**
		The line within the buffer where the top of the bottom page is (when
		fully scrolled down).
	**/
	final baseY : Float;
	/**
		The amount of lines in the buffer.
	**/
	final length : Float;
	/**
		Gets a line from the buffer, or undefined if the line index does not
		exist.
		
		Note that the result of this function should be used immediately after
		calling as when the terminal updates it could lead to unexpected
		behavior.
	**/
	function getLine(y:Float):Null<IBufferLine>;
	/**
		Creates an empty cell object suitable as a cell reference in
		`line.getCell(x, cell)`. Use this to avoid costly recreation of
		cell objects when dealing with tons of cells.
	**/
	function getNullCell():IBufferCell;
};