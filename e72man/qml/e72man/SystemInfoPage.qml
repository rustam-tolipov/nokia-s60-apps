import QtQuick 1.0
import QtMobility.systeminfo 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    DeviceInfo { id: devInfo }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No || event.key === Qt.Key_Back || event.key === Qt.Key_Escape || event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "System Info"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.top: hdr.bottom
        width: parent.width

        Rectangle {
            width: parent.width; height: 34; color: "#111111"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "Manufacturer"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.manufacturer || "(empty)"; color: "#cccccc"; font.pixelSize: 12 }
        }
        Rectangle {
            width: parent.width; height: 34; color: "#0e0e0e"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "Model"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.model || "(empty)"; color: "#cccccc"; font.pixelSize: 12 }
        }
        Rectangle {
            width: parent.width; height: 34; color: "#111111"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "IMEI"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.imei || "(empty)"; color: "#cccccc"; font.pixelSize: 12 }
        }
        Rectangle {
            width: parent.width; height: 34; color: "#0e0e0e"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "Firmware"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.firmwareVersion || "(empty)"; color: "#cccccc"; font.pixelSize: 12 }
        }
        Rectangle {
            width: parent.width; height: 34; color: "#111111"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "OS"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.operatingSystem || "(empty)"; color: "#cccccc"; font.pixelSize: 12 }
        }
        Rectangle {
            width: parent.width; height: 34; color: "#0e0e0e"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "Battery"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.batteryLevel + "%"; color: "#cccccc"; font.pixelSize: 12 }
        }
        Rectangle {
            width: parent.width; height: 34; color: "#111111"
            Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                   text: "Charging"; color: "#666666"; font.pixelSize: 12; width: 90 }
            Text { anchors.left: parent.left; anchors.leftMargin: 102; anchors.verticalCenter: parent.verticalCenter
                   text: devInfo.powerState === DeviceInfo.WallPowerChargingBattery ? "Yes" : "No"
                   color: "#cccccc"; font.pixelSize: 12 }
        }
    }
}
