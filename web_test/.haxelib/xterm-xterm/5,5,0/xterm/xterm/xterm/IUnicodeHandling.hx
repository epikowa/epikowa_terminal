package xterm.xterm.xterm;

/**
	(EXPERIMENTAL) Unicode handling interface.
**/
typedef IUnicodeHandling = {
	/**
		Register a custom Unicode version provider.
	**/
	function register(provider:IUnicodeVersionProvider):Void;
	/**
		Registered Unicode versions.
	**/
	final versions : haxe.ds.ReadOnlyArray<String>;
	/**
		Getter/setter for active Unicode version.
	**/
	var activeVersion : String;
};