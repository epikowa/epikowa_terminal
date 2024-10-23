package xterm.xterm.xterm;

/**
	The set of localizable strings.
**/
typedef ILocalizableStrings = {
	/**
		The aria label for the underlying input textarea for the terminal.
	**/
	var promptLabel : String;
	/**
		Announcement for when line reading is suppressed due to too many lines
		being printed to the terminal when `screenReaderMode` is enabled.
	**/
	var tooMuchOutput : String;
};