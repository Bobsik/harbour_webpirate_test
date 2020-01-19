import QtQuick 2.6
import Sailfish.Silica 1.0
import "jsdialogs"
import "../../menus"
import "../../js/settings/Favorites.js" as Favorites

Column
{
    property bool dialogVisible: false

    id: tabviewdialogs
    z: 10

    function hideAll() {
        alertdialog.visible = false;
        requestdialog.visible = false;
        credentialdialog.visible = false;
        formresubmitdialog.visible = false;
        notificationdialog.visible = false;
        itemselector.visible = false;
        linkmenu.visible = false;
        linkmenu.opacity = 0;
        sharemenu.visible = false;
        historymenu.hide();

        dialogVisible = false;
    }

    function showLinkMenu(url, title, src, model) {
        hideAll();
        linkmenu.url = url;
        linkmenu.title = title;
        linkmenu.src = src;
        if (src === ''){
            linkmenu.footeritemscount = 2;
            linkmenu.imgbool = false
             }
        else{
            if(url === src){
                linkmenu.footeritemscount = 1;
                model = 'imagemenumodel';
                linkmenu.imgonly = true;
            }
            else{
                linkmenu.footeritemscount = 3;
                linkmenu.imgbool = true
                linkmenu.imgonly = false;
             }
        }

        linkmenu.usedmodel = model;
        linkmenu.active = 0;
        linkmenu.visible = true;
        linkmenu.opacity = 1.0;
        console.log(url);
        console.log(src);
        dialogVisible = true;
    }

    function showShareMenu(title, url) {
        hideAll();

        sharemenu.share(title, url);

        dialogVisible = true;
    }

    function showAlert(model) {
        hideAll();

        alertdialog.model = model;
        alertdialog.visible = true;

        dialogVisible = true;
    }

    function showRequest(model, title) {
        hideAll();

        requestdialog.title = title;
        requestdialog.model = model;
        requestdialog.visible = true;

        dialogVisible = true;
    }

    function showCredential(url, logindata) {
        hideAll();

        credentialdialog.url = url;
        credentialdialog.logindata = logindata;
        credentialdialog.visible = true;

        dialogVisible = true;
    }

    function showFormResubmit(url, tab) {
        hideAll();

        formresubmitdialog.tab = tab;
        formresubmitdialog.url = url;
        formresubmitdialog.visible = true;

        dialogVisible = true;
    }

    function showNotification(url, tab) {
        hideAll();

        notificationdialog.tab = tab;
        notificationdialog.url = url;
        notificationdialog.visible = true;

        dialogVisible = true;
    }

    function showItemSelector(model, tab) {
        hideAll();

        itemselector.tab = tab;
        itemselector.selectorModel = model;
        itemselector.visible = true;

        dialogVisible = true;
    }

    function queryHistory(query) {
        historymenu.query = query;

        dialogVisible = true;
    }

    AlertDialog
    {
        id: alertdialog
        width: parent.width
    }

    RequestDialog
    {
        id: requestdialog
        width: parent.width
    }

    CredentialDialog
    {
        id: credentialdialog
        width: parent.width
    }

    FormResubmitDialog
    {
        id: formresubmitdialog
        width: parent.width
    }

    NotificationDialog
    {
        id: notificationdialog
        width: parent.width
    }

    ItemSelector
    {
        id: itemselector
        width: parent.width
        height: (count > 0) ? Math.min(itemselector.contentHeight, tabcontainer.contentHeight) : 0
    }

    HistoryMenu
    {
        id: historymenu
        width: parent.width
        height: (count > 0) ? Math.min(historymenu.contentHeight, tabcontainer.contentHeight) : 0
        onUrlRequested: tabview.currentTab().load(url)
    }

    LinkMenu
    {
        id: linkmenu
        width: parent.width
        height: (count > 0) ? Math.min(linkmenu.contentHeight, tabcontainer.contentHeight) : 0

        onOpenThisTabRequested: tabview.currentTab().load(url)
        onCreateTabRequested: tabview.addTab(url, false)
        onOpenTabRequested: tabview.addTab(url)
    }



    ShareMenu
    {
        id: sharemenu
        width: parent.width
        height: (count > 0) ? Math.min(sharemenu.contentHeight, tabcontainer.contentHeight) : 0
    }
}
