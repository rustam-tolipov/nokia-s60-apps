import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    color: "#111111"
    focus: true

    property string currentDate: Qt.formatDate(new Date(), "yyyy-MM-dd")
    property int    sel: 0

    property variant prayers: ["bomdod", "peshin", "asr", "shom", "xufton"]
    property variant labels:  ["Bomdod", "Peshin", "Asr", "Shom", "Xufton"]

    property int s0: Store.namazStatus(currentDate, "bomdod")
    property int s1: Store.namazStatus(currentDate, "peshin")
    property int s2: Store.namazStatus(currentDate, "asr")
    property int s3: Store.namazStatus(currentDate, "shom")
    property int s4: Store.namazStatus(currentDate, "xufton")

    property int q0: Store.qazaBalance("bomdod")
    property int q1: Store.qazaBalance("peshin")
    property int q2: Store.qazaBalance("asr")
    property int q3: Store.qazaBalance("shom")
    property int q4: Store.qazaBalance("xufton")

    function refreshStatuses() {
        s0 = Store.namazStatus(currentDate, "bomdod")
        s1 = Store.namazStatus(currentDate, "peshin")
        s2 = Store.namazStatus(currentDate, "asr")
        s3 = Store.namazStatus(currentDate, "shom")
        s4 = Store.namazStatus(currentDate, "xufton")
        q0 = Store.qazaBalance("bomdod")
        q1 = Store.qazaBalance("peshin")
        q2 = Store.qazaBalance("asr")
        q3 = Store.qazaBalance("shom")
        q4 = Store.qazaBalance("xufton")
    }

    function statusOf(i) {
        if (i === 0) return s0; if (i === 1) return s1; if (i === 2) return s2
        if (i === 3) return s3; return s4
    }

    function offsetDate(base, days) {
        var p = base.split("-")
        var d = new Date(parseInt(p[0]), parseInt(p[1])-1, parseInt(p[2]))
        d.setDate(d.getDate() + days)
        return Qt.formatDate(d, "yyyy-MM-dd")
    }

    function displayDate(ds) {
        var p = ds.split("-")
        return Qt.formatDate(new Date(parseInt(p[0]), parseInt(p[1])-1, parseInt(p[2])), "ddd d MMM")
    }

    function statusColor(s) {
        if (s === 1) return "#44aa44"
        if (s === 2) return "#cc6600"
        return "#333333"
    }

    function statusLabel(s) {
        if (s === 1) return "Done"
        if (s === 2) return "Qaza"
        return "—"
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Backspace || event.key === Qt.Key_No ||
                event.key === Qt.Key_Back  || event.key === Qt.Key_Escape ||
                event.key === Qt.Key_Context2) {
            Nav.pop(); event.accepted = true
        } else if (event.key === Qt.Key_Up) {
            if (sel > 0) sel--; event.accepted = true
        } else if (event.key === Qt.Key_Down) {
            if (sel < prayers.length - 1) sel++; event.accepted = true
        } else if (event.key === Qt.Key_Left) {
            currentDate = offsetDate(currentDate, -1); refreshStatuses(); event.accepted = true
        } else if (event.key === Qt.Key_Right) {
            currentDate = offsetDate(currentDate, 1); refreshStatuses(); event.accepted = true
        } else if (event.key === Qt.Key_Select || event.key === Qt.Key_Return ||
                   event.key === Qt.Key_Enter) {
            var cur = Store.namazStatus(currentDate, prayers[sel])
            Store.setNamazStatus(currentDate, prayers[sel], (cur + 1) % 3)
            refreshStatuses()
            event.accepted = true
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
        Text { anchors.centerIn: parent; text: "PRAYER LOG"; color: "#ffffff"; font.pixelSize: 15; font.bold: true }
    }

    Row {
        id: dateRow
        anchors.top: hdr.bottom; anchors.topMargin: 6
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8
        Text { text: "<"; color: "#555555"; font.pixelSize: 15; font.bold: true }
        Text { text: displayDate(currentDate); color: "#ccaa44"; font.pixelSize: 13; font.bold: true }
        Text { text: ">"; color: "#555555"; font.pixelSize: 15; font.bold: true }
    }

    Flickable {
        id: prayerList
        anchors.top: dateRow.bottom; anchors.topMargin: 4
        anchors.bottom: qazaSection.top; anchors.bottomMargin: 4
        width: parent.width
        contentHeight: prayerCol.height
        clip: true

        Column {
            id: prayerCol
            width: parent.width

            Repeater {
                model: 5
                Rectangle {
                    width: parent.width; height: 36
                    color: sel === index ? "#1a1a2a" : (index % 2 === 0 ? "#111111" : "#0e0e0e")
                    Rectangle { width: 3; height: parent.height; color: sel === index ? "#4488cc" : "transparent" }
                    Rectangle { width: parent.width; height: 1; anchors.bottom: parent.bottom; color: "#1a1a1a" }
                    Text {
                        anchors.left: parent.left; anchors.leftMargin: 14
                        anchors.verticalCenter: parent.verticalCenter
                        text: labels[index]
                        color: sel === index ? "#ffffff" : "#888888"
                        font.pixelSize: 13; font.bold: sel === index
                    }
                    Text {
                        anchors.right: parent.right; anchors.rightMargin: 14
                        anchors.verticalCenter: parent.verticalCenter
                        text: statusLabel(statusOf(index))
                        color: statusColor(statusOf(index))
                        font.pixelSize: 13; font.bold: true
                    }
                }
            }
        }
    }

    Column {
        id: qazaSection
        anchors.bottom: footer.top; anchors.bottomMargin: 4
        anchors.left: parent.left; anchors.leftMargin: 14
        spacing: 2

        Text { text: "Qaza balance:"; color: "#444444"; font.pixelSize: 11 }
        Row {
            spacing: 8
            Text { text: "Bom:" + q0; color: q0 > 0 ? "#cc6600" : "#2a2a2a"; font.pixelSize: 11 }
            Text { text: "Pes:" + q1; color: q1 > 0 ? "#cc6600" : "#2a2a2a"; font.pixelSize: 11 }
            Text { text: "Asr:" + q2; color: q2 > 0 ? "#cc6600" : "#2a2a2a"; font.pixelSize: 11 }
            Text { text: "Shm:" + q3; color: q3 > 0 ? "#cc6600" : "#2a2a2a"; font.pixelSize: 11 }
            Text { text: "Xuf:" + q4; color: q4 > 0 ? "#cc6600" : "#2a2a2a"; font.pixelSize: 11 }
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
            text: "UP/DOWN=prayer   LEFT/RIGHT=day   CENTER=toggle"
            color: "#333333"; font.pixelSize: 9
        }
    }
}
