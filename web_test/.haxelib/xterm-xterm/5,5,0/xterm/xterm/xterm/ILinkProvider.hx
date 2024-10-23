package xterm.xterm.xterm;

/**
	A custom link provider.
**/
typedef ILinkProvider = {
	/**
		Provides a link a buffer position
	**/
	function provideLinks(bufferLineNumber:Float, callback:(links:Null<Array<ILink>>) -> Void):Void;
};