import QtQuick 1.0
import QtMultimediaKit 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property string audioStatus: "idle"
    property int    sel:         0

    Audio {
        id: player
        source: Qt.resolvedUrl("test.wav")
        volume: 1.0
        onStatusChanged: {
            if (status === Audio.Playing)       audioStatus = "playing"
            else if (status === Audio.Ready)    audioStatus = "ready"
            else if (status === Audio.EndOfMedia)   audioStatus = "done"
            else if (status === Audio.InvalidMedia) audioStatus = "ERROR: file missing"
            else if (status === Audio.Error)        audioStatus = "ERROR"
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            player.stop(); Nav.pop(); event.accepted = true; return
        }
        if (event.key === Qt.Key_Up)   { if (sel > 0) sel--; event.accepted = true }
        if (event.key === Qt.Key_Down) { if (sel < 1) sel++; event.accepted = true }
        if (event.key === Qt.Key_Select || event.key === Qt.Key_Return ||
            event.key === Qt.Key_Enter  || event.key === Qt.Key_Space) {
            if (sel === 0) { player.stop(); player.play() }
            else           { player.stop(); audioStatus = "stopped" }
            event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Audio Test"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 20
        width: parent.width; spacing: 0

        Repeater {
            model: ["Play test.wav", "Stop"]
            Rectangle {
                width: parent.width; height: 48
                color: sel === index ? "#1a2a3a" : "#111111"
                Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1e1e1e" }
                Rectangle { width: 3; height: parent.height; color: sel === index ? "#4488cc" : "transparent" }
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData
                    color: sel === index ? "#ffffff" : "#999999"; font.pixelSize: 14
                }
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom; anchors.bottomMargin: 40
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: 12; anchors.rightMargin: 12
        height: 36; color: "#0d1a0d"; radius: 4
        Text {
            anchors.centerIn: parent
            text: "Status: " + audioStatus
            color: audioStatus === "playing" ? "#88cc88" : audioStatus.indexOf("ERROR") === 0 ? "#cc4444" : "#888888"
            font.pixelSize: 13
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "UP/DOWN   CENTER=select   BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
