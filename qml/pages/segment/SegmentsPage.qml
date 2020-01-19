import QtQuick 2.6
import Sailfish.Silica 1.0
import "../../models"
import "../../components"
import "../../components/tabview"
import "../../components/segments"

Page
{
    property int currentSegment: segmentsmodel.tabsSegment
    property Settings settings
    property TabView tabView

    function computeAnchors(){
       if(currentSegment === segmentsmodel.tabsSegment && settings.tabminen ){
         return Theme.itemSizeSmall / (isPortrait ? 1.6 : 1.4);// bottompanel.height /1.6;
       }
       else {
         return 0;
           }
    }

    function loadSegment() {
        if(currentSegment === segmentsmodel.tabsSegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/TabsSegment.qml"));
        else if(currentSegment === segmentsmodel.historySegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/HistorySegment.qml"));
        else if(currentSegment === segmentsmodel.closedTabsSegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/ClosedTabsSegment.qml"));
        else if(currentSegment === segmentsmodel.favoritesSegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/FavoritesSegment.qml"));
        else if(currentSegment === segmentsmodel.downloadsSegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/DownloadsSegment.qml"));
        else if(currentSegment === segmentsmodel.sessionsSegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/SessionsSegment.qml"));
        else if(currentSegment === segmentsmodel.cookieSegment)
            loader.setSource(Qt.resolvedUrl("../../components/segments/CookiesSegment.qml"));
        else
            loader.sourceComponent = null;
    }

    id: segmentspage
    allowedOrientations: defaultAllowedOrientations
    Component.onCompleted: loadSegment()
    onCurrentSegmentChanged: loadSegment()

    SegmentsModel { id: segmentsmodel }

    PopupMessage
    {
        id: popupmessage
        anchors { left: parent.left; top: parent.top; right: parent.right }
    }

    Loader
    {
        id: loader
        asynchronous: true
        visible: status == Loader.Ready
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: bottompanel.top; bottomMargin: computeAnchors() }

        onItemChanged: {
            if(!loader.item)
                return;

            loader.item.load();
        }

    }

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        running: loader.status == Loader.Loading
    }

    BackgroundRectangle
    {
        readonly property real itemWidth: bottompanel.width / 7

        id: bottompanel
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
        height: (segmentspage.isPortrait ? Theme.itemSizeSmall : Theme.itemSizeExtraSmall)// + Theme.paddingSmall

        SilicaListView
        {
            id: lvsections
            anchors { left: parent.left; bottom: selectionrect.bottom; right: parent.right }
            height: bottompanel.height
            clip: true
            orientation: ListView.Horizontal
            currentIndex: segmentspage.currentSegment
            model: segmentsmodel.elements

            delegate: ListItem {
                width: bottompanel.itemWidth
                contentHeight: bottompanel.height

                onClicked: {
                    if(loader.item)
                        loader.item.unload();

                    segmentspage.currentSegment = model.segment;
                }

                Image {
                    id: img
                    source: model.icon
                    width: Theme.iconSizeMedium
                    height: Theme.iconSizeMedium
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                    anchors.centerIn: parent
                }
            }
        }

        Rectangle
        {
            Behavior on x {
                NumberAnimation { duration: lvsections.moving ? 0 : 100; easing.type: Easing.Linear }
            }

            id: selectionrect
            x: lvsections.currentItem ? (lvsections.currentItem.x - lvsections.contentX) : 0
            anchors.bottom: parent.bottom
            height: Theme.paddingSmall
            width: bottompanel.itemWidth
            color: Theme.highlightColor
        }
    }
}
