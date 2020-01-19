import QtQuick 2.6
import Sailfish.Silica 1.0

IconButton
{
    readonly property real factor: 0.26

    id: btnedit
    width: quickgriditem.width * factor
    height: width
    icon { width: btnedit.width * 0.80; height: btnedit.height * 0.80; fillMode: Image.PreserveAspectFit }
    visible: opacity > 0.0

    Behavior on opacity {
        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
    }

    Rectangle
    {
        anchors.fill: parent
        color: Theme.rgba(Theme.secondaryHighlightColor, 1.0)
        radius: btnedit.width * 0.5
        z: -1
    }
}
