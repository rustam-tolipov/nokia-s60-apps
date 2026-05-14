import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"
    focus: true

    property int    sel: 0
    property string statusMsg: ""

    property variant speedOptions: [50, 150, 400]
    property variant speedLabels:  ["Fast", "Normal", "Slow"]

    function speedIndex() {
        for (var i = 0; i < speedOptions.length; i++)
            if (speedOptions[i] === Store.counterSpeed) return i
        return 1
    }

    Timer { id: statusTimer; interval: 2500; onTriggered: statusMsg = "" }
    function showStatus(msg) { statusMsg = msg; statusTimer.restart() }

    property variant items: [
        { label: "Counter Speed", type: "speed"  },
        { label: "Zikr Goal",     type: "goal"   },
        { label: "Export to E:",  type: "export" },
        { label: "Import from E:", type: "import" }
    ]

    function valueFor(type) {
        if (type === "speed") return speedLabels[speedIndex()]
        if (type === "goal")  return Store.zikrTarget
        return ""
    }

    function activate(type) {
        if (type === "export") {
            var p = Store.exportData()
            showStatus(p.length > 0 ? "Saved: " + p : "Export failed")
        } else if (type === "import") {
            var n = Store.importData()
            showStatus(n.length > 0 ? "Imported " + n + " keys" : "No file / failed")
        }
    }

    function adjustLeft(type) {
        if (type === "speed") {
            var i = speedIndex(); if (i > 0) Store.counterSpeed = speedOptions[i-1]
        } else if (type === "goal") {
            if (Store.zikrTarget > 100) Store.zikrTarget = Store.zikrTarget - 100
        }
    }

    function adjustRight(type) {
        if (type === "speed") {
            var i = speedIndex(); if (i < speedOptions.length-1) Store.counterSpeed = speedOptions[i+1]
        } else if (type === "goal") {
            Store.zikrTarget = Store.zikrTarget + 100
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No ||
                event.key === Qt.Key_Back  || event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        } else if (event.key === Qt.Key_Up) {
            if (sel > 0) sel--; event.accepted = true
        } else if (event.key === Qt.Key_Down) {
            if (sel < items.length-1) sel++; event.accepted = true
        } else if (event.key === Qt.Key_Left) {
            adjustLeft(items[sel].type); event.accepted = true
        } else if (event.key === Qt.Key_Right) {
            adjustRight(items[sel].type); event.accepted = true
        } else if (event.key === Qt.Key_Select || event.key === Qt.Key_Return ||
                   event.key === Qt.Key_Enter) {
            activate(items[sel].type); event.accepted = true
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
        Text { anchors.centerIn: parent; text: "SETTINGS"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.top: hdr.bottom
        width: parent.width

        Repeater {
            model: items
            Rectangle {
                width: parent.width; height: 40
                color: sel === index ? "#1a2a3a" : (index % 2 === 0 ? "#111111" : "#0e0e0e")
                Rectangle { width: 3; height: parent.height; color: sel === index ? "#4488cc" : "transparent" }
                Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.label
                    color: sel === index ? "#ffffff" : "#888888"
                    font.pixelSize: 13; width: 130
                }
                Text {
                    anchors.right: parent.right; anchors.rightMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    text: valueFor(modelData.type)
                    color: "#4488cc"; font.pixelSize: 13
                }
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: footer.top; anchors.bottomMargin: 6
        text: statusMsg
        color: "#44cc88"; font.pixelSize: 11
        visible: statusMsg.length > 0
    }

    Rectangle {
        id: footer
        width: parent.width; height: 24
        anchors.bottom: parent.bottom
        color: "#0a0a0a"
        Rectangle { width: parent.width; height: 1; color: "#1a1a1a" }
        Text {
            anchors.centerIn: parent
            text: "UP/DOWN=select   LEFT/RIGHT=change   CENTER=action"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
