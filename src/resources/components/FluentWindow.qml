import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    flags: Qt.Window | Qt.FramelessWindowHint
    visible: true
    color: display.blindMode? "black" : "transparent"

    property bool style: true

    Component.onCompleted: {
        setX(Screen.width / 2 - width / 2)
        setY(Screen.height / 2 - height / 2)
    }
}
