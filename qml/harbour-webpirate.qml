import QtQuick 2.6
import Sailfish.Silica 1.0
import "models"
import "pages"
import "js/settings/Database.js" as Database
import "js/settings/Favorites.js" as Favorites
import "js/settings/SearchEngines.js" as SearchEngines
import "js/settings/QuickGrid.js" as QuickGrid
import "js/settings/BrowseMenus.js" as BrowseMenus
import "js/settings/TabViewMinimenu.js" as TabViewMenu
import "js/settings/UserAgents.js" as UserAgents
import "js/settings/PopupBlocker.js" as PopupBlocker
import "js/settings/Credentials.js" as Credentials
import "js/settings/History.js" as History
import "js/settings/Sessions.js" as Sessions
import "js/settings/Cover.js" as Cover

ApplicationWindow
{
    Settings
    {
        id: settings

        downloadmanager.onDownloadCompleted: notifications.send(filename, qsTr("Download Completed"), false, true);
        downloadmanager.onDownloadFailed: notifications.send(filename, qsTr("Download Failed"), false, true);

        Component.onCompleted: {
            UserAgents.buildUA(settings.version, "538.1"); // Create UA dynamically
            Database.load();
            History.load();
            Sessions.createSchema();
            Favorites.load(Database.instance());

            Database.transaction(function(tx) {
                UserAgents.load(tx);
                PopupBlocker.load(tx);
                SearchEngines.load(tx, settings.searchengines);
                BrowseMenus.load(tx, settings.browsemenu);
                QuickGrid.load(tx, settings.quickgridmodel);
                Credentials.createSchema(tx);
                Cover.createSchema(tx);

                var c = Cover.load(tx, settings.coveractions.generalCategoryId);
                settings.coveractions.generalLeftAction = c.left;
                settings.coveractions.generalRightAction = c.right;

                c = Cover.load(tx, settings.coveractions.webPageCategoryId);
                settings.coveractions.webPageLeftAction = c.left;
                settings.coveractions.webPageRightAction = c.right;

                var hp = Database.transactionGet(tx, "homepage");
                settings.homepage = (hp === false ? "about:newtab" : hp);

                var se = Database.transactionGet(tx, "searchengine");
                settings.searchengine = (se === false ? 0 : se);

                var bm = Database.transactionGet(tx, "browsemenu");
                settings.browsemenu = (bm === false ? 0 : bm);

                var ua = Database.transactionGet(tx, "useragent");
                settings.useragent = (ua === false ? 0 : ua);

                settings.adblockmanager.enabled = parseInt(Database.transactionGet(tx, "blockads"));
                settings.tabminen = parseInt(Database.transactionGet(tx, "tabminen"));
                settings.presscustomaction = parseInt(Database.transactionGet(tx, "presscustomaction"));
                settings.longpresscustomaction = parseInt(Database.transactionGet(tx, "longpresscustomaction"));
                settings.nightmode = parseInt(Database.transactionGet(tx, "nightmode"));
                settings.keepfavicons = parseInt(Database.transactionGet(tx, "keepfavicons"));
                settings.lefthanded = parseInt(Database.transactionGet(tx, "lefthanded"));
                settings.clearonexit = parseInt(Database.transactionGet(tx, "clearonexit"));
                settings.closelasttab = parseInt(Database.transactionGet(tx, "closelasttab"));
                settings.restoretabs = parseInt(Database.transactionGet(tx, "restoretabs"));

                /* Experimental Options */
                settings.exp_overridetextfields = parseInt(Database.transactionGet(tx, "overridetextfields"));
                settings.exp_ambiencebrowsing = parseInt(Database.transactionGet(tx, "ambiencebrowsing"));
            });
        }
    }

    default property alias settings: settings

    id: mainwindow
    allowedOrientations: defaultAllowedOrientations
    initialPage: Component { MainPage { } }
    cover: null
    property bool busy: true

    Component.onDestruction: {
        Database.set("blockads", settings.adblockmanager.enabled ? 1 : 0);
        Database.set("nightmode", settings.nightmode ? 1 : 0);

        if(settings.clearonexit) {
            settings.webkitdatabase.clearCache();
            settings.webkitdatabase.clearNavigationData(settings.keepfavicons);
            Credentials.clear(Database.instance());
            History.clear();
        }
    }
}
