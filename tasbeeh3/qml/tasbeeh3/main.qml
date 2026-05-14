import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"

    Loader {
        id: pageLoader
        anchors.fill: parent
        focus: true
        source: Qt.resolvedUrl("ZikrPage.qml")
    }

    Connections {
        target: Nav
        onCurrentPageChanged: {
            pageLoader.source = Qt.resolvedUrl(page)
        }
    }
}
