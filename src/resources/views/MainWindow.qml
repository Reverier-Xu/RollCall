import QtQuick 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import "qrc:/components"

FluentWindow {
    id: window
    objectName: "mainWindow"
    width: 800
    minimumWidth: 800
    height: 420
    minimumHeight: 420

    KeyTapEvent {
        id: exitAppEvent
        customKey: "Ctrl+Q"
        onClicked: {
            Qt.exit(0);
        }
    }

    Rectangle {
        id: centralWidget
        anchors.fill: parent
        anchors.margins: window.visibility === Window.Windowed ? 10 : 0
        border.width: window.visibility === Window.Windowed ? 1 : 0
        border.color: "#40606060"
        color: display.colorStyle? "#e0e0e0" : "#242424"

        Behavior on color {
            ColorAnimation {
                duration: 280
            }
        }

        PageStack {
            id: pageStack
            anchors.left: parent.left
            anchors.top: titleBar.top
            anchors.bottom: parent.bottom
            anchors.right: titleBar.right
        }

        TitleBar {
            id: titleBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: window.visibility === Window.Windowed ? 1 : 0
            anchors.rightMargin: window.visibility === Window.Windowed ? 1 : 0
        }
    }

    Connections {
        target: display
        function onRaiseWindowRequested() {
            window.show();
            window.raise();
            window.requestActivate();
        }
    }
}
