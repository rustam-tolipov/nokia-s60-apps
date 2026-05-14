import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    property int currentIndex: 0

    property variant pages: [
        { name: "Display",       url: "DisplayPage.qml",    color: "#cc4444" },
        { name: "Keypad",        url: "KeypadPage.qml",     color: "#cc8844" },
        { name: "Audio",         url: "AudioPage.qml",      color: "#44aacc" },
        { name: "Vibration",     url: "VibrationPage.qml",  color: "#8844cc" },
        { name: "Accelerometer", url: "AccelPage.qml",      color: "#44cc88" },
        { name: "Compass",       url: "CompassPage.qml",    color: "#44cc88" },
        { name: "GPS",           url: "GpsPage.qml",        color: "#ccaa44" },
        { name: "System Info",   url: "SystemInfoPage.qml", color: "#4488cc" },
        { name: "Storage",       url: "StoragePage.qml",    color: "#4488cc" },
        { name: "Network",       url: "NetworkPage.qml",    color: "#44aacc" }
    ]

    Keys.onPressed: {
        if (event.key === Qt.Key_Up) {
            if (currentIndex >= 2) currentIndex -= 2
            event.accepted = true
        } else if (event.key === Qt.Key_Down) {
            if (currentIndex + 2 < pages.length) currentIndex += 2
            event.accepted = true
        } else if (event.key === Qt.Key_Left) {
            if (currentIndex % 2 !== 0) currentIndex--
            event.accepted = true
        } else if (event.key === Qt.Key_Right) {
            if (currentIndex % 2 === 0 && currentIndex + 1 < pages.length) currentIndex++
            event.accepted = true
        } else if (event.key === Qt.Key_Select || event.key === Qt.Key_Return ||
                   event.key === Qt.Key_Enter  || event.key === Qt.Key_Space) {
            Nav.push(pages[currentIndex].url)
            event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text {
            anchors.centerIn: parent
            text: "S60 Diagnostic"
            color: "#ffffff"; font.pixelSize: 15; font.bold: true
        }
    }

    Rectangle {
        id: footer
        width: parent.width; height: 24
        anchors.bottom: parent.bottom
        color: "#0d0d0d"
        Rectangle { width: parent.width; height: 1; color: "#1a1a1a" }
        Text {
            anchors.centerIn: parent
            text: "ARROWS navigate   CENTER=open"
            color: "#333333"; font.pixelSize: 9
        }
    }

    Flickable {
        anchors.top: hdr.bottom; anchors.topMargin: 4
        anchors.bottom: footer.top; anchors.bottomMargin: 4
        width: parent.width
        contentHeight: grid.height
        clip: true

        Grid {
            id: grid
            anchors.left: parent.left; anchors.leftMargin: 4
            columns: 2
            spacing: 4

            Repeater {
                model: pages

                Rectangle {
                    width: (240 - 12) / 2
                    height: 46
                    color: currentIndex === index ? "#1e2e3e" : "#111111"
                    radius: 3

                    Rectangle {
                        width: parent.width; height: 3; radius: 2
                        color: modelData.color
                        opacity: currentIndex === index ? 1.0 : 0.35
                    }

                    Rectangle {
                        anchors.fill: parent; radius: 3
                        color: "transparent"
                        border.color: currentIndex === index ? modelData.color : "transparent"
                        border.width: 1
                    }

                    Text {
                        anchors.centerIn: parent
                        text: modelData.name
                        color: currentIndex === index ? "#ffffff" : "#777777"
                        font.pixelSize: 12
                        font.bold: currentIndex === index
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width - 8
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }
}
