package xterm.xterm.xterm;

/**
	An event that can be listened to.
**/
typedef IEvent<T, U> = (listener:(arg1:T, arg2:U) -> Dynamic) -> IDisposable;