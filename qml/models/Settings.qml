import QtQuick 2.6
import harbour.webpirate.Private 1.0
import harbour.webpirate.WebKit 1.0
import harbour.webpirate.DBus 1.0
import harbour.webpirate.DBus.TransferEngine 1.0
import harbour.webpirate.DBus.Notifications 1.0
import harbour.webpirate.AdBlock 1.0
import harbour.webpirate.Helpers 1.0
import "cover"

QtObject
{
    readonly property string version: "2.1"

    property MimeDatabase mimedatabase: MimeDatabase { }
    property ScreenBlank screenblank: ScreenBlank { }
    property SearchEngineModel searchengines: SearchEngineModel { }
    property DownloadManager downloadmanager: DownloadManager { }
    property AdBlockManager adblockmanager: AdBlockManager { }
    property QuickGridModel quickgridmodel: QuickGridModel { }
    property CookieJar cookiejar: CookieJar { }
    property DefaultBrowser defaultbrowser: DefaultBrowser { }
    property WebPirateInterface webpirateinterface: WebPirateInterface { }
    property WebKitDatabase webkitdatabase: WebKitDatabase { }
    property WebIconDatabase icondatabase: WebIconDatabase { }
    property TransferEngine transferengine: TransferEngine { }
    property Notifications notifications: Notifications { }
    property UrlComposer urlcomposer: UrlComposer { }
    property CoverModel coveractions: CoverModel { }
    property ClipboardHelper clipboard: ClipboardHelper { }

    property int searchengine            /* Search Engine Index */
    property int useragent               /* User Agent Index */
    property int presscustomaction       /* Custom action on Press */
    property int longpresscustomaction   /* Custom action on Long Press */
    property string homepage             /* HomePage Url */
    property string browsemenu           /* Browse Menu */
    property bool lefthanded             /* Left Handed Mode */
    property bool clearonexit            /* Wipe UserData on exit */
    property bool keepfavicons           /* Keep Icon Database on data deletion */
    property bool tabminen               /* TabSegment Minimenu Enabled */
    property string tabminimenu_s        /* TabSegment Minimenu Landscape side */
    property string tabminimenu_p        /* TabSegment Minimenu portraint position */
    property bool restoretabs            /* Restore Tabs at Startup */
    property bool closelasttab           /* Close Last Tab */
    property bool nightmode              /* Night Mode */

    /* Experimental Settings */
    property bool exp_overridetextfields /* Overrides WebView's text fields with Sailfish ones */
    property bool exp_ambiencebrowsing   /* Try to skin webpages to SailfishOS' ambience */
}
