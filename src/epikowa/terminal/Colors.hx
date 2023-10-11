package epikowa.terminal;

/*
Black	30	40
Red	31	41
Green	32	42
Yellow	33	43
Blue	34	44
Magenta	35	45
Cyan	36	46
White	37	47
Default	39	49
Reset	0	0
*/
enum abstract Foreground16BitColors(Int) {
  var Black = 30;
  var Red = 31;
  var Green = 32;
  var Yellow = 33;
  var Blue = 34;
  var Magenta = 35;
  var Cyan = 36;
  var White = 37;
  var Default = 39;
  var Reset = 0;
}

enum abstract Background16BitColors(Int) {
  var Black = 40;
  var Red = 41;
  var Green = 42;
  var Yellow = 43;
  var Blue = 44;
  var Magenta = 45;
  var Cyan = 46;
  var White = 47;
  var Default = 49;
  var Reset = 0;
}

typedef AnyTrueColor = {
  r:Int,
  g:Int,
  b:Int
};

enum TrueColor {
  Foreground(color:AnyTrueColor);
  Background(color:AnyTrueColor);
}