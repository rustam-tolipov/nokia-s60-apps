import QtQuick 1.0
import QtMobility.sensors 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property real ax: 0
    property real ay: 0
    property real az: 0

    Accelerometer {
        id: accel
        active: true
        onReadingChanged: {
            if (!!reading) {
                ax = reading.x
                ay = reading.y
                az = reading.z
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            accel.active = false; Nav.pop(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Accelerometer"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.centerIn: parent
        spacing: 28

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "X: " + ax.toFixed(3) + " m/s2"
            color: "#4488cc"; font.pixelSize: 18; font.bold: true
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Y: " + ay.toFixed(3) + " m/s2"
            color: "#4488cc"; font.pixelSize: 18; font.bold: true
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Z: " + az.toFixed(3) + " m/s2"
            color: "#4488cc"; font.pixelSize: 18; font.bold: true
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "Move device to see values   BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
