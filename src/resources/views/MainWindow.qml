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
        anchors.fill: display.blindMode? undefined : parent
        anchors.margins: display.blindMode? 0 : (window.visibility === Window.Windowed ? 10 : 0)
        anchors.centerIn: display.blindMode? parent : undefined
        width: display.blindMode? 200 : undefined
        height: display.blindMode? 340 : undefined
        border.width: display.blindMode? 1 : (window.visibility === Window.Windowed ? 1 : 0)
        border.color: "#40606060"
        color: display.colorStyle? "#e0e0e0" : "#242424"

        Behavior on color {
            ColorAnimation {
                duration: 280
            }
        }

        PageStack {
            id: pageStack
            anchors.left: titleBar.left
            anchors.top: titleBar.bottom
            anchors.bottom: parent.bottom
            anchors.right: titleBar.right
            anchors.bottomMargin: window.visibility === Window.Windowed ? 1 : 0
        }

        TitleBar {
            id: titleBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: window.visibility === Window.Windowed ? 1 : 0
            anchors.rightMargin: window.visibility === Window.Windowed ? 1 : 0
            anchors.leftMargin: window.visibility === Window.Windowed ? 1 : 0
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
