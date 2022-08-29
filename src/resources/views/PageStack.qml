import QtQuick 2.15
import QtQuick.Layouts 1.15
import "qrc:/components"

Rectangle {
    id: root
    color: display.colorStyle? "#ffffff" : "#1b1b1b"

    Behavior on color {
        ColorAnimation {
            duration: 280
        }
    }

    StackLayout {
        id: stack
        anchors.fill: parent
        currentIndex: display.activeTabIndex

        RandomPage { }
        SettingPage { }
        AboutPage { }
    }
}
