import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"
    focus: true

    property int  count:    0
    property int  round:    1
    property int  sessions: 0
    property bool debounce: false
    property bool done:     false

    Timer { id: debounceTimer; interval: Store.counterSpeed; onTriggered: debounce = false }

    Component.onCompleted: {
        var s = Store.loadSession()
        count    = s.count
        round    = s.round
        sessions = s.sessions
        done = (sessions >= 5)
    }

    function saveState() { Store.save(count, round, sessions) }

    function doCount() {
        if (debounce || done) return
        debounce = true
        count++
        if (count >= 33) {
            count = 0; round++
            if (round > 3) { round = 1; sessions++ }
            if (sessions >= 5) done = true
        }
        saveState()
        debounceTimer.restart()
    }

    function doUndo() {
        if (done) { done = false; return }
        if (count > 0) { count-- }
        else if (round > 1) { round--; count = 32 }
        else if (sessions > 0) { sessions--; round = 3; count = 32 }
        saveState()
    }

    function doReset() {
        count = 0; round = 1; sessions = 0; done = false
        saveState()
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No ||
                event.key === Qt.Key_Back  || event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        } else if (event.key === Qt.Key_Context1) {
            doReset(); event.accepted = true
        } else if (event.key === Qt.Key_Select || event.key === Qt.Key_Return ||
                   event.key === Qt.Key_Enter  ||
                   event.key === Qt.Key_0 || event.key === Qt.Key_1 || event.key === Qt.Key_2 ||
                   event.key === Qt.Key_3 || event.key === Qt.Key_4 || event.key === Qt.Key_5 ||
                   event.key === Qt.Key_6 || event.key === Qt.Key_7 || event.key === Qt.Key_8 ||
                   event.key === Qt.Key_9 || event.key === Qt.Key_Asterisk) {
            doCount(); event.accepted = true
        } else if (event.key === Qt.Key_NumberSign) {
            doUndo(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#0d0d0d"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#222222" }
        Text {
            anchors.left: parent.left; anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: "Back"; color: "#555555"; font.pixelSize: 12
        }
        Text {
            anchors.centerIn: parent
            text: "TASBEEH"; color: "#ffffff"; font.pixelSize: 15; font.bold: true
        }
        Text {
            anchors.right: parent.right; anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: "Reset"; color: "#555555"; font.pixelSize: 12
        }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 16
        anchors.bottom: footer.top
        width: parent.width
        spacing: 0

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: done ? "COMPLETE!" : ""
            color: "#44cc88"; font.pixelSize: 14; font.bold: true
            visible: done
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: count
            color: done ? "#44cc88" : "#ffffff"
            font.pixelSize: 52; font.bold: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "of 33"
            color: "#3a3a3a"; font.pixelSize: 12
        }

        Item { width: 1; height: 16 }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 24

            Column {
                spacing: 2
                Text { anchors.horizontalCenter: parent.horizontalCenter
                       text: "ROUND"; color: "#444444"; font.pixelSize: 10 }
                Text { anchors.horizontalCenter: parent.horizontalCenter
                       text: round + " / 3"; color: "#ccaa44"; font.pixelSize: 20; font.bold: true }
            }

            Rectangle { width: 1; height: 38; color: "#222222" }

            Column {
                spacing: 2
                Text { anchors.horizontalCenter: parent.horizontalCenter
                       text: "SESSION"; color: "#444444"; font.pixelSize: 10 }
                Text { anchors.horizontalCenter: parent.horizontalCenter
                       text: sessions + " / 5"; color: "#4488cc"; font.pixelSize: 20; font.bold: true }
            }
        }

        Item { width: 1; height: 14 }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 32; height: 6; radius: 3; color: "#1a1a1a"
            Rectangle {
                width: parent.width * count / 33
                height: parent.height; radius: 3; color: "#ccaa44"
            }
        }

        Item { width: 1; height: 8 }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Total: " + (sessions * 99 + (round - 1) * 33 + count)
            color: "#444444"; font.pixelSize: 11
        }
    }

    Rectangle {
        id: footer
        width: parent.width; height: 24
        anchors.bottom: parent.bottom
        color: "#0a0a0a"
        Rectangle { width: parent.width; height: 1; color: "#1a1a1a" }
        Text {
            anchors.centerIn: parent
            text: "ANY KEY=count   #=undo   LEFT=reset   BACK=exit"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
