import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"
    focus: true

    property int maxCount: 1

    property variant historyData: {
        var today = new Date()
        var rows = []
        var mx = 1
        for (var i = 0; i < 30; i++) {
            var d = new Date(today)
            d.setDate(today.getDate() - i)
            var ds = Qt.formatDate(d, "yyyy-MM-dd")
            var dl = Qt.formatDate(d, "ddd d MMM")
            var c  = Store.zikrCount(ds)
            if (c > mx) mx = c
            rows.push({ date: ds, label: dl, count: c })
        }
        maxCount = mx
        return rows
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No ||
                event.key === Qt.Key_Back  || event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
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
        Text { anchors.centerIn: parent; text: "ZIKR HISTORY"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Flickable {
        anchors.top: hdr.bottom; anchors.topMargin: 4
        anchors.bottom: footer.top; anchors.bottomMargin: 4
        width: parent.width
        contentHeight: histCol.height
        clip: true

        Column {
            id: histCol
            width: parent.width

            Repeater {
                model: historyData
                Rectangle {
                    width: parent.width; height: 34
                    color: index % 2 === 0 ? "#111111" : "#0e0e0e"

                    Row {
                        anchors.left: parent.left; anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8

                        Text {
                            text: modelData.label
                            color: modelData.count > 0 ? "#999999" : "#2a2a2a"
                            font.pixelSize: 12; width: 80
                        }
                        Text {
                            text: modelData.count > 0 ? modelData.count : ""
                            color: modelData.count >= Store.zikrTarget ? "#44cc88" : "#4488cc"
                            font.pixelSize: 12; width: 34
                            horizontalAlignment: Text.AlignRight
                        }
                        Rectangle {
                            width: 68; height: 6; radius: 3; color: "#1a1a1a"
                            anchors.verticalCenter: parent.verticalCenter
                            Rectangle {
                                width: modelData.count > 0 ? Math.max(4, 68 * modelData.count / Math.max(1, maxCount)) : 0
                                height: parent.height; radius: 3
                                color: modelData.count >= Store.zikrTarget ? "#44cc88" : "#4488cc"
                            }
                        }
                    }

                    Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#191919" }
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
            text: "D-PAD=scroll   BACK=exit"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
