# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-webpirate_test

QT += sql dbus concurrent
CONFIG += sailfishapp c++11 libwebp
PKGCONFIG += libcrypto

opendesktopfile.files = harbour-webpirate_test-open-url.desktop
opendesktopfile.path = /usr/share/harbour-webpirate_test

# Install D-Bus Service (Currently Disabled)
dbus.files = org.harbour.webpirate_test.service
dbus.path = /usr/share/harbour-webpirate_test

INSTALLS +=dbus opendesktopfile

SOURCES += src/harbour-webpirate.cpp \
    src/webkitdatabase/webkitdatabase.cpp \
    src/downloadmanager/downloadmanager.cpp \
    src/downloadmanager/downloaditem.cpp \
    src/webkitdatabase/webicondatabase.cpp \
    src/favoritesmanager/favoritesmanager.cpp \
    src/imageproviders/faviconprovider.cpp \
    src/favoritesmanager/favoriteitem.cpp \
    src/dbus/webpirateadaptor.cpp \
    src/mime/mimedatabase.cpp \
    src/adblock/adblockmanager.cpp \
    src/adblock/adblockeditor.cpp \
    src/adblock/adblockfilter.cpp \
    src/adblock/adblockdownloader.cpp \
    src/dbus/client/screenblank.cpp \
    src/security/cryptography/aes256.cpp \
    src/webkitdatabase/cookie/cookiejar.cpp \
    src/webkitdatabase/abstractdatabase.cpp \
    src/downloadmanager/webviewdownloaditem.cpp \
    src/downloadmanager/abstractdownloaditem.cpp \
    src/webkitdatabase/cookie/cookieitem.cpp \
    src/dbus/client/transferengine/transferengine.cpp \
    src/dbus/client/transferengine/transfermethodinfo.cpp \
    src/dbus/client/transferengine/transfermethodmodel.cpp \
    src/dbus/client/urlcomposer.cpp \
    src/dbus/client/ofono/ofono.cpp \
    src/dbus/client/ofono/ofonoproperty.cpp \
    src/network/networkinterfaces.cpp \
    src/dbus/client/machineid.cpp \
    src/dbus/webpirateinterface.cpp \
    src/downloadmanager/webpagedownloaditem.cpp \
    src/dbus/defaultbrowser.cpp \
    src/network/proxymanager.cpp \
    src/selector/filesmodel.cpp \
    src/selector/filesmodelworker.cpp \
    src/selector/exif/exif.cpp \
    src/helper/clipboardhelper.cpp \
    src/dbus/notification/notification.cpp \
    src/dbus/notification/notificationmanagerproxy.cpp \
    src/dbus/notification/notificationmanager.cpp \
    src/adblock/adblockhostsparser.cpp \
    src/translation/translationinfoitem.cpp \
    src/translation/translationsmodel.cpp

OTHER_FILES += qml/harbour-webpirate.qml \
    rpm/harbour-webpirate.spec \
    translations/*.ts \
    qml/js/UrlHelper.js \
    qml/js/settings/SearchEngines.js \
    qml/js/settings/Favorites.js \
    qml/components/tabview/navigationbar/NavigationBar.qml \
    qml/components/browsertab/views/LoadFailed.qml \
    qml/components/browsertab/BrowserTab.qml \
    qml/pages/MainPage.qml \
    qml/js/settings/UserAgents.js \
    qml/js/settings/BrowserMenus.js \
    qml/js/settings/TabViewMinimenu.js \
    qml/js/settings/Database.js \
    qml/models/Settings.qml \
    qml/models/FavoritesModel.qml \
    qml/pages/settings/searchengine/SearchEnginesPage.qml \
    qml/pages/settings/searchengine/SearchEnginePage.qml \
    qml/models/SearchEngineModel.qml \
    qml/js/settings/Credentials.js \
    qml/components/items/DownloadListItem.qml \
    qml/components/browsertab/webview/BrowserWebView.qml \
    qml/js/settings/History.js \
    qml/components/SettingLabel.qml \
    qml/components/tabview/TabView.qml \
    qml/components/quickgrid/QuickGrid.qml \
    qml/components/quickgrid/QuickGridItem.qml \
    qml/components/quickgrid/QuickGridButton.qml \
    qml/js/settings/QuickGrid.js \
    qml/models/QuickGridModel.qml \
    qml/components/PopupMessage.qml \
    qml/components/InfoLabel.qml \
    qml/js/youtube/YouTubeGrabber.js \
    qml/components/browsertab/views/browserplayer/mediacomponents/MediaPlayerToolBar.qml \
    qml/components/browsertab/views/browserplayer/mediacomponents/MediaPlayerTitle.qml \
    qml/js/settings/Sessions.js \
    qml/components/items/PageItem.qml \
    qml/components/items/cover/CoverMenu.qml \
    qml/models/cover/CoverModel.qml \
    qml/components/items/cover/PageCoverActions.qml \
    qml/js/settings/Cover.js \
    rpm/harbour-webpirate.yaml \
    adblock.css \
    adblock.table \
    qml/components/browsertab/webview/WebViewListener.qml \
    qml/models/HistoryModel.qml \
    qml/components/items/NavigationHistoryItem.qml \
    qml/models/ClosedTabsModel.qml \
    qml/js/settings/PopupBlocker.js \
    qml/models/BlockedPopupModel.qml \
    qml/models/PopupModel.qml \
    qml/components/items/PopupItem.qml \
    qml/components/items/BlockedPopupItem.qml \
    qml/components/browsertab/ViewStack.qml \
    qml/components/browsertab/views/browserplayer/BrowserPlayer.qml \
    qml/components/browsertab/views/browserplayer/mediacomponents/MediaPlayerCursor.qml \
    qml/components/browsertab/views/browserplayer/mediacomponents/MediaPlayerProgressBar.qml \
    qml/components/items/cookie/DomainListItem.qml \
    qml/components/items/cookie/CookieListItem.qml \
    qml/components/browsertab/webview/UrlSchemeDelegateHandler.qml \
    qml/js/youtube/YouTubeCipher.js \
    qml/pages/settings/SettingsPage.qml \
    qml/pages/settings/GeneralSettingsPage.qml \
    qml/pages/settings/CoverSettingsPage.qml \
    qml/pages/settings/PrivacySettingsPage.qml \
    qml/pages/settings/TabsSettingsPage.qml \
    qml/pages/settings/ExperimentalSettingsPage.qml \
    qml/pages/settings/adblock/AdBlockFilter.qml \
    qml/pages/settings/adblock/AdBlockDownloaderPage.qml \
    qml/pages/settings/adblock/AdBlockPage.qml \
    qml/pages/webview/TextFieldPage.qml \
    qml/components/quickgrid/QuickGridBottomPanel.qml \
    qml/pages/settings/ProxySettingsPage.qml \
    qml/components/tabview/TabViewDialogs.qml \
    qml/components/tabview/jsdialogs/AlertDialog.qml \
    qml/components/tabview/jsdialogs/JavaScriptDialog.qml \
    qml/components/tabview/TabStack.qml \
    qml/components/tabview/navigationbar/LoadingBar.qml \
    qml/components/tabview/jsdialogs/ItemSelector.qml \
    qml/components/items/tab/TabListItem.qml \
    qml/components/items/tab/TabClosedItem.qml \
    qml/components/segments/TabsSegment.qml \
    qml/components/segments/ClosedTabsSegment.qml \
    qml/components/segments/SessionsSegment.qml \
    qml/components/segments/CookiesSegment.qml \
    qml/models/SegmentsModel.qml \
    qml/components/segments/HistorySegment.qml \
    qml/components/segments/DownloadsSegment.qml \
    qml/components/segments/FavoritesSegment.qml \
    qml/components/items/FavoriteItem.qml \
    qml/menus/FavoritesMenu.qml \
    qml/pages/segment/SegmentsPage.qml \
    qml/pages/segment/favorite/FavoritesImportPage.qml \
    qml/pages/segment/favorite/FavoritePage.qml \
    qml/pages/selector/SelectorFilesPage.qml \
    qml/pages/segment/cookie/CookieListPage.qml \
    qml/pages/segment/cookie/CookiePage.qml \
    qml/pages/segment/session/SaveSessionPage.qml \
    qml/pages/segment/session/SessionPage.qml \
    qml/components/tabview/jsdialogs/RequestDialog.qml \
    qml/components/DialogBackground.qml \
    qml/components/tabview/jsdialogs/CredentialDialog.qml \
    qml/components/tabview/jsdialogs/FormResubmitDialog.qml \
    qml/components/tabview/jsdialogs/NotificationDialog.qml \
    qml/pages/webview/dialogs/AuthenticationDialog.qml \
    qml/pages/webview/dialogs/ColorChooserDialog.qml \
    qml/pages/webview/dialogs/PromptDialog.qml \
    qml/components/tabview/navigationbar/QueryBar.qml \
    qml/menus/HistoryMenu.qml \
    qml/menus/LinkMenu.qml \
    qml/menus/ShareMenu.qml \
    qml/pages/quickgrid/QuickGridPage.qml \
    qml/pages/settings/popup/NewPopupRulePage.qml \
    qml/pages/settings/popup/PopupManagerPage.qml \
    qml/pages/popup/PopupBlockerPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-webpirate.ts \
            translations/harbour-webpirate-ca.ts \
            translations/harbour-webpirate-cs_CZ.ts \
            translations/harbour-webpirate-de.ts \
            translations/harbour-webpirate-el.ts \
            translations/harbour-webpirate-es.ts \
            translations/harbour-webpirate-fi_FI.ts \
            translations/harbour-webpirate-fr.ts \
            translations/harbour-webpirate-hu.ts \
            translations/harbour-webpirate-it.ts \
            translations/harbour-webpirate-ja.ts \
            translations/harbour-webpirate-nl_NL.ts \
            translations/harbour-webpirate-pl.ts \
            translations/harbour-webpirate-ru_RU.ts \
            translations/harbour-webpirate-sl_SI.ts \
            translations/harbour-webpirate-sv_SE.ts \
            translations/harbour-webpirate-zh_CN.ts \
            translations/harbour-webpirate-zh_TW.ts \

RESOURCES += \
    resources.qrc

SAILFISHAPP_ICONS = \
    86x86 \
    108x108 \
    128x128 \
    172x172 \
    256x256

HEADERS += \
    src/webkitdatabase/webkitdatabase.h \
    src/downloadmanager/downloadmanager.h \
    src/downloadmanager/downloaditem.h \
    src/webkitdatabase/webicondatabase.h \
    src/favoritesmanager/favoritesmanager.h \
    src/imageproviders/faviconprovider.h \
    src/favoritesmanager/favoriteitem.h \
    src/dbus/webpirateadaptor.h \
    src/mime/mimedatabase.h \
    src/adblock/adblockmanager.h \
    src/adblock/adblockeditor.h \
    src/adblock/adblockfilter.h \
    src/adblock/adblockdownloader.h \
    src/dbus/client/screenblank.h \
    src/security/cryptography/aes256.h \
    src/webkitdatabase/cookie/cookiejar.h \
    src/webkitdatabase/abstractdatabase.h \
    src/downloadmanager/webviewdownloaditem.h \
    src/downloadmanager/abstractdownloaditem.h \
    src/webkitdatabase/cookie/cookieitem.h \
    src/dbus/client/transferengine/transferengine.h \
    src/dbus/client/transferengine/transfermethodinfo.h \
    src/dbus/client/transferengine/transfermethodmodel.h \
    src/dbus/client/urlcomposer.h \
    src/dbus/client/ofono/ofono.h \
    src/dbus/client/ofono/ofonoproperty.h \
    src/network/networkinterfaces.h \
    src/dbus/client/machineid.h \
    src/dbus/webpirateinterface.h \
    src/downloadmanager/webpagedownloaditem.h \
    src/dbus/defaultbrowser.h \
    src/network/proxymanager.h \
    src/selector/filesmodel.h \
    src/selector/filesmodelworker.h \
    src/selector/exif/exif.h \
    src/helper/clipboardhelper.h \
    src/dbus/notification/notification.h \
    src/dbus/notification/notificationmanagerproxy.h \
    src/dbus/notification/notificationmanager.h \
    src/adblock/adblockhostsparser.h \
    src/translation/translationinfoitem.h \
    src/translation/translationsmodel.h

DISTFILES += \
    harbour-webpirate_test.desktop \
    org.harbour.webpirate_test.service \
    qml/components/items/tab/TabSegmentMiniMenu.qml \
    qml/js/settings/BrowseMenus.js \
    qml/js/settings/TabViewMinimenu.js \
    rpm/harbour-webpirate.changes \
    qml/components/browsertab/views/browsergrabber/BrowserGrabber.qml \
    qml/components/browsertab/views/browsergrabber/GrabberThumbnail.qml \
    qml/components/items/GrabberItem.qml \
    qml/js/MediaPlayerHelper.js \
    qml/components/browsertab/views/browserplayer/mediacomponents/MediaPlayerError.qml \
    qml/models/BrowserTabModel.qml \
    qml/components/browsertab/views/browserplayer/mediacomponents/MediaPlayerPopup.qml \
    qml/js/webview/lib/Init.js \
    qml/js/webview/lib/TouchHandler.js \
    qml/js/webview/lib/WebPirate.js \
    qml/js/webview/overrides/AjaxOverrider.js \
    qml/js/webview/overrides/ObjectOverrider.js \
    qml/js/webview/overrides/TagOverrider.js \
    qml/js/webview/lib/SubmitHandler.js \
    qml/js/webview/lib/StyleHandler.js \
    qml/js/webview/lib/Utils.js \
    qml/js/webview/lib/TextFieldHandler.js \
    qml/js/webview/lib/NightModeHandler.js \
    qml/js/webview/lib/PixelRatioHandler.js \
    qml/js/webview/lib/MessageListener.js \
    qml/js/webview/lib/grabber/GrabberBuilder.js \
    qml/js/webview/lib/grabber/YouTubeHandler.js \
    qml/js/webview/lib/grabber/DailyMotionHandler.js \
    qml/js/webview/lib/grabber/VimeoHandler.js \
    qml/js/webview/overrides/NotificationOverrider.js \
    qml/js/webview/lib/TextSelectorHandler.js \
    qml/js/webview/lib/Theme.js \
    qml/components/browsertab/webview/selector/WebViewSelector.qml \
    qml/components/browsertab/webview/selector/SelectorHandle.qml \
    qml/models/navigationbar/CustomActionsModel.qml \
    qml/components/navigationbar/ImageButton.qml \
    qml/components/navigationbar/ActionButton.qml \
    qml/components/BackgroundRectangle.qml \
    qml/js/webview/3rdparty/es6-collections.min.js \
    qml/js/webview/3rdparty/canvg.min.js \
    qml/js/webview/3rdparty/readability.min.js \
    qml/js/webview/lib/ReaderModeHandler.js \
    qml/pages/settings/about/AboutPage.qml \
    qml/pages/settings/about/DevelopersPage.qml \
    qml/components/CollaboratorsLabel.qml \
    qml/pages/settings/about/ThirdPartyPage.qml \
    qml/pages/settings/about/TranslationsPage.qml \
    qml/components/ThirdPartyLabel.qml
