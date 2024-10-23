package xterm.xterm.xterm;

typedef IBufferElementProvider = {
	/**
		Provides a document fragment or HTMLElement containing the buffer
		elements.
	**/
	function provideBufferElements():ts.AnyOf2<js.html.Element, js.html.DocumentFragment>;
};