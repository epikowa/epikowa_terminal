package xterm.xterm.xterm;

/**
	Represents a specific line in the terminal that is tracked when scrollback
	is trimmed and lines are added or removed. This is a single line that may
	be part of a larger wrapped line.
**/
typedef IMarker = {
	/**
		A unique identifier for this marker.
	**/
	final id : Float;
	/**
		The actual line index in the buffer at this point in time. This is set to
		-1 if the marker has been disposed.
	**/
	final line : Float;
	/**
		Event listener to get notified when this gets disposed.
	**/
	dynamic function onDispose(listener:(arg1:ts.Undefined, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Whether this is disposed.
	**/
	final isDisposed : Bool;
	function dispose():Void;
};