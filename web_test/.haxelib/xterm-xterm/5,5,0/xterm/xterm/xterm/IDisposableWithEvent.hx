package xterm.xterm.xterm;

/**
	Represents a disposable that tracks is disposed state.
**/
typedef IDisposableWithEvent = {
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