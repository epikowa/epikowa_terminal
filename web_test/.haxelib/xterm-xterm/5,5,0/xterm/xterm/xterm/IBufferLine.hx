package xterm.xterm.xterm;

/**
	Represents a line in the terminal's buffer.
**/
typedef IBufferLine = {
	/**
		Whether the line is wrapped from the previous line.
	**/
	final isWrapped : Bool;
	/**
		The length of the line, all call to getCell beyond the length will result
		in `undefined`. Note that this may exceed columns as the line array may
		not be trimmed after a resize, compare against {@link Terminal.cols} to
		get the actual maximum length of a line.
	**/
	final length : Float;
	/**
		Gets a cell from the line, or undefined if the line index does not exist.
		
		Note that the result of this function should be used immediately after
		calling as when the terminal updates it could lead to unexpected
		behavior.
	**/
	function getCell(x:Float, ?cell:IBufferCell):Null<IBufferCell>;
	/**
		Gets the line as a string. Note that this is gets only the string for the
		line, not taking isWrapped into account.
	**/
	function translateToString(?trimRight:Bool, ?startColumn:Float, ?endColumn:Float):String;
};