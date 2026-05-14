import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"
    focus: true

    property string today:      Qt.formatDate(new Date(), "yyyy-MM-dd")
    property string todayLabel: Qt.formatDate(new Date(), "ddd d MMM")
    property int    count:      0
    property bool   debounce:   false

    Timer { id: debounceTimer; interval: Store.counterSpeed; onTriggered: debounce = false }

    Component.onCompleted: { count = Store.zikrCount(today) }

    function doCount() {
        if (debounce) return
        debounce = true
        count++
        Store.setZikrCount(today, count)
        debounceTimer.restart()
    }

    function doUndo() {
        if (count > 0) { count--; Store.setZikrCount(today, count) }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Context1) {
            Nav.push("MenuPage.qml"); event.accepted = true
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
            text: "Menu"; color: "#555555"; font.pixelSize: 12
        }
        Text {
            anchors.centerIn: parent
            text: "ZIKR"; color: "#ffffff"; font.pixelSize: 15; font.bold: true
        }
        Text {
            anchors.right: parent.right; anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: todayLabel; color: "#555555"; font.pixelSize: 11
        }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 24
        anchors.bottom: footer.top; anchors.bottomMargin: 8
        width: parent.width
        spacing: 0

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: count
            color: "#ffffff"; font.pixelSize: 58; font.bold: true
        }

        Item { width: 1; height: 16 }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 32; height: 8; radius: 4; color: "#222222"
            Rectangle {
                width: Math.min(parent.width, parent.width * count / Math.max(1, Store.zikrTarget))
                height: parent.height; radius: 4
                color: count >= Store.zikrTarget ? "#44cc88" : "#4488cc"
            }
        }

        Item { width: 1; height: 8 }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: count + " / " + Store.zikrTarget
            color: count >= Store.zikrTarget ? "#44cc88" : "#555555"
            font.pixelSize: 12
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
            text: "ANY KEY=count   #=undo   LEFT=menu"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
