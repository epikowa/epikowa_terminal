package xterm.xterm.xterm;

typedef IDecorationOptions = {
	/**
		The line in the terminal where
		the decoration will be displayed
	**/
	final marker : IMarker;
	@:optional
	final anchor : String;
	/**
		The x position offset relative to the anchor
	**/
	@:optional
	final x : Float;
	/**
		The width of the decoration in cells, defaults to 1.
	**/
	@:optional
	final width : Float;
	/**
		The height of the decoration in cells, defaults to 1.
	**/
	@:optional
	final height : Float;
	/**
		The background color of the cell(s). When 2 decorations both set the
		foreground color the last registered decoration will be used. Only the
		`#RRGGBB` format is supported.
	**/
	@:optional
	final backgroundColor : String;
	/**
		The foreground color of the cell(s). When 2 decorations both set the
		foreground color the last registered decoration will be used. Only the
		`#RRGGBB` format is supported.
	**/
	@:optional
	final foregroundColor : String;
	/**
		What layer to render the decoration at when {@link backgroundColor} or
		{@link foregroundColor} are used. `'bottom'` will render under the
		selection, `'top`' will render above the selection\*.
		
		*\* The selection will render on top regardless of layer on the canvas
		renderer due to how it renders selection separately.*
	**/
	@:optional
	final layer : String;
	/**
		When defined, renders the decoration in the overview ruler to the right
		of the terminal. {@link ITerminalOptions.overviewRulerWidth} must be set
		in order to see the overview ruler.
	**/
	@:optional
	var overviewRulerOptions : IDecorationOverviewRulerOptions;
};