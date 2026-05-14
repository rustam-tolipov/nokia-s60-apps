import QtQuick 1.0

Rectangle {
    id: appRoot
    width: 240
    height: 320
    color: "#161616"

    Loader {
        id: pageLoader
        anchors.fill: parent
        focus: true
        source: Qt.resolvedUrl("MainPage.qml")
    }

    Connections {
        target: Nav
        onCurrentPageChanged: {
            pageLoader.source = Qt.resolvedUrl(page)
        }
    }
}
