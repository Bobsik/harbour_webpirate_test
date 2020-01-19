import QtQuick 2.6
import Sailfish.Silica 1.0

ListItem
{
    property int count: 0
    property alias icon: imgfavicon.source
    property alias domain: lbldomain.text

    id: domainlistitem

    menu: ContextMenu {
        MenuItem {
            text: qsTr("Delete")

            onClicked: {
                domainlistitem.remorseAction(qsTr("Deleting Cookies"), function() {
                    settings.cookiejar.deleteCookiesFrom(domain);
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
            id: imgfavicon
            anchors.verticalCenter: parent.verticalCenter
            width: lbldomain.contentHeight
            height: lbldomain.contentHeight
            fillMode: Image.PreserveAspectFit
        }

        Column
        {
            id: colcontainer
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - imgfavicon.width
            height: parent.height

            Label
            {
                id: lbldomain
                width: parent.width
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideRight
            }

            Label
            {
                id: lblcount
                width: parent.width
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeExtraSmall
                elide: Text.ElideRight
                text: qsTr("Cookies:") + " " + count
            }
        }
    }
}
