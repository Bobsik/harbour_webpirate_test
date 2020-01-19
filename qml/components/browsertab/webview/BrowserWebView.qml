import QtQuick 2.6
import QtWebKit 3.0
import Sailfish.Silica 1.0
import "selector"
import "../../tabview/navigationbar"
import "../../../js/UrlHelper.js" as UrlHelper
import "../../../js/settings/Database.js" as Database
import "../../../js/settings/Credentials.js" as Credentials
import "../../../js/settings/History.js" as History
import "../../../js/settings/UserAgents.js" as UserAgents
import "../../../js/settings/Favorites.js" as Favorites

SilicaWebView
{
    property alias textSelector: selector
    property int itemSelectorIndex: -1           // Keeps the selected index of ItemSelector
    property bool readerModeEnabled: false       // Check if Reader Mode is active
    property bool nightModeEnabled: false        // Check if Night Mode is visually active
    property bool ambienceBrowsingEnabled: false // Check if Ambience Browsing is visually active
    property bool favorite: false

    function postMessage(message, data) {
        experimental.postMessage(JSON.stringify({ "type": message, "data": data }));
    }

    function initTheme() {
        var theme = { "primaryColor": Theme.rgba(Theme.primaryColor, 1.0).toString(),
                      "secondaryColor": Theme.rgba(Theme.secondaryColor, 1.0).toString(),
                      "highlightColor": Theme.rgba(Theme.highlightColor, 1.0).toString(),
                      "secondaryHighlightColor": Theme.rgba(Theme.secondaryHighlightColor, 1.0).toString(),
                      "highlightDimmerColor": Theme.rgba(Theme.highlightDimmerColor, 1.0).toString() };

        webview.postMessage("theme_set", { "theme": theme });
    }

    function setNightMode(nightmode) {
        if(browsertab.state !== "webview")
            return;

        webview.postMessage(nightmode ? "nightmodehandler_enable" : "nightmodehandler_disable");
    }

    function calculateMetrics(ignorewidth, ignoreheight) {
        if(!webview.visible)
            return;

        if(!ignorewidth)
            webview.width = tabView.width;

        if(!ignoreheight)
            webview.height = tabView.height;

        browsertab.thumbUpdated = !ignorewidth || !ignoreheight;
    }

    function switchReaderMode() {
        webview.postMessage(readerModeEnabled ? "readermodehandler_disable" : "readermodehandler_enable");
        readerModeEnabled = !readerModeEnabled;
    }

    function hideSelectors() { selector.hide(); }

    function menu(){
        if (settings.browsemenu == 0){tabView.miniMenu.evaporate(); return pulldown;}
        if (settings.browsemenu == 1){tabView.miniMenu.evaporate(); return pushup;}
        if (settings.browsemenu == 2){tabView.miniMenu.solidify();  return null;}
    }

    VerticalScrollDecorator { id: vscrolldecorator; flickable: webview }
    UrlSchemeDelegateHandler { id: urlschemedelegatehandler }
    WebViewListener { id: listener }

    WebViewSelector
    {
        id: selector
        anchors.fill: parent
        webView: webview

        onSelectingChanged: {
            tabView.navigationBar.clipboardMode = selector.selecting;
        }
    }

    Connections
    {
        target: tabView

        onWidthChanged: calculateMetrics(false, true)
        onHeightChanged: calculateMetrics(true, false)
        onStopLoad: stop();
        onRefresh: reload();
        onFavorites: {
            if(webview.favorite) {
                Favorites.removeFromUrl(browsertab.webUrl);
                webview.favorite = false;
                return;
            }

            Favorites.addUrl(browsertab.title, browsertab.webUrl, 0);
            webview.favorite = true;
        }
    }
    Loader{
        sourceComponent: menu()
    }
    Component{
        id: pulldown
        PullDownMenu
        {
        enabled: webview.visible

        onActiveChanged: {
            if(!active)
                return;

            tabView.navigationBar.solidify();
            tabView.miniMenu.solidify();
        }

        MenuItem
        {
            text: qsTr("Settings")
            onClicked: pageStack.push(Qt.resolvedUrl("../../../pages/settings/SettingsPage.qml"), { "settings": settings })
        }
        MenuItem
        {
            text: webview.favorite ? qsTr("Remove from Favorites") : qsTr("Add to Favorites")
            visible: !webview.loading

            onClicked: {
                if(webview.favorite) {
                    Favorites.removeFromUrl(browsertab.webUrl);
                    webview.favorite = false;
                    return;
                }

                Favorites.addUrl(browsertab.title, browsertab.webUrl, 0);
                webview.favorite = true;
            }
        }

        MenuItem
        {
            text: webview.loading ? qsTr("Stop") : qsTr("Refresh")
            onClicked: webview.loading ? webview.stop() : webview.reload()
        }

        MenuItem
        {
            text: qsTr("New tab")
            onClicked: tabView.addTab(mainwindow.settings.homepage)
        }
      }
    }
    Component{
        id: pushup
        PushUpMenu
        {
        enabled: webview.visible

        onActiveChanged: {
            if(!active)
                return;

            tabView.navigationBar.solidify();
            tabView.miniMenu.solidify();
        }

        MenuItem
        {
            text: qsTr("New tab")
            onClicked: tabView.addTab(mainwindow.settings.homepage)
        }

        MenuItem
        {
            text: webview.loading ? qsTr("Stop") : qsTr("Refresh")
            onClicked: webview.loading ? webview.stop() : webview.reload()
        }

        MenuItem
        {
            text: webview.favorite ? qsTr("Remove from Favorites") : qsTr("Add to Favorites")
            visible: !webview.loading

            onClicked: {
                if(webview.favorite) {
                    Favorites.removeFromUrl(browsertab.webUrl);
                    webview.favorite = false;
                    return;
                }

                Favorites.addUrl(browsertab.title, browsertab.webUrl, 0);
                webview.favorite = true;
            }
        }

        MenuItem
        {
            text: qsTr("Settings")
            onClicked: pageStack.push(Qt.resolvedUrl("../../../pages/settings/SettingsPage.qml"), { "settings": settings })
        }
      }
    }

    Rectangle /* Night Mode/Ambience Browsing Rectangle */
    {
        readonly property bool needsRectangle: (settings.nightmode && !webview.nightModeEnabled) || (settings.exp_ambiencebrowsing && !webview.ambienceBrowsingEnabled)

        x: contentX
        y: needsRectangle ? contentY : (webview.contentHeight - 1)

        width:{
            if(needsRectangle)
                return webview.width;

            return Math.max(webview.contentWidth, webview._page.width);
        }

        height:{
            if(needsRectangle)
                return webview.height;

            return Math.max(webview.contentHeight, webview._page.height);
        }

        color: settings.nightmode ? "#181818" : Theme.rgba(Theme.highlightDimmerColor, 1.0) /* Do not use 100% black */
        visible: settings.nightmode || settings.exp_ambiencebrowsing
    }

    id: webview
    property bool firstrunquickgrid: false;
    interactive: !selector.moving
    overridePageStackNavigation: true
    onVisibleChanged: calculateMetrics(false, false)

    /* Experimental WebView Features */
    experimental.preferences.webGLEnabled: true
    experimental.preferences.notificationsEnabled: true
    experimental.preferences.dnsPrefetchEnabled: true
    experimental.preferences.javascriptEnabled: true
    experimental.preferences.localStorageEnabled: true
    experimental.preferences.navigatorQtObjectEnabled: true
    experimental.preferredMinimumContentsWidth: 980 /* "magic" number that proved to work great on the majority of websites */
    experimental.transparentBackground: settings.exp_ambiencebrowsing
    experimental.userAgent: UserAgents.get(mainwindow.settings.useragent).value
    experimental.userStyleSheets: mainwindow.settings.adblockmanager.rulesFile
    experimental.test.onContentsScaleCommitted: webview.postMessage("textselectorhandler_setscale", { "scale": experimental.test.contentsScale })

    experimental.userScripts: [ // Overrides
                                Qt.resolvedUrl("../../../js/webview/overrides/ObjectOverrider.js"),
                                Qt.resolvedUrl("../../../js/webview/overrides/TagOverrider.js"),
                                Qt.resolvedUrl("../../../js/webview/overrides/AjaxOverrider.js"),
                                Qt.resolvedUrl("../../../js/webview/overrides/NotificationOverrider.js"),

                                // Polyfills
                                Qt.resolvedUrl("../../../js/webview/3rdparty/es6-collections.min.js"), // ES6 Harmony Collections: https://github.com/WebReflection/es6-collections
                                Qt.resolvedUrl("../../../js/webview/3rdparty/canvg.min.js"),           // SVG Support: https://github.com/gabelerner/canvg
                                Qt.resolvedUrl("../../../js/webview/3rdparty/readability.min.js"),     // Firefox's Reader Mode

                                // WebPirate SDK
                                Qt.resolvedUrl("../../../js/webview/lib/WebPirate.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/Utils.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/PixelRatioHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/Theme.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/NightModeHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/ReaderModeHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/TextSelectorHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/TouchHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/SubmitHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/StyleHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/TextFieldHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/MessageListener.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/grabber/GrabberBuilder.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/grabber/YouTubeHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/grabber/DailyMotionHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/grabber/VimeoHandler.js"),
                                Qt.resolvedUrl("../../../js/webview/lib/Init.js") ]

    experimental.onTextFound: {
        tabView.navigationBar.queryBar.findError = (matchCount <= 0);
    }

    experimental.certificateVerificationDialog: Item {
        Component.onCompleted: {
            tabView.dialogs.showRequest(model, qsTr("Accept Certificate from: %1 ?").arg(webview.url));
        }
    }

    experimental.alertDialog: Item {
        Component.onCompleted: {
            tabView.dialogs.showAlert(model);
        }
    }

    experimental.confirmDialog: Item {
        Component.onCompleted: {
            tabView.dialogs.showRequest(model, message);
        }
    }

    experimental.filePicker: Item { /* FilePicker is particular: A dedicated page suits better */
        Component.onCompleted: {
            if(pageStack.busy)
                pageStack.completeAnimation();

            var page = pageStack.push(Qt.resolvedUrl("../../../pages/selector/SelectorFilesPage.qml"));

            page.actionCompleted.connect(function(action, data) {
                model.accept(data.toString().substring(7)); // Strip "file://"
            });

            page.rejected.connect(function() {
                model.reject();
            });
        }
    }

    experimental.promptDialog: Item { /* PromptDialog is particular: A dedicated page suits better */
        Component.onCompleted: {
            if(pageStack.busy)
                pageStack.completeAnimation();

            pageStack.push(Qt.resolvedUrl("../../../pages/webview/dialogs/PromptDialog.qml"), { "promptModel": model, "title": message, "textField": defaultValue });
        }
    }

    experimental.authenticationDialog: Item { /* AuthenticationDialog is particular: A dedicated page suits better */
        Component.onCompleted: {
            if(pageStack.busy)
                pageStack.completeAnimation();

            pageStack.push(Qt.resolvedUrl("../../../pages/webview/dialogs/AuthenticationDialog.qml"), { "authenticationModel": model })
        }
    }

    experimental.colorChooser: Item {  /* ColorChooser is particular: A dedicated page suits better */
        Component.onCompleted: {
            if(pageStack.busy)
                pageStack.completeAnimation();

            pageStack.push(Qt.resolvedUrl("../../../pages/webview/dialogs/ColorChooserDialog.qml"), { "colorModel": model, "color": model.currentColor });
        }
    }

    experimental.itemSelector: Item {
        Component.onCompleted: {
            tabView.dialogs.showItemSelector(model, browsertab);
        }
    }

    experimental.onMessageReceived: listener.execute(message)
    experimental.onPermissionRequested: tabView.dialogs.showNotification(webview.url.toString(), browsertab)
    experimental.onProcessDidCrash: viewstack.push(Qt.resolvedUrl("../views/LoadFailed.qml"), "loaderror", { "errorString": webview.url, "offline": experimental.offline, "crash": true });

    experimental.onDownloadRequested: {
        var mime = mainwindow.settings.mimedatabase.mimeFromUrl(downloadItem.url);
        var mimeinfo = mime.split("/");

        if((mimeinfo[0] === "video") || (mimeinfo[0] === "audio")) {
            viewstack.push(Qt.resolvedUrl("../views/browserplayer/BrowserPlayer.qml"), "mediaplayer", { "videoTitle": downloadItem.suggestedFilename, "videoSource": downloadItem.url });
            return;
        }

        tabviewremorse.execute(qsTr("Downloading") + " " + downloadItem.suggestedFilename,
                               function() {
                                   mainwindow.settings.downloadmanager.createDownload(downloadItem);
                               });
    }

    onUrlChanged: {
        var stringurl = url.toString();

        if(UrlHelper.isSpecialUrl(stringurl)) {
            manageSpecialUrl(stringurl);
            return;
        }

        browsertab.state = "webview";
    }

    onFlickStarted: {
            if(verticalVelocity < 0){
                tabView.navigationBar.solidify();
                tabView.miniMenu.solidify();
                return;
            }
            else if(verticalVelocity > 0){
                tabView.navigationBar.evaporate();
                tabView.miniMenu.evaporate()
            }
         }

    onNavigationRequested: {
        var stringurl = request.url.toString();
        var protocol = UrlHelper.protocol(stringurl);

        if(urlschemedelegatehandler.handleProtocol(protocol, request.url)) {
            request.action = WebView.IgnoreRequest;
            return;
        }

        if(((protocol !== "http") && (protocol !== "https")) || UrlHelper.isSpecialUrl(stringurl) || (request.navigationType === WebView.FormSubmittedNavigation))
            return;

        if(request.navigationType === WebView.FormResubmittedNavigation) {
            request.action = WebView.IgnoreRequest;
            tabView.dialogs.showFormResubmit(stringurl, browsertab);
            return;
        }

        if((request.navigationType === WebView.OtherNavigation) && UrlHelper.domainName(url.toString()) !== UrlHelper.domainName(stringurl))
            return; /* Ignore Other Domain Requests */
    }

    onLoadingChanged: {
        if(loadRequest.status === WebView.LoadStartedStatus) {
           var stringurl = url.toString();
            tabView.pageLoading = true;
            if(browsertab.state === "loaderror") {
                viewstack.pop(); // Pop out error page
                browsertab.state == "webview";
            }

            if(visible) {
                tabView.dialogs.hideAll();
                tabView.navigationBar.solidify();
                tabView.miniMenu.solidify();
                Qt.inputMethod.hide();
            }
            if(!UrlHelper.isSpecialUrl(stringurl) && UrlHelper.isUrl(stringurl)) {
                if(mainwindow.busy){
                   console.log("vypnuto");
                   mainwindow.busy=false;
                 }
            }

            browsertab.popups.clear();
            webview.readerModeEnabled = false;
            webview.nightModeEnabled = false;
            return;
        }

        if(loadRequest.status === WebView.LoadFailedStatus) {
            tabView.pageLoading = true;
            browsertab.thumbUpdated = true;
            viewstack.push(Qt.resolvedUrl("../views/LoadFailed.qml"), "loaderror", { "errorString": loadRequest.errorString, "offline": experimental.offline, "crash": false });
            return;
        }

        if(loadRequest.status === WebView.LoadSucceededStatus) {
            tabView.pageLoading = false;
            var stringurl = url.toString();
     //       webview.favorite = Favorites.contains(stringurl);
            tabView.favorite = Favorites.contains(stringurl);

            if(!UrlHelper.isSpecialUrl(stringurl) && UrlHelper.isUrl(stringurl)) {

               if(settings.adblockmanager.enabled)
                    webview.postMessage("ajaxoverrider_applyblacklist", { "blacklist": settings.adblockmanager.hostsBlackList });

                if(settings.exp_overridetextfields)
                    webview.postMessage("textfieldhandler_override");

                webview.initTheme();
                webview.setNightMode(settings.nightmode);
                webview.postMessage("textselectorhandler_sethandlesize", { "size": selector.handleSize });

                if(settings.exp_ambiencebrowsing && !settings.nightmode) // Night mode overrides ambience browsing
                    webview.postMessage("theme_applyambience");

                Credentials.compile(Database.instance(), stringurl, webview);
                History.store(stringurl, title);
                console.log("succeed");

                console.log(mainpage.firstLoad);
                if(mainpage.firstLoad=="afterfirst"){mainpage.firstLoad="false"}
                if(mainpage.firstLoad=="true"){mainpage.firstLoad="afterfirst"}
                console.log(mainpage.firstLoad);
                tabView.currentIndex=currentIndex;
                if(mainwindow.busy){
                   console.log("vypnuto");
                   mainwindow.busy=false;
                 }
            }
            else
            {

              if(firstrunquickgrid){
                 if(mainwindow.busy){
                   console.log("vypnuto");
                   mainwindow.busy=false;
                 }
              }
              firstrunquickgrid=true;
            }
            browsertab.thumbUpdated = true;
        }
    }
}
