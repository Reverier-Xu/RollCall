import QtQuick 2.15
import "qrc:/components"

Rectangle {
    id: root
    color: display.colorStyle? "white" : "#1b1b1b"

    Behavior on color {
        ColorAnimation {
            duration: 280
        }
    }
}
