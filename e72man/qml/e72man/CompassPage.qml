import QtQuick 1.0
import QtMobility.sensors 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property real heading:     0
    property int  calibration: 0

    Compass {
        id: compass
        active: true
        onReadingChanged: {
            heading     = reading.azimuth
            calibration = reading.calibrationLevel
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            compass.active = false; Nav.pop(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Compass"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.centerIn: parent
        spacing: 28

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: heading.toFixed(1) + "°"
            color: "#4488cc"; font.pixelSize: 36; font.bold: true
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                var h = heading
                if (h < 22.5 || h >= 337.5)  return "NORTH"
                if (h < 67.5)  return "NORTH-EAST"
                if (h < 112.5) return "EAST"
                if (h < 157.5) return "SOUTH-EAST"
                if (h < 202.5) return "SOUTH"
                if (h < 247.5) return "SOUTH-WEST"
                if (h < 292.5) return "WEST"
                return "NORTH-WEST"
            }
            color: "#ccaa44"; font.pixelSize: 16
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Calibration: " + calibration + " / 3"
            color: calibration >= 2 ? "#88cc88" : "#cc8844"; font.pixelSize: 13
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "Rotate device to calibrate   BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
