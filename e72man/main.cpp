#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "navigator.h"
#include "vibrationhelper.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;

    Navigator nav;
    VibrationHelper vibra;

    viewer.rootContext()->setContextProperty("Nav", &nav);
    viewer.rootContext()->setContextProperty("Vibra", &vibra);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setMainQmlFile(QLatin1String("qml/e72man/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
