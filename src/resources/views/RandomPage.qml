import QtQuick 2.15
import "qrc:/components"

Rectangle {
    id: root
    color: display.colorStyle? "white" : "#1b1b1b"

    property bool isRanding: false

    Behavior on color {
        ColorAnimation {
            duration: 280
        }
    }

    LED2Number {
        id: led1
        anchors.top: parent.top
        anchors.topMargin: 56
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: display.blindMode ? -(width / 2) : ((parent.width - 400) /  10)
        width: 100
        height: 164
        loading: root.isRanding
    }

    LED2Number {
        id: led2
        anchors.top: parent.top
        anchors.topMargin: 56
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: (parent.width - 400) /  10
        width: 100
        height: 164
        loading: root.isRanding
        enabled: dataMgr.enabledPlaces > 1
        visible: !display.blindMode
    }

    LED2Number {
        id: led3
        anchors.top: parent.top
        anchors.topMargin: 56
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - 400) /  5
        width: 100
        height: 164
        loading: root.isRanding
        enabled: dataMgr.enabledPlaces > 2
        visible: !display.blindMode
    }

    LED2Number {
        id: led4
        anchors.top: parent.top
        anchors.topMargin: 56
        anchors.right: parent.right
        anchors.rightMargin: (parent.width - 400) /  5
        width: 100
        height: 164
        loading: root.isRanding
        enabled: dataMgr.enabledPlaces > 3
        visible: !display.blindMode
    }

    Timer {
        id: animTimer
        interval: 2000
        repeat: false
        onTriggered: {
            root.isRanding = !root.isRanding
        }
    }

    PushButton {
        id: startButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: led1.bottom
        enabled: !root.isRanding
        anchors.topMargin: root.isRanding ? 42 : 20
        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
        opacity: root.isRanding ? 0 : 1
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
        height: 48
        width: 160
        showIcon: false
        text: "开始"
        onClicked: {
            root.isRanding = !root.isRanding
            animTimer.start()
        }
    }

    IconButton {
        id: addButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.bottomMargin: 32
        height: 48
        width: 48
        iconSize: 24
        flat: true
        icon: "qrc:/assets/add.svg"
        visible: !display.blindMode
        enabled: !root.isRanding && dataMgr.enabledPlaces < 4
        onClicked: {
            dataMgr.enabledPlaces++
            if (dataMgr.enabledPlaces > 4) {
                dataMgr.enabledPlaces = 4
            }
        }
    }

    TextLabel {
        id: enabledCountLabel
        anchors.bottom: parent.bottom
        anchors.right: addButton.left
        anchors.bottomMargin: 32
        height: 48
        width: 48
        showIcon: false
        text: dataMgr.enabledPlaces
        fontSize: 24
        visible: !display.blindMode
    }

    IconButton {
        id: subButton
        anchors.bottom: parent.bottom
        anchors.right: enabledCountLabel.left
        anchors.bottomMargin: 32
        height: 48
        width: 48
        flat: true
        icon: "qrc:/assets/minimize.svg"
        enabled: !root.isRanding && dataMgr.enabledPlaces > 1
        iconSize: 24
        visible: !display.blindMode
        onClicked: {
            dataMgr.enabledPlaces--
            if (dataMgr.enabledPlaces < 1) {
                dataMgr.enabledPlaces = 1
            }
        }
    }
}
