import QtQuick 2.6
import Sailfish.Silica 1.0

Item
{
    QtObject
    {
        property ListModel model: ListModel { }
        property var componentCache: ({ })
        property string originalTabState

        id: stackobject

        function calculateMetrics() {
            if(viewstack.empty || !viewstack.visible)
                return;

            var topitem = top();
            topitem.width = viewstack.width;
            topitem.height = viewstack.height;
        }

        function top() {
            if(!viewstack.empty)
                return model.get(0).item;

            return null;
        }

        function topTabState() {
            if(!viewstack.empty)
                return model.get(0).tabstate;

            return null;
        }

        function push(item, tabstate) {
            item.width = viewstack.width;
            item.height = viewstack.height;

            if(!empty)
                top().visible = false;

            model.insert(0, { "item": item, "tabstate": tabstate });
            viewstack.opacity = 1.0;
        }

        function erase(idx) {
            var item = model.get(idx).item;
            model.remove(idx);

            item.parent = null;
            item.destroy();
        }

        function pop() {
            erase(0);

            if(!empty) {
                stackobject.calculateMetrics();
                stackobject.top().visible = true;
                browsertab.state = stackobject.topTabState();
            }
        }
    }

    readonly property bool empty: stackobject.model.count === 0

    onEmptyChanged: {
        if(!empty && (stackobject.model.count === 1))
            stackobject.originalTabState = browsertab.state;
        else if(empty)
            browsertab.state = stackobject.originalTabState;
    }

    function push(componenturl, tabstate, params) {
        if(tabstate && (browsertab.state === tabstate)) // Tab states are exclusive
            return;

        var component = stackobject.componentCache[componenturl];

        if(!component)
            component = stackobject.componentCache[componenturl] = Qt.createComponent(componenturl);

        if(component.status === Component.Error) {
            console.log(component.errorString());
            return;
        }

        var object = component.createObject(viewstack, params || { });
        stackobject.push(object, tabstate);

        if(tabstate)
            browsertab.state = tabstate;

        return object;
    }

    function clear() {
        while(stackobject.model.count)
            stackobject.erase(0);
    }

    function pop() {
        if(!empty)
            stackobject.pop();

        if(empty)
            opacity = 0.0;
    }

    Behavior on opacity {
        NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
    }

    id: viewstack
    z: 2
    opacity: 0.0
    visible: opacity > 0.0
    onWidthChanged: stackobject.calculateMetrics()
    onHeightChanged: stackobject.calculateMetrics()

    onVisibleChanged: {
        if(visible)
            stackobject.calculateMetrics();
    }
}
