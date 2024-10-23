package xterm.xterm.xterm;

/**
	Allows hooking into the parser for custom handling of escape sequences.
	
	Note on sync vs. async handlers:
	xterm.js implements all parser actions with synchronous handlers.
	In general custom handlers should also operate in sync mode wherever
	possible to keep the parser fast.
	Still the exposed interfaces allow to register async handlers by returning
	a `Promise<boolean>`. Here the parser will pause input processing until
	the promise got resolved or rejected (in-band blocking). This "full stop"
	on the input chain allows to implement backpressure from a certain async
	action while the terminal state will not progress any further from input.
	It does not mean that the terminal state will not change at all in between,
	as user actions like resize or reset are still processed immediately.
	It is an error to assume a stable terminal state while giving back control
	in between, e.g. by multiple chained `then` calls.
	Downside of an async handler is a rather bad throughput performance,
	thus use async handlers only as a last resort or for actions that have
	to rely on async interfaces itself.
**/
typedef IParser = {
	/**
		Adds a handler for CSI escape sequences.
	**/
	function registerCsiHandler(id:IFunctionIdentifier, callback:(params:Array<ts.AnyOf2<Float, Array<Float>>>) -> ts.AnyOf2<Bool, js.lib.Promise<Bool>>):IDisposable;
	/**
		Adds a handler for DCS escape sequences.
	**/
	function registerDcsHandler(id:IFunctionIdentifier, callback:(data:String, param:Array<ts.AnyOf2<Float, Array<Float>>>) -> ts.AnyOf2<Bool, js.lib.Promise<Bool>>):IDisposable;
	/**
		Adds a handler for ESC escape sequences.
	**/
	function registerEscHandler(id:IFunctionIdentifier, handler:() -> ts.AnyOf2<Bool, js.lib.Promise<Bool>>):IDisposable;
	/**
		Adds a handler for OSC escape sequences.
	**/
	function registerOscHandler(ident:Float, callback:(data:String) -> ts.AnyOf2<Bool, js.lib.Promise<Bool>>):IDisposable;
};