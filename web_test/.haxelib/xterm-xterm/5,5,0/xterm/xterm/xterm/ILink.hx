package xterm.xterm.xterm;

/**
	A link within the terminal.
**/
typedef ILink = {
	/**
		The buffer range of the link.
	**/
	var range : IBufferRange;
	/**
		The text of the link.
	**/
	var text : String;
	/**
		What link decorations to show when hovering the link, this property is
		tracked and changes made after the link is provided will trigger changes.
		If not set, all decroations will be enabled.
	**/
	@:optional
	var decorations : ILinkDecorations;
	/**
		Calls when the link is activated.
	**/
	function activate(event:js.html.MouseEvent, text:String):Void;
	/**
		Called when the mouse hovers the link. To use this to create a DOM-based
		hover tooltip, create the hover element within `Terminal.element` and add
		the `xterm-hover` class to it, that will cause mouse events to not fall
		through and activate other links.
	**/
	@:optional
	function hover(event:js.html.MouseEvent, text:String):Void;
	/**
		Called when the mouse leaves the link.
	**/
	@:optional
	function leave(event:js.html.MouseEvent, text:String):Void;
	/**
		Called when the link is released and no longer used by xterm.js.
	**/
	@:optional
	function dispose():Void;
};