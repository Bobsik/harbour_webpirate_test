import QtQuick 2.6

ListModel
{
    id: closedtabsmodel

    function push(title, url)
    {
        closedtabsmodel.insert(0, { "title": title, "url": url });
    }
}
