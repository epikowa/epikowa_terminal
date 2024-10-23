package xterm.xterm.xterm;

/**
	Represents a single cell in the terminal's buffer.
**/
typedef IBufferCell = {
	/**
		The width of the character. Some examples:
		
		- `1` for most cells.
		- `2` for wide character like CJK glyphs.
		- `0` for cells immediately following cells with a width of `2`.
	**/
	function getWidth():Float;
	/**
		The character(s) within the cell. Examples of what this can contain:
		
		- A normal width character
		- A wide character (eg. CJK)
		- An emoji
	**/
	function getChars():String;
	/**
		Gets the UTF32 codepoint of single characters, if content is a combined
		string it returns the codepoint of the last character in the string.
	**/
	function getCode():Float;
	/**
		Gets the number representation of the foreground color mode, this can be
		used to perform quick comparisons of 2 cells to see if they're the same.
		Use `isFgRGB`, `isFgPalette` and `isFgDefault` to check what color mode
		a cell is.
	**/
	function getFgColorMode():Float;
	/**
		Gets the number representation of the background color mode, this can be
		used to perform quick comparisons of 2 cells to see if they're the same.
		Use `isBgRGB`, `isBgPalette` and `isBgDefault` to check what color mode
		a cell is.
	**/
	function getBgColorMode():Float;
	/**
		Gets a cell's foreground color number, this differs depending on what the
		color mode of the cell is:
		
		- Default: This should be 0, representing the default foreground color
		   (CSI 39 m).
		- Palette: This is a number from 0 to 255 of ANSI colors (CSI 3(0-7) m,
		   CSI 9(0-7) m, CSI 38 ; 5 ; 0-255 m).
		- RGB: A hex value representing a 'true color': 0xRRGGBB.
		   (CSI 3 8 ; 2 ; Pi ; Pr ; Pg ; Pb)
	**/
	function getFgColor():Float;
	/**
		Gets a cell's background color number, this differs depending on what the
		color mode of the cell is:
		
		- Default: This should be 0, representing the default background color
		   (CSI 49 m).
		- Palette: This is a number from 0 to 255 of ANSI colors
		   (CSI 4(0-7) m, CSI 10(0-7) m, CSI 48 ; 5 ; 0-255 m).
		- RGB: A hex value representing a 'true color': 0xRRGGBB
		   (CSI 4 8 ; 2 ; Pi ; Pr ; Pg ; Pb)
	**/
	function getBgColor():Float;
	/**
		Whether the cell has the bold attribute (CSI 1 m).
	**/
	function isBold():Float;
	/**
		Whether the cell has the italic attribute (CSI 3 m).
	**/
	function isItalic():Float;
	/**
		Whether the cell has the dim attribute (CSI 2 m).
	**/
	function isDim():Float;
	/**
		Whether the cell has the underline attribute (CSI 4 m).
	**/
	function isUnderline():Float;
	/**
		Whether the cell has the blink attribute (CSI 5 m).
	**/
	function isBlink():Float;
	/**
		Whether the cell has the inverse attribute (CSI 7 m).
	**/
	function isInverse():Float;
	/**
		Whether the cell has the invisible attribute (CSI 8 m).
	**/
	function isInvisible():Float;
	/**
		Whether the cell has the strikethrough attribute (CSI 9 m).
	**/
	function isStrikethrough():Float;
	/**
		Whether the cell has the overline attribute (CSI 53 m).
	**/
	function isOverline():Float;
	/**
		Whether the cell is using the RGB foreground color mode.
	**/
	function isFgRGB():Bool;
	/**
		Whether the cell is using the RGB background color mode.
	**/
	function isBgRGB():Bool;
	/**
		Whether the cell is using the palette foreground color mode.
	**/
	function isFgPalette():Bool;
	/**
		Whether the cell is using the palette background color mode.
	**/
	function isBgPalette():Bool;
	/**
		Whether the cell is using the default foreground color mode.
	**/
	function isFgDefault():Bool;
	/**
		Whether the cell is using the default background color mode.
	**/
	function isBgDefault():Bool;
	/**
		Whether the cell has the default attribute (no color or style).
	**/
	function isAttributeDefault():Bool;
};