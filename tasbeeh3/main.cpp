#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "navigator.h"
#include "store.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    Navigator nav;
    viewer.rootContext()->setContextProperty("Nav", &nav);

    qDebug("before Store");
    Store store;
    qDebug("after Store");

    viewer.rootContext()->setContextProperty("Store", &store);

    viewer.setMainQmlFile(QLatin1String("qml/tasbeeh3/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
