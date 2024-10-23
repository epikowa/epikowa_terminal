package xterm.xterm.xterm;

/**
	A link handler for OSC 8 hyperlinks.
**/
typedef ILinkHandler = {
	/**
		Calls when the link is activated.
	**/
	function activate(event:js.html.MouseEvent, text:String, range:IBufferRange):Void;
	/**
		Called when the mouse hovers the link. To use this to create a DOM-based
		hover tooltip, create the hover element within `Terminal.element` and
		add the `xterm-hover` class to it, that will cause mouse events to not
		fall through and activate other links.
	**/
	@:optional
	function hover(event:js.html.MouseEvent, text:String, range:IBufferRange):Void;
	/**
		Called when the mouse leaves the link.
	**/
	@:optional
	function leave(event:js.html.MouseEvent, text:String, range:IBufferRange):Void;
	/**
		Whether to receive non-HTTP URLs from LinkProvider. When false, any
		usage of non-HTTP URLs will be ignored. Enabling this option without
		proper protection in `activate` function may cause security issues such
		as XSS.
	**/
	@:optional
	var allowNonHttpProtocols : Bool;
};