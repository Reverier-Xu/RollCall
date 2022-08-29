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
    height: 64

    Rectangle {
        color: display.colorStyle ? "#a0dddddd":"#d0383838"
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
        icon: "qrc:/assets/simulation.svg"
        text: "Roll Call"
        border.color: "transparent"
        flat: true
        height: 32
        anchors.left: parent.left
        anchors.top: parent.top
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
            window.close();
        }
    }

    IconButton {
        id: maximizeButton
        icon: window.visibility === Window.Windowed?"qrc:/assets/maximize.svg":"qrc:/assets/restore.svg"
        iconSize: 16
        flat: true
        anchors.right: closeButton.left
        anchors.top: parent.top
        border.color: "transparent"
        width: 48
        height: 32
        onClicked: {
            if (window.visibility === Window.Maximized || window.visibility === Window.FullScreen)
                window.showNormal();
            else
                window.showMaximized();
        }
    }

    IconButton {
        id: minimizeButton
        icon: "qrc:/assets/minimize.svg"
        iconSize: 16
        flat: true
        anchors.right: maximizeButton.left
        anchors.top: parent.top
        border.color: "transparent"
        width: 48
        height: 32
        onClicked: {
            window.showMinimized();
        }
    }

    IconButton {
        id: colorStyleButton
        icon: display.colorStyle ? "qrc:/assets/sun.svg" : "qrc:/assets/moon.svg"
        iconSize: 16
        flat: true
        anchors.right: minimizeButton.left
        anchors.top: parent.top
        border.color: "transparent"
        width: 48
        height: 32
        onClicked: {
            display.colorStyle = !display.colorStyle
        }
    }

    TapHandler {
        onTapped: if (tapCount === 2) toggleMaximized();
        gesturePolicy: TapHandler.DragThreshold
    }

    DragHandler {
        grabPermissions: TapHandler.DragThreshold
        onActiveChanged: {
            if (active) {
                window.startSystemMove();
            }
        }
    }

    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                // console.log("hovered");
                display.blockDelayedHide();
            } else {
                // console.log("unhovered");
                display.delayedHide();
            }
        }
    }
}
