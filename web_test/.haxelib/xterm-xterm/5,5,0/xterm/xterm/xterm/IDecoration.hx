package xterm.xterm.xterm;

/**
	Represents a decoration in the terminal that is associated with a
	particular marker and DOM element.
**/
typedef IDecoration = {
	final marker : IMarker;
	/**
		An event fired when the decoration
		is rendered, returns the dom element
		associated with the decoration.
	**/
	function onRender(listener:(arg1:js.html.Element, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		The element that the decoration is rendered to. This will be undefined
		until it is rendered for the first time by {@link IDecoration.onRender}.
		that.
	**/
	var element : Null<js.html.Element>;
	/**
		The options for the overview ruler that can be updated. This will only
		take effect when {@link IDecorationOptions.overviewRulerOptions} were
		provided initially.
	**/
	var options : {
		/**
			When defined, renders the decoration in the overview ruler to the right
			of the terminal. {@link ITerminalOptions.overviewRulerWidth} must be set
			in order to see the overview ruler.
		**/
		@:optional
		var overviewRulerOptions : IDecorationOverviewRulerOptions;
	};
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