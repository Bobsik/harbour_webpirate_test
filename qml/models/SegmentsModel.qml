import QtQuick 2.6
import Sailfish.Silica 1.0

Item
{
    readonly property int tabsSegment: 0
    readonly property int closedTabsSegment: 1
    readonly property int favoritesSegment: 2
    readonly property int downloadsSegment: 3
    readonly property int sessionsSegment: 4
    readonly property int historySegment: 5
    readonly property int cookieSegment: 6

    property list<QtObject> elements: [ QtObject { readonly property int segment: tabsSegment
                                                   readonly property string icon: "image://theme/icon-m-tabs" },

                                        QtObject { readonly property int segment: closedTabsSegment
                                                   readonly property string icon: "image://theme/icon-m-close" },

                                        QtObject { readonly property int segment: favoritesSegment
                                                   readonly property string icon: "image://theme/icon-m-favorite-selected" },

                                        QtObject { readonly property int segment: downloadsSegment
                                                   readonly property string icon: "image://theme/icon-m-cloud-download" },

                                        QtObject { readonly property int segment: sessionsSegment
                                                   readonly property string icon: "image://theme/icon-m-levels" },

                                        QtObject { readonly property int segment: historySegment
                                                   readonly property string icon: "image://theme/icon-m-time-date" },

                                        QtObject { readonly property int segment: cookieSegment
                                                   readonly property string icon: "qrc:///res/cookies.png" } ]
}
