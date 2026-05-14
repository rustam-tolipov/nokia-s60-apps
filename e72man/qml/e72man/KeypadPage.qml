import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property string lastKey: "(none)"
    property int    keyCode: 0
    property int    count:   0

    function keyName(k) {
        if (k === Qt.Key_Up)      return "D-pad Up"
        if (k === Qt.Key_Down)    return "D-pad Down"
        if (k === Qt.Key_Left)    return "D-pad Left"
        if (k === Qt.Key_Right)   return "D-pad Right"
        if (k === Qt.Key_Select)  return "D-pad Center"
        if (k === Qt.Key_Return)  return "Enter"
        if (k === Qt.Key_0)       return "Key 0"
        if (k === Qt.Key_1)       return "Key 1"
        if (k === Qt.Key_2)       return "Key 2"
        if (k === Qt.Key_3)       return "Key 3"
        if (k === Qt.Key_4)       return "Key 4"
        if (k === Qt.Key_5)       return "Key 5"
        if (k === Qt.Key_6)       return "Key 6"
        if (k === Qt.Key_7)       return "Key 7"
        if (k === Qt.Key_8)       return "Key 8"
        if (k === Qt.Key_9)       return "Key 9"
        if (k === Qt.Key_Asterisk)   return "Key *"
        if (k === Qt.Key_NumberSign) return "Key #"
        if (k === Qt.Key_Context1)   return "Left Softkey"
        if (k === Qt.Key_Context2)   return "Right Softkey"
        if (k === Qt.Key_Call)       return "Call key"
        if (k === Qt.Key_Hangup)     return "End key"
        if (k === Qt.Key_Backspace)  return "Back/C key"
        return "Code: " + k
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true; return
        }
        lastKey = keyName(event.key)
        keyCode = event.key
        count++
        event.accepted = true
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Keypad Test"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: lastKey
            color: "#4488cc"; font.pixelSize: 22; font.bold: true
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "code: " + keyCode
            color: "#666666"; font.pixelSize: 12
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "presses: " + count
            color: "#888888"; font.pixelSize: 14
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "Press any key   BACK=exit"
        color: "#333333"; font.pixelSize: 10
    }
}
