import QtQuick 1.0
import QtMobility.systeminfo 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    StorageInfo { id: storInfo }

    function mb(bytes) {
        return (bytes / 1048576).toFixed(0) + " MB"
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Storage"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 12
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: 14; anchors.rightMargin: 14
        spacing: 16

        Repeater {
            model: storInfo.logicalDrives

            Column {
                width: parent.width
                spacing: 4
                Rectangle {
                    width: parent.width; height: 30; color: "#1a1a1a"; radius: 4
                    Text {
                        anchors.left: parent.left; anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Drive " + modelData + ":"
                        color: "#ccaa44"; font.pixelSize: 14; font.bold: true
                    }
                }
                Row {
                    spacing: 16
                    Text { text: "Total: " + mb(storInfo.totalDiskSpace(modelData)); color: "#888888"; font.pixelSize: 13 }
                    Text { text: "Free: " + mb(storInfo.availableDiskSpace(modelData)); color: "#88cc88"; font.pixelSize: 13 }
                }
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
