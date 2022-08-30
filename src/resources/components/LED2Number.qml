import QtQuick 2.15
import QtQml 2.15

Rectangle {
    id: root
    color: "transparent"

    property int displayNum: 0
    property string displayName: "- - -"
    property bool loading: false

    opacity: enabled ? 1 : 0.3

    Timer {
        id: timer
        interval: 100
        repeat: true
        running: root.loading && enabled
        onTriggered: {
            root.displayNum = Math.random() * 100
        }
    }

    LED {
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: root.loading ? 32 : 0
        height: parent.height - 64
        anchors.margins: 4
        num: Math.floor(root.displayNum / 10) % 10
        opacity: root.loading ? 0.7 : 1
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }

    LED {
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: root.loading ? 32 : 0
        height: parent.height - 64
        anchors.margins: 4
        num: Math.floor(root.displayNum / 1) % 10
        opacity: root.loading ? 0.7 : 1
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
        Behavior on anchors.topMargin {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }

    TextLabel {
        id: nameLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.loading ? 64 : 32
        text: root.displayName
        fontSize: 24
        showIcon: false
        bold: true
        opacity: root.loading ? 0 : 1
        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
        Behavior on anchors.bottomMargin {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutQuad
            }
        }
    }

    onEnabledChanged: {
        if (!enabled) {
            displayNum = 0
            displayName = "- - -"
        } else {
            displayNum = 0
            displayName = "- - -"
        }
    }

    onLoadingChanged: {
        if (!loading) {
            let student = dataMgr.getRandomStudent()
            displayNum = student["no"]
            displayName = student["name"]
        }
    }
}
