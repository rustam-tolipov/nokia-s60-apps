import QtQuick 1.0
import QtMobility.location 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property string gpsStatus: "Searching..."
    property real   lat:        0
    property real   lon:        0
    property real   alt:        0
    property real   accuracy:   0
    property bool   hasFix:     false

    PositionSource {
        id: gps
        active: true
        updateInterval: 2000
        onPositionChanged: {
            if (position.latitudeValid) {
                hasFix   = true
                lat      = position.coordinate.latitude
                lon      = position.coordinate.longitude
                alt      = position.coordinate.altitude
                accuracy = position.horizontalAccuracy
                gpsStatus = "Fix acquired"
            } else {
                gpsStatus = "Searching..."
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            gps.active = false; Nav.pop(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "GPS"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 16
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: 14; anchors.rightMargin: 14
        spacing: 12

        Text {
            text: "Status: " + gpsStatus
            color: hasFix ? "#88cc88" : "#ccaa44"; font.pixelSize: 14
        }

        Row {
            spacing: 0
            Text { text: "Latitude:  "; color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: hasFix ? lat.toFixed(5) + "°" : "---"; color: "#aaaaaa"; font.pixelSize: 13 }
        }
        Row {
            spacing: 0
            Text { text: "Longitude: "; color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: hasFix ? lon.toFixed(5) + "°" : "---"; color: "#aaaaaa"; font.pixelSize: 13 }
        }
        Row {
            spacing: 0
            Text { text: "Altitude:  "; color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: hasFix ? alt.toFixed(1) + " m" : "---"; color: "#aaaaaa"; font.pixelSize: 13 }
        }
        Row {
            spacing: 0
            Text { text: "Accuracy:  "; color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: hasFix ? accuracy.toFixed(0) + " m" : "---"; color: "#aaaaaa"; font.pixelSize: 13 }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "Needs clear sky   BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
