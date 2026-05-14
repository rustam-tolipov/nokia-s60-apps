import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    focus: true

    property int idx: 0
    property variant cols:  ["#ff0000", "#00ff00", "#0000ff", "#ffffff", "#000000"]
    property variant names: ["RED",     "GREEN",   "BLUE",    "WHITE",   "BLACK"]

    color: cols[idx]

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        } else if (event.key === Qt.Key_Select || event.key === Qt.Key_Return) {
            if (idx < cols.length - 1) idx++
            else Nav.pop()
            event.accepted = true
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top; anchors.topMargin: 12
        text: names[idx]
        color: idx === 3 ? "#000000" : "#ffffff"
        font.pixelSize: 18; font.bold: true
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 12
        text: (idx + 1) + " / " + cols.length + "   CENTER=next   BACK=exit"
        color: idx === 3 ? "#000000" : "#555555"
        font.pixelSize: 10
    }
}
