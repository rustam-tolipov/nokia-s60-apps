import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property int    sel:    0
    property string result: ""
    property variant durations: [200, 500, 1000, 2000]
    property variant labels:    ["Short  200ms", "Medium  500ms", "Long  1000ms", "Extra  2000ms"]

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true; return
        }
        if (event.key === Qt.Key_Up)   { if (sel > 0) sel--; event.accepted = true }
        if (event.key === Qt.Key_Down) { if (sel < durations.length - 1) sel++; event.accepted = true }
        if (event.key === Qt.Key_Select || event.key === Qt.Key_Return) {
            Vibra.vibrate(durations[sel])
            result = labels[sel] + " sent"
            event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Vibration"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Rectangle {
        anchors.top: hdr.bottom; anchors.topMargin: 8
        anchors.left: parent.left; anchors.right: parent.right; anchors.leftMargin: 12; anchors.rightMargin: 12
        height: 30; color: "#0a0a0a"; radius: 4
        Text {
            anchors.centerIn: parent
            text: "Init: " + (Vibra.isReady() ? "OK" : "FAILED")
            color: Vibra.isReady() ? "#88cc88" : "#cc4444"; font.pixelSize: 12
        }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 50
        width: parent.width; spacing: 0

        Repeater {
            model: labels
            Rectangle {
                width: parent.width; height: 48
                color: sel === index ? "#1a2a3a" : "#111111"
                Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1e1e1e" }
                Rectangle { width: 3; height: parent.height; color: sel === index ? "#44aa66" : "transparent" }
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData
                    color: sel === index ? "#ffffff" : "#999999"; font.pixelSize: 14
                }
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 30
        text: result
        color: "#88cc88"; font.pixelSize: 13
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "UP/DOWN   CENTER=vibrate   BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
