import QtQuick 1.0
import QtMobility.systeminfo 1.1

Rectangle {
    anchors.fill: parent
    color: "#161616"
    focus: true

    BatteryInfo { id: bat }

    Timer { interval: 5000; running: true; repeat: true; onTriggered: { bat.nominalCapacity; bat.remainingCapacityPercent } }

    function pct()          { return bat.remainingCapacityPercent }
    function pctColor()     { var p = pct(); if (p > 50) return "#44cc44"; if (p > 20) return "#cc8844"; return "#cc4444" }
    function mV()           { var v = bat.voltage;              return v > 0 ? v + " mV"  : "N/A" }
    function mA()           { var c = bat.currentFlow;          return c >= 0 ? "+" + c + " mA" : c + " mA" }
    function mAhNom()       { var n = bat.nominalCapacity;      return n > 0 ? n + " mAh" : "N/A" }
    function mAhRem()       { var r = bat.remainingCapacity;    return r >= 0 ? r + " mAh" : "N/A" }
    function chargeTime()   {
        var s = bat.remainingChargingTime
        if (s <= 0) return "N/A"
        if (s < 60) return s + " sec"
        return Math.floor(s / 60) + " min"
    }
    function chargeState()  {
        var s = bat.chargingState
        if (s === 1) return "Charging"
        if (s === 2) return "Full"
        if (s === 3) return "Discharging"
        if (s === 4) return "Error"
        return "Not charging"
    }
    function chargerType()  {
        var t = bat.chargerType
        if (t === 1) return "None"
        if (t === 2) return "Wall"
        if (t === 3) return "USB"
        if (t === 4) return "Variable"
        return "Unknown"
    }
    function bars()         { return bat.remainingCapacityBars + " / " + bat.maxBars }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No ||
                event.key === Qt.Key_Back  || event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        }
    }

    Rectangle {
        id: hdr
        width: parent.width; height: 44; color: "#111111"
        Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#2a2a2a" }
        Text { anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
               text: "Back"; color: "#888888"; font.pixelSize: 12 }
        Text { anchors.centerIn: parent; text: "Battery"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Rectangle {
        id: bigDisplay
        anchors.top: hdr.bottom; anchors.topMargin: 8
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 24; height: 72
        color: "#111111"; radius: 6

        Text {
            anchors.centerIn: parent
            text: pct() + "%"
            color: pctColor()
            font.pixelSize: 36; font.bold: true
        }

        Rectangle {
            anchors.bottom: parent.bottom; anchors.bottomMargin: 6
            anchors.left: parent.left; anchors.leftMargin: 12
            anchors.right: parent.right; anchors.rightMargin: 12
            height: 6; radius: 3
            color: "#1a1a1a"

            Rectangle {
                width: Math.max(6, parent.width * pct() / 100)
                height: parent.height; radius: 3
                color: pctColor()
            }
        }
    }

    Flickable {
        anchors.top: bigDisplay.bottom; anchors.topMargin: 6
        anchors.bottom: footer.top; anchors.bottomMargin: 2
        width: parent.width
        contentHeight: rows.height
        clip: true

        Column {
            id: rows
            width: parent.width

            Repeater {
                model: [
                    { label: "Voltage",    val: mV()        },
                    { label: "Current",    val: mA()        },
                    { label: "Capacity",   val: mAhNom()    },
                    { label: "Remaining",  val: mAhRem()    },
                    { label: "Charge time",val: chargeTime() },
                    { label: "State",      val: chargeState() },
                    { label: "Charger",    val: chargerType() },
                    { label: "Bars",       val: bars()      }
                ]
                Rectangle {
                    width: parent.width; height: 30
                    color: index % 2 === 0 ? "#111111" : "#0e0e0e"
                    Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
                    Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter
                           text: modelData.label; color: "#666666"; font.pixelSize: 12; width: 88 }
                    Text { anchors.left: parent.left; anchors.leftMargin: 100; anchors.verticalCenter: parent.verticalCenter
                           text: modelData.val; color: "#cccccc"; font.pixelSize: 12 }
                }
            }
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
            text: "refreshes every 5s   BACK=exit"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
