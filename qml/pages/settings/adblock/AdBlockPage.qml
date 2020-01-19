import QtQuick 2.6
import Sailfish.Silica 1.0
import harbour.webpirate.AdBlock 1.0
import "../../../models"

Dialog
{
    property Settings settings
    property var adblockreader

    function editRule(index) {
        pageStack.push(Qt.resolvedUrl("AdBlockFilter.qml"), { "index": index, "adblockeditor": adblockeditor });
    }

    id: adblockpage
    allowedOrientations: defaultAllowedOrientations
    acceptDestinationAction: PageStackAction.Pop
    onAccepted: adblockeditor.saveFilters()

    AdBlockEditor
    {
        id: adblockeditor
        manager: settings.adblockmanager
        Component.onCompleted: adblockeditor.loadFilters()
    }

    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("Update Filters")

                onClicked: {
                    var page = pageStack.push(Qt.resolvedUrl("AdBlockDownloaderPage.qml"), { "settings": settings });
                    page.rulesDownloaded.connect(function() {
                        adblockeditor.reload();
                    });
                }
            }

            MenuItem
            {
                text: qsTr("Add Filter")
                onClicked: pageStack.push(Qt.resolvedUrl("AdBlockFilter.qml"), { "adblockeditor": adblockeditor });
            }

            MenuItem
            {
                text: settings.adblockmanager.enabled ? qsTr("Disable AdBlock") : qsTr("Enable AdBlock")

                onClicked: {
                    settings.adblockmanager.enabled = !settings.adblockmanager.enabled;
                }
            }
        }

        DialogHeader
        {
            id: dlgheader;
            acceptText: qsTr("Save")
        }

        SilicaListView
        {
            id: listview
            anchors { left: parent.left; top: dlgheader.bottom; right: parent.right; bottom: parent.bottom }
            model: adblockeditor.filtersCount

            delegate: ListItem {
                id: listitem
                contentWidth: parent.width
                contentHeight: Theme.itemSizeSmall
                onClicked: editRule(index)

                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Edit")
                        onClicked: editRule(index)
                    }

                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: listitem.remorseAction(qsTr("Deleting filter"),
                                                          function() {
                                                              adblockeditor.deleteFilter(index);
                                                          });
                    }
                }

                Label
                {
                    anchors { fill: parent; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                    verticalAlignment: Text.AlignVCenter
                    text: adblockeditor.filter(index)
                }
            }
        }
    }
}
