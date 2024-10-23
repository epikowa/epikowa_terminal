package xterm.xterm.xterm;

/**
	Terminal modes as set by SM/DECSET.
**/
typedef IModes = {
	/**
		Application Cursor Keys (DECCKM): `CSI ? 1 h`
	**/
	final applicationCursorKeysMode : Bool;
	/**
		Application Keypad Mode (DECNKM): `CSI ? 6 6 h`
	**/
	final applicationKeypadMode : Bool;
	/**
		Bracketed Paste Mode: `CSI ? 2 0 0 4 h`
	**/
	final bracketedPasteMode : Bool;
	/**
		Insert Mode (IRM): `CSI 4 h`
	**/
	final insertMode : Bool;
	/**
		Mouse Tracking, this can be one of the following:
		- none: This is the default value and can be reset with DECRST
		- x10: Send Mouse X & Y on button press `CSI ? 9 h`
		- vt200: Send Mouse X & Y on button press and release `CSI ? 1 0 0 0 h`
		- drag: Use Cell Motion Mouse Tracking `CSI ? 1 0 0 2 h`
		- any: Use All Motion Mouse Tracking `CSI ? 1 0 0 3 h`
	**/
	final mouseTrackingMode : String;
	/**
		Origin Mode (DECOM): `CSI ? 6 h`
	**/
	final originMode : Bool;
	/**
		Reverse-wraparound Mode: `CSI ? 4 5 h`
	**/
	final reverseWraparoundMode : Bool;
	/**
		Send FocusIn/FocusOut events: `CSI ? 1 0 0 4 h`
	**/
	final sendFocusMode : Bool;
	/**
		Auto-Wrap Mode (DECAWM): `CSI ? 7 h`
	**/
	final wraparoundMode : Bool;
};