package xterm.xterm.xterm;

/**
	An object containing options for the terminal.
**/
typedef ITerminalOptions = {
	/**
		Whether to allow the use of proposed API. When false, any usage of APIs
		marked as experimental/proposed will throw an error. The default is
		false.
	**/
	@:optional
	var allowProposedApi : Bool;
	/**
		Whether background should support non-opaque color. It must be set before
		executing the `Terminal.open()` method and can't be changed later without
		executing it again. Note that enabling this can negatively impact
		performance.
	**/
	@:optional
	var allowTransparency : Bool;
	/**
		If enabled, alt + click will move the prompt cursor to position
		underneath the mouse. The default is true.
	**/
	@:optional
	var altClickMovesCursor : Bool;
	/**
		When enabled the cursor will be set to the beginning of the next line
		with every new line. This is equivalent to sending '\r\n' for each '\n'.
		Normally the termios settings of the underlying PTY deals with the
		translation of '\n' to '\r\n' and this setting should not be used. If you
		deal with data from a non-PTY related source, this settings might be
		useful.
	**/
	@:optional
	var convertEol : Bool;
	/**
		Whether the cursor blinks.
	**/
	@:optional
	var cursorBlink : Bool;
	/**
		The style of the cursor when the terminal is focused.
	**/
	@:optional
	var cursorStyle : String;
	/**
		The width of the cursor in CSS pixels when `cursorStyle` is set to 'bar'.
	**/
	@:optional
	var cursorWidth : Float;
	/**
		The style of the cursor when the terminal is not focused.
	**/
	@:optional
	var cursorInactiveStyle : String;
	/**
		Whether to draw custom glyphs for block element and box drawing
		characters instead of using the font. This should typically result in
		better rendering with continuous lines, even when line height and letter
		spacing is used. Note that this doesn't work with the DOM renderer which
		renders all characters using the font. The default is true.
	**/
	@:optional
	var customGlyphs : Bool;
	/**
		Whether input should be disabled.
	**/
	@:optional
	var disableStdin : Bool;
	/**
		A {@link Document} to use instead of the one that xterm.js was attached
		to. The purpose of this is to improve support in multi-window
		applications where HTML elements may be references across multiple
		windows which can cause problems with `instanceof`.
		
		The type is `any` because using `Document` can cause TS to have
		performance/compiler problems.
	**/
	@:optional
	var documentOverride : Dynamic;
	/**
		Whether to draw bold text in bright colors. The default is true.
	**/
	@:optional
	var drawBoldTextInBrightColors : Bool;
	/**
		The modifier key hold to multiply scroll speed.
	**/
	@:optional
	var fastScrollModifier : String;
	/**
		The scroll speed multiplier used for fast scrolling.
	**/
	@:optional
	var fastScrollSensitivity : Float;
	/**
		The font size used to render text.
	**/
	@:optional
	var fontSize : Float;
	/**
		The font family used to render text.
	**/
	@:optional
	var fontFamily : String;
	/**
		The font weight used to render non-bold text.
	**/
	@:optional
	var fontWeight : FontWeight;
	/**
		The font weight used to render bold text.
	**/
	@:optional
	var fontWeightBold : FontWeight;
	/**
		Whether to ignore the bracketed paste mode. When true, this will always
		paste without the `\x1b[200~` and `\x1b[201~` sequences, even when the
		shell enables bracketed mode.
	**/
	@:optional
	var ignoreBracketedPasteMode : Bool;
	/**
		The spacing in whole pixels between characters.
	**/
	@:optional
	var letterSpacing : Float;
	/**
		The line height used to render text.
	**/
	@:optional
	var lineHeight : Float;
	/**
		The handler for OSC 8 hyperlinks. Links will use the `confirm` browser
		API with a strongly worded warning if no link handler is set.
		
		When setting this, consider the security of users opening these links,
		at a minimum there should be a tooltip or a prompt when hovering or
		activating the link respectively. An example of what might be possible is
		a terminal app writing link in the form `javascript:...` that runs some
		javascript, a safe approach to prevent that is to validate the link
		starts with http(s)://.
	**/
	@:optional
	var linkHandler : ILinkHandler;
	/**
		What log level to use, this will log for all levels below and including
		what is set:
		
		1. trace
		2. debug
		3. info (default)
		4. warn
		5. error
		6. off
	**/
	@:optional
	var logLevel : LogLevel;
	/**
		A logger to use instead of `console`.
	**/
	@:optional
	var logger : ILogger;
	/**
		Whether to treat option as the meta key.
	**/
	@:optional
	var macOptionIsMeta : Bool;
	/**
		Whether holding a modifier key will force normal selection behavior,
		regardless of whether the terminal is in mouse events mode. This will
		also prevent mouse events from being emitted by the terminal. For
		example, this allows you to use xterm.js' regular selection inside tmux
		with mouse mode enabled.
	**/
	@:optional
	var macOptionClickForcesSelection : Bool;
	/**
		The minimum contrast ratio for text in the terminal, setting this will
		change the foreground color dynamically depending on whether the contrast
		ratio is met. Example values:
		
		- 1: The default, do nothing.
		- 4.5: Minimum for WCAG AA compliance.
		- 7: Minimum for WCAG AAA compliance.
		- 21: White on black or black on white.
	**/
	@:optional
	var minimumContrastRatio : Float;
	/**
		Whether to rescale glyphs horizontally that are a single cell wide but
		have glyphs that would overlap following cell(s). This typically happens
		for ambiguous width characters (eg. the roman numeral characters U+2160+)
		which aren't featured in monospace fonts. This is an important feature
		for achieving GB18030 compliance.
		
		The following glyphs will never be rescaled:
		
		- Emoji glyphs
		- Powerline glyphs
		- Nerd font glyphs
		
		Note that this doesn't work with the DOM renderer. The default is false.
	**/
	@:optional
	var rescaleOverlappingGlyphs : Bool;
	/**
		Whether to select the word under the cursor on right click, this is
		standard behavior in a lot of macOS applications.
	**/
	@:optional
	var rightClickSelectsWord : Bool;
	/**
		Whether screen reader support is enabled. When on this will expose
		supporting elements in the DOM to support NVDA on Windows and VoiceOver
		on macOS.
	**/
	@:optional
	var screenReaderMode : Bool;
	/**
		The amount of scrollback in the terminal. Scrollback is the amount of
		rows that are retained when lines are scrolled beyond the initial
		viewport. Defaults to 1000.
	**/
	@:optional
	var scrollback : Float;
	/**
		Whether to scroll to the bottom whenever there is some user input. The
		default is true.
	**/
	@:optional
	var scrollOnUserInput : Bool;
	/**
		The scrolling speed multiplier used for adjusting normal scrolling speed.
	**/
	@:optional
	var scrollSensitivity : Float;
	/**
		The duration to smoothly scroll between the origin and the target in
		milliseconds. Set to 0 to disable smooth scrolling and scroll instantly.
	**/
	@:optional
	var smoothScrollDuration : Float;
	/**
		The size of tab stops in the terminal.
	**/
	@:optional
	var tabStopWidth : Float;
	/**
		The color theme of the terminal.
	**/
	@:optional
	var theme : ITheme;
	/**
		Whether "Windows mode" is enabled. Because Windows backends winpty and
		conpty operate by doing line wrapping on their side, xterm.js does not
		have access to wrapped lines. When Windows mode is enabled the following
		changes will be in effect:
		
		- Reflow is disabled.
		- Lines are assumed to be wrapped if the last character of the line is
		   not whitespace.
		
		When using conpty on Windows 11 version >= 21376, it is recommended to
		disable this because native text wrapping sequences are output correctly
		thanks to https://github.com/microsoft/terminal/issues/405
	**/
	@:optional
	var windowsMode : Bool;
	/**
		Compatibility information when the pty is known to be hosted on Windows.
		Setting this will turn on certain heuristics/workarounds depending on the
		values:
		
		- `if (backend !== undefined || buildNumber !== undefined)`
		   - When increasing the rows in the terminal, the amount increased into
		     the scrollback. This is done because ConPTY does not behave like
		     expect scrollback to come back into the viewport, instead it makes
		     empty rows at of the viewport. Not having this behavior can result in
		     missing data as the rows get replaced.
		- `if !(backend === 'conpty' && buildNumber >= 21376)`
		   - Reflow is disabled
		   - Lines are assumed to be wrapped if the last character of the line is
		     not whitespace.
	**/
	@:optional
	var windowsPty : IWindowsPty;
	/**
		A string containing all characters that are considered word separated by
		the double click to select work logic.
	**/
	@:optional
	var wordSeparator : String;
	/**
		Enable various window manipulation and report features.
		All features are disabled by default for security reasons.
	**/
	@:optional
	var windowOptions : IWindowOptions;
	/**
		The width, in pixels, of the canvas for the overview ruler. The overview
		ruler will be hidden when not set.
	**/
	@:optional
	var overviewRulerWidth : Float;
};