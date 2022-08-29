import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import Qt.labs.platform 1.1
import "../components"

Rectangle {
    id: root
    color: display.colorStyle ? "#a0e0e0e0":"#d02a2a2a"
    Behavior on color {
        ColorAnimation {
            duration: 280
        }
    }
    height: display.blindMode? 32 : 64

    Rectangle {
        color: display.colorStyle ? "#a0dddddd":"#d0323232"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        Behavior on color {
            ColorAnimation {
                duration: 280
            }
        }
    }

    PushButton {
        id: titleButton
        icon: "qrc:/assets/apps.svg"
        text: "随机点名"
        border.color: "transparent"
        flat: true
        iconSize: 16
        height: 32
        anchors.left: parent.left
        anchors.top: parent.top
    }

    TextLabel {
        text: "距离高考还有 " + dataMgr.timeLeft + " 天"
        showIcon: false
        anchors.right: parent.right
        anchors.rightMargin: 32
        anchors.bottom: parent.bottom
        visible: !display.blindMode
        height: 32
    }

    IconButton {
        id: closeButton
        icon: "qrc:/assets/close.svg"
        iconSize: 16
        pressedColor: "#ccee0000"
        hoverColor: "#aaff0000"
        border.color: "transparent"
        flat: true
        anchors.right: parent.right
        anchors.top: parent.top
        width: 48
        height: 32
        onClicked: {
            if (window.visibility === Window.FullScreen) {
                window.showNormal()
                display.blindMode = false
                display.colorStyle = true
                dataMgr.enabledPlaces = 4
            } else {
                window.close()
            }
        }
    }

    IconButton {
        id: minimizeButton
        icon: "qrc:/assets/minimize.svg"
        iconSize: 16
        flat: true
        anchors.right: closeButton.left
        anchors.top: parent.top
        border.color: "transparent"
        width: 48
        height: 32
        visible: !display.blindMode
        onClicked: {
            window.showMinimized();
        }
    }

    IconButton {
        id: blindModeButton
        icon: display.blindMode? "qrc:/assets/exit-fullscreen.svg" : "qrc:/assets/enter-fullscreen.svg"
        iconSize: 16
        flat: true
        anchors.right: minimizeButton.left
        anchors.top: parent.top
        border.color: "transparent"
        width: 48
        height: 32
        visible: !display.blindMode
        onClicked: {
            display.blindMode = !display.blindMode
            display.colorStyle = false
            dataMgr.enabledPlaces = 1
            display.activeTabIndex = 0
            indicator.state = "randomPage"
            window.showFullScreen()
        }
    }

    PushButton {
        id: randomPageButton
        text: "点名"
        border.color: "transparent"
        flat: true
        showIcon: false
        height: 32
        width: 72
        visible: !display.blindMode
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.bottom: parent.bottom
        onClicked: {
            display.activeTabIndex = 0
            indicator.state = "randomPage"
        }
    }

    PushButton {
        id: settingPageButton
        text: "设置"
        border.color: "transparent"
        flat: true
        showIcon: false
        height: 32
        width: 72
        visible: !display.blindMode
        anchors.left: randomPageButton.right
        anchors.bottom: parent.bottom
        onClicked: {
            display.activeTabIndex = 1
            indicator.state = "settingPage"
        }
    }

    PushButton {
        id: aboutPageButton
        text: "关于"
        border.color: "transparent"
        flat: true
        showIcon: false
        height: 32
        width: 72
        visible: !display.blindMode
        anchors.left: settingPageButton.right
        anchors.bottom: parent.bottom
        onClicked: {
            display.activeTabIndex = 2
            indicator.state = "aboutPage"
        }
    }

    Rectangle {
        id: indicator
        color: display.themeColor
        height: 4
        width: 32
        visible: !display.blindMode
        anchors.bottom: parent.bottom
        state: "randomPage"

        states: [
            State {
                name: "randomPage"
                AnchorChanges { target: indicator; anchors.horizontalCenter: randomPageButton.horizontalCenter }
            },
            State {
                name: "settingPage"
                AnchorChanges { target: indicator; anchors.horizontalCenter: settingPageButton.horizontalCenter }
            },
            State {
                name: "aboutPage"
                AnchorChanges { target: indicator; anchors.horizontalCenter: aboutPageButton.horizontalCenter }
            }
        ]

        transitions: Transition {
            AnchorAnimation {
                duration: 240
                easing.type: Easing.OutExpo
            }
        }
    }

    DragHandler {
        grabPermissions: TapHandler.DragThreshold
        onActiveChanged: {
            if (active) {
                window.startSystemMove();
            }
        }
    }
}
