package epikowa.events;

@:nullSafety(Strict)
class SimpleEvent<EventDataType:Any> {
    var listeners:Array<{handler: EventDataType->Void, count:Float}> = new Array();

    private function addListener(listener:EventDataType->Void, count:Float) {
        listeners.push({
            handler: listener,
            count: count
        });
    }

    public function new() {
        
    }

    public function add(listener:EventDataType->Void) {
        addListener(listener, Math.POSITIVE_INFINITY);
    }
    
    public function addOnce(listener:EventDataType->Void) {
        addListener(listener, 1);
    }

    public function remove(listener:EventDataType->Void) {
        for (currentListener in listeners) {
            if (Reflect.compareMethods(listener, currentListener.handler)) {
                listeners.remove(currentListener);
                break;
            }
        }
    }

    public function trigger(data:EventDataType) {
        for (currentListener in listeners) {
            currentListener.handler(data);

            currentListener.count--;
            if (currentListener.count <= 0) {
                listeners.remove(currentListener);
            }
        }
    }
}