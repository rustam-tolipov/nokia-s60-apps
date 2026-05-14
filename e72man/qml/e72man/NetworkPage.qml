import QtQuick 1.0
import QtMobility.systeminfo 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    NetworkInfo { id: netInfo }

    function statusLabel(s) {
        if (s === NetworkInfo.HomeNetwork)        return "Home network"
        if (s === NetworkInfo.NoNetworkAvailable) return "No network"
        if (s === NetworkInfo.Connected)          return "Connected"
        if (s === NetworkInfo.Searching)          return "Searching"
        if (s === NetworkInfo.Busy)               return "Busy"
        if (s === NetworkInfo.Roaming)            return "Roaming"
        return "Unknown"
    }

    function modeLabel(m) {
        if (m === NetworkInfo.GsmMode)       return "GSM"
        if (m === NetworkInfo.WlanMode)      return "WiFi"
        if (m === NetworkInfo.BluetoothMode) return "Bluetooth"
        if (m === NetworkInfo.EthernetMode)  return "Ethernet"
        if (m === NetworkInfo.WimaxMode)     return "WiMAX"
        if (m === NetworkInfo.CdmaMode)      return "CDMA"
        if (m === NetworkInfo.WcdmaMode)     return "WCDMA"
        return "Unknown"
    }

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
        Text { anchors.centerIn: parent; text: "Network"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Column {
        anchors.top: hdr.bottom; anchors.topMargin: 16
        anchors.left: parent.left; anchors.right: parent.right
        anchors.leftMargin: 14; anchors.rightMargin: 14
        spacing: 6

        Text { text: "Active Network"; color: "#4488cc"; font.pixelSize: 13; font.bold: true }

        Rectangle {
            width: parent.width; height: 1; color: "#2a2a2a"
        }

        Row {
            spacing: 6
            Text { text: "Mode:";   color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: modeLabel(netInfo.networkMode); color: "#cccccc"; font.pixelSize: 13 }
        }
        Row {
            spacing: 6
            Text { text: "Status:"; color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: statusLabel(netInfo.networkStatus); color: "#cccccc"; font.pixelSize: 13 }
        }
        Row {
            spacing: 6
            Text { text: "Name:";   color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: netInfo.networkName || "(none)"; color: "#cccccc"; font.pixelSize: 13 }
        }
        Row {
            spacing: 6
            Text { text: "Signal:"; color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: netInfo.networkSignalStrength + "%"; color: "#cccccc"; font.pixelSize: 13 }
        }
        Row {
            spacing: 6
            Text { text: "MAC:";    color: "#666666"; font.pixelSize: 13; width: 80 }
            Text { text: netInfo.macAddress || "(none)"; color: "#cccccc"; font.pixelSize: 13
                   width: parent.parent.width - 86; wrapMode: Text.WrapAnywhere }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        text: "BACK=exit"
        color: "#333333"; font.pixelSize: 9
    }
}
