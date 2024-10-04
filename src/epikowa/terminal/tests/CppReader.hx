package epikowa.terminal.tests;

import haxe.io.Bytes;
import cpp.UInt8;
import haxe.io.BytesBuffer;
import sys.thread.Deque;
import sys.thread.EventLoop;
import sys.thread.Thread;

class CppReader {
	public static var readDelay:Int = 5;
	public static var deque = new Deque<{data: UInt8, time:Float}>();

	public static function init(cb:Bytes->Void) {
		var readFromIO = Thread.createWithEventLoop(() -> {
			while (true) {
				var b = Sys.stdin().readInt8();
				deque.add({data: b, time: Sys.time() * 1000});
			};
		});

		var checkEvents = Thread.createWithEventLoop(() -> {
			var list = new haxe.ds.List<{data: UInt8, time:Float}>();

			var dispatchEvent = () -> {
				var s = Bytes.alloc(list.length);
				var length = list.length;
				for (pos in 0...length) {
					s.set(pos, list.pop().data);
				}

				cb(s);
			};
			while (true) {
				var item = deque.pop(false);
				
				if (item != null) {
					list.add(item);
				}
				if (list.last() != null) {
					if (list.last().time + readDelay < Sys.time() * 1000) {
						dispatchEvent();
					}
				}
			}
		});
	}
}
