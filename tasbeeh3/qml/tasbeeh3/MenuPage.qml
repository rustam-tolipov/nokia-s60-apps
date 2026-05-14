import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"
    focus: true

    property int sel: 0

    property variant items: [
        { label: "Zikr Counter",    url: "ZikrPage.qml"        },
        { label: "Tasbeeh 33x3x5",  url: "TasbeehPage.qml"     },
        { label: "Prayer Log",      url: "PrayerLogPage.qml"   },
        { label: "Zikr History",    url: "ZikrHistoryPage.qml" },
        { label: "Settings",        url: "SettingsPage.qml"    }
    ]

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No ||
                event.key === Qt.Key_Back  || event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        } else if (event.key === Qt.Key_Up) {
            if (sel > 0) sel--; event.accepted = true
        } else if (event.key === Qt.Key_Down) {
            if (sel < items.length - 1) sel++; event.accepted = true
        } else if (event.key === Qt.Key_Select || event.key === Qt.Key_Return ||
                   event.key === Qt.Key_Enter) {
            Nav.push(items[sel].url); event.accepted = true
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
            text: "MENU"; color: "#ffffff"; font.pixelSize: 15; font.bold: true
        }
    }

    Flickable {
        anchors.top: hdr.bottom; anchors.topMargin: 4
        anchors.bottom: footer.top; anchors.bottomMargin: 4
        width: parent.width
        contentHeight: menuCol.height
        clip: true

        Column {
            id: menuCol
            width: parent.width

            Repeater {
                model: items
                Rectangle {
                    width: parent.width; height: 46
                    color: sel === index ? "#1a2a1a" : "#111111"
                    Rectangle { width: 3; height: parent.height; color: sel === index ? "#44cc88" : "transparent" }
                    Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
                    Text {
                        anchors.left: parent.left; anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.label
                        color: sel === index ? "#ffffff" : "#888888"
                        font.pixelSize: 14; font.bold: sel === index
                    }
                    Text {
                        anchors.right: parent.right; anchors.rightMargin: 14
                        anchors.verticalCenter: parent.verticalCenter
                        text: ">"; color: sel === index ? "#44cc88" : "#2a2a2a"; font.pixelSize: 14
                    }
                }
            }
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
            text: "UP/DOWN=select   CENTER=open   BACK=close"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
