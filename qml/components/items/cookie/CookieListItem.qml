import QtQuick 2.6
import Sailfish.Silica 1.0

ListItem
{
    property alias cookieDomain: lbldomain.text
    property alias cookieName: lblcookiename.text

    id: cookielistitem

    menu: ContextMenu {
        MenuItem {
            text: qsTr("Delete")

            onClicked: {
                cookielistitem.remorseAction(qsTr("Deleting Cookie"), function() {
                    settings.cookiejar.deleteCookie(model.modelData);
                    pagecookielist.loadCookies(); // Reload cookies
                });
            }
        }
    }

    Row
    {
        spacing: Theme.paddingMedium
        anchors { fill: parent; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }

        Image
        {
            id: imgcookie
            source: "qrc:///res/cookies.png"
            anchors.verticalCenter: parent.verticalCenter
            width: lblcookiename.contentHeight
            height: lblcookiename.contentHeight
            fillMode: Image.PreserveAspectFit
        }

        Column
        {
            id: colcontainer
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - imgcookie.width
            height: parent.height

            Label
            {
                id: lblcookiename
                width: parent.width
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
            }

            Label
            {
                id: lbldomain
                width: parent.width
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeExtraSmall
                elide: Text.ElideRight
            }
        }
    }
}
