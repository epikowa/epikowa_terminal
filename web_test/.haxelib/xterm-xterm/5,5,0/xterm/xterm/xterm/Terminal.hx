package xterm.xterm.xterm;

/**
	The class that represents an xterm.js terminal.
**/
/*@:jsRequire("@xterm/xterm", "Terminal")*/ @:native('Terminal') extern class Terminal {
	/**
		Creates a new `Terminal` object.
	**/
	function new(?options:ITerminalOptions & ITerminalInitOnlyOptions);
	/**
		The element containing the terminal.
	**/
	final element : Null<js.html.Element>;
	/**
		The textarea that accepts input for the terminal.
	**/
	final textarea : Null<js.html.TextAreaElement>;
	/**
		The number of rows in the terminal's viewport. Use
		`ITerminalOptions.rows` to set this in the constructor and
		`Terminal.resize` for when the terminal exists.
	**/
	final rows : Float;
	/**
		The number of columns in the terminal's viewport. Use
		`ITerminalOptions.cols` to set this in the constructor and
		`Terminal.resize` for when the terminal exists.
	**/
	final cols : Float;
	/**
		Access to the terminal's normal and alt buffer.
	**/
	final buffer : IBufferNamespace;
	/**
		(EXPERIMENTAL) Get all markers registered against the buffer. If the alt
		buffer is active this will always return [].
	**/
	final markers : haxe.ds.ReadOnlyArray<IMarker>;
	/**
		Get the parser interface to register custom escape sequence handlers.
	**/
	final parser : IParser;
	/**
		(EXPERIMENTAL) Get the Unicode handling interface
		to register and switch Unicode version.
	**/
	final unicode : IUnicodeHandling;
	/**
		Gets the terminal modes as set by SM/DECSET.
	**/
	final modes : IModes;
	/**
		Gets or sets the terminal options. This supports setting multiple
		options.
	**/
	var options : ITerminalOptions;
	/**
		Adds an event listener for when the bell is triggered.
	**/
	dynamic function onBell(listener:(arg1:ts.Undefined, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when a binary event fires. This is used to
		enable non UTF-8 conformant binary messages to be sent to the backend.
		Currently this is only used for a certain type of mouse reports that
		happen to be not UTF-8 compatible.
		The event value is a JS string, pass it to the underlying pty as
		binary data, e.g. `pty.write(Buffer.from(data, 'binary'))`.
	**/
	dynamic function onBinary(listener:(arg1:String, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for the cursor moves.
	**/
	dynamic function onCursorMove(listener:(arg1:ts.Undefined, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when a data event fires. This happens for
		example when the user types or pastes into the terminal. The event value
		is whatever `string` results, in a typical setup, this should be passed
		on to the backing pty.
	**/
	dynamic function onData(listener:(arg1:String, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when a key is pressed. The event value
		contains the string that will be sent in the data event as well as the
		DOM event that triggered it.
	**/
	dynamic function onKey(listener:(arg1:{ var key : String; var domEvent : js.html.KeyboardEvent; }, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when a line feed is added.
	**/
	dynamic function onLineFeed(listener:(arg1:ts.Undefined, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when rows are rendered. The event value
		contains the start row and end rows of the rendered area (ranges from `0`
		to `Terminal.rows - 1`).
	**/
	dynamic function onRender(listener:(arg1:{ var start : Float; var end : Float; }, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when data has been parsed by the terminal,
		after {@link write} is called. This event is useful to listen for any
		changes in the buffer.
		
		This fires at most once per frame, after data parsing completes. Note
		that this can fire when there are still writes pending if there is a lot
		of data.
	**/
	dynamic function onWriteParsed(listener:(arg1:ts.Undefined, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when the terminal is resized. The event value
		contains the new size.
	**/
	dynamic function onResize(listener:(arg1:{ var cols : Float; var rows : Float; }, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when a scroll occurs. The event value is the
		new position of the viewport.
	**/
	dynamic function onScroll(listener:(arg1:Float, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when a selection change occurs.
	**/
	dynamic function onSelectionChange(listener:(arg1:ts.Undefined, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Adds an event listener for when an OSC 0 or OSC 2 title change occurs.
		The event value is the new title.
	**/
	dynamic function onTitleChange(listener:(arg1:String, arg2:ts.Undefined) -> Dynamic):IDisposable;
	/**
		Unfocus the terminal.
	**/
	function blur():Void;
	/**
		Focus the terminal.
	**/
	function focus():Void;
	/**
		Input data to application side. The data is treated the same way input
		typed into the terminal would (ie. the {@link onData} event will fire).
	**/
	function input(data:String, ?wasUserInput:Bool):Void;
	/**
		Resizes the terminal. It's best practice to debounce calls to resize,
		this will help ensure that the pty can respond to the resize event
		before another one occurs.
	**/
	function resize(columns:Float, rows:Float):Void;
	/**
		Opens the terminal within an element. This should also be called if the
		xterm.js element ever changes browser window.
	**/
	function open(parent:js.html.Element):Void;
	/**
		Attaches a custom key event handler which is run before keys are
		processed, giving consumers of xterm.js ultimate control as to what keys
		should be processed by the terminal and what keys should not.
	**/
	function attachCustomKeyEventHandler(customKeyEventHandler:(event:js.html.KeyboardEvent) -> Bool):Void;
	/**
		Attaches a custom wheel event handler which is run before keys are
		processed, giving consumers of xterm.js control over whether to proceed
		or cancel terminal wheel events.
	**/
	function attachCustomWheelEventHandler(customWheelEventHandler:(event:js.html.WheelEvent) -> Bool):Void;
	/**
		Registers a link provider, allowing a custom parser to be used to match
		and handle links. Multiple link providers can be used, they will be asked
		in the order in which they are registered.
	**/
	function registerLinkProvider(linkProvider:ILinkProvider):IDisposable;
	/**
		(EXPERIMENTAL) Registers a character joiner, allowing custom sequences of
		characters to be rendered as a single unit. This is useful in particular
		for rendering ligatures and graphemes, among other things.
		
		Each registered character joiner is called with a string of text
		representing a portion of a line in the terminal that can be rendered as
		a single unit. The joiner must return a sorted array, where each entry is
		itself an array of length two, containing the start (inclusive) and end
		(exclusive) index of a substring of the input that should be rendered as
		a single unit. When multiple joiners are provided, the results of each
		are collected. If there are any overlapping substrings between them, they
		are combined into one larger unit that is drawn together.
		
		All character joiners that are registered get called every time a line is
		rendered in the terminal, so it is essential for the handler function to
		run as quickly as possible to avoid slowdowns when rendering. Similarly,
		joiners should strive to return the smallest possible substrings to
		render together, since they aren't drawn as optimally as individual
		characters.
		
		NOTE: character joiners are only used by the canvas renderer.
	**/
	function registerCharacterJoiner(handler:(text:String) -> Array<ts.Tuple2<Float, Float>>):Float;
	/**
		(EXPERIMENTAL) Deregisters the character joiner if one was registered.
		NOTE: character joiners are only used by the canvas renderer.
	**/
	function deregisterCharacterJoiner(joinerId:Float):Void;
	/**
		Adds a marker to the normal buffer and returns it.
	**/
	function registerMarker(?cursorYOffset:Float):IMarker;
	/**
		(EXPERIMENTAL) Adds a decoration to the terminal using
	**/
	function registerDecoration(decorationOptions:IDecorationOptions):Null<IDecoration>;
	/**
		Gets whether the terminal has an active selection.
	**/
	function hasSelection():Bool;
	/**
		Gets the terminal's current selection, this is useful for implementing
		copy behavior outside of xterm.js.
	**/
	function getSelection():String;
	/**
		Gets the selection position or undefined if there is no selection.
	**/
	function getSelectionPosition():Null<IBufferRange>;
	/**
		Clears the current terminal selection.
	**/
	function clearSelection():Void;
	/**
		Selects text within the terminal.
	**/
	function select(column:Float, row:Float, length:Float):Void;
	/**
		Selects all text within the terminal.
	**/
	function selectAll():Void;
	/**
		Selects text in the buffer between 2 lines.
	**/
	function selectLines(start:Float, end:Float):Void;
	function dispose():Void;
	/**
		Scroll the display of the terminal
	**/
	function scrollLines(amount:Float):Void;
	/**
		Scroll the display of the terminal by a number of pages.
	**/
	function scrollPages(pageCount:Float):Void;
	/**
		Scrolls the display of the terminal to the top.
	**/
	function scrollToTop():Void;
	/**
		Scrolls the display of the terminal to the bottom.
	**/
	function scrollToBottom():Void;
	/**
		Scrolls to a line within the buffer.
	**/
	function scrollToLine(line:Float):Void;
	/**
		Clear the entire buffer, making the prompt line the new first line.
	**/
	function clear():Void;
	/**
		Write data to the terminal.
	**/
	function write(data:ts.AnyOf2<String, js.lib.Uint8Array>, ?callback:() -> Void):Void;
	/**
		Writes data to the terminal, followed by a break line character (\n).
	**/
	function writeln(data:ts.AnyOf2<String, js.lib.Uint8Array>, ?callback:() -> Void):Void;
	/**
		Writes text to the terminal, performing the necessary transformations for
		pasted text.
	**/
	function paste(data:String):Void;
	/**
		Tells the renderer to refresh terminal content between two rows
		(inclusive) at the next opportunity.
	**/
	function refresh(start:Float, end:Float):Void;
	/**
		Clears the texture atlas of the canvas renderer if it's active. Doing
		this will force a redraw of all glyphs which can workaround issues
		causing the texture to become corrupt, for example Chromium/Nvidia has an
		issue where the texture gets messed up when resuming the OS from sleep.
	**/
	function clearTextureAtlas():Void;
	/**
		Perform a full reset (RIS, aka '\x1bc').
	**/
	function reset():Void;
	/**
		Loads an addon into this instance of xterm.js.
	**/
	function loadAddon(addon:ITerminalAddon):Void;
	static var prototype : Terminal;
	/**
		Natural language strings that can be localized.
	**/
	static var strings : ILocalizableStrings;
}