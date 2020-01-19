import QtQuick 2.6
import Sailfish.Silica 1.0
import "../../models/navigationbar"

ImageButton
{
    property CustomActionsModel customActions
    property bool forceHidden: false
    property var browserTab
    property int pressCustomAction: 0
    property int longPressCustomAction: 0

    signal feedbackRequested()

    readonly property int displayAction: {
        if(!timer.running && actionbutton.pressed && (longPressCustomAction > 0))
            return longPressCustomAction;

        return pressCustomAction;
    }

    id: actionbutton
    source: pressCustomAction > 0 ? customActions.actionmodel[displayAction].icon : ""
    onPressed: timer.start()

    visible: {
        if(forceHidden)
            return false;

        if((actionbutton.pressCustomAction <= 0) || !actionbutton.browserTab || !customActions)
            return false;

        if(customActions.actionmodel[pressCustomAction].webViewOnly && (!browserTab.viewStack.empty || (browserTab.state !== "webview")))
            return false;

        return true;
    }

    onReleased: {
        customActions.execute(displayAction);
        timer.stop();
    }

    Timer
    {
        id: timer
        interval: 800
        running: actionbutton.pressed
        onTriggered: feedbackRequested()
    }
}
