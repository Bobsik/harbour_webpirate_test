#ifndef WEBPIRATEINTERFACE_H
#define WEBPIRATEINTERFACE_H

#include <QtDBus>
#include <QDesktopServices>
#include <QObject>
#include <QDebug>
#include <QQuickView>
#include "webpirateadaptor.h"

class WebPirateInterface : public QObject
{
    Q_OBJECT

    public:
        explicit WebPirateInterface(QObject *parent = 0);
        static void sendArgs(const QStringList& args);

    public slots:
        void openSingleUrl(const QString& url);
        void openUrl(const QStringList& args);

    signals:
        void urlRequested(QStringList args);

    public:
        static const QString INTERFACE_NAME;
};

#endif // WEBPIRATEINTERFACE_H
