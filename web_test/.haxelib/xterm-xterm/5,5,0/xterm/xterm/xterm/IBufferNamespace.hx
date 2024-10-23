package xterm.xterm.xterm;

/**
	Represents the terminal's set of buffers.
**/
typedef IBufferNamespace = {
	/**
		The active buffer, this will either be the normal or alternate buffers.
	**/
	final active : IBuffer;
	/**
		The normal buffer.
	**/
	final normal : IBuffer;
	/**
		The alternate buffer, this becomes the active buffer when an application
		enters this mode via DECSET (`CSI ? 4 7 h`)
	**/
	final alternate : IBuffer;
	/**
		Adds an event listener for when the active buffer changes.
	**/
	dynamic function onBufferChange(listener:(arg1:IBuffer, arg2:ts.Undefined) -> Dynamic):IDisposable;
};