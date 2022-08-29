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

    TextLabel {
        id: titleLabel
        text: "随机点名 Ver 15.0"
        iconSize: 32
        icon: "qrc:/assets/logo.svg"
        noOverlay: true
        fontSize: 24
        height: 64
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
    }

    TextLabel {
        id: supportLabel
        text: "https://github.com/Reverier-Xu/RollCall"
        showIcon: false
        opacity: 0.8
        height: 32
        anchors.top: titleLabel.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
    }

    TextLabel {
        id: medLabel1
        text: "Idealism is that you will probably never receive something back but"
        showIcon: false
        height: 32
        contentColor: "#0078D6"
        anchors.bottom: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextLabel {
        id: medLabel2
        text: "nonetheless still decide to give."
        showIcon: false
        height: 32
        contentColor: "#0078D6"
        anchors.top: medLabel1.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 16
    }

    TextLabel {
        id: copyrightLabel
        text: "© 2016-2022 Reverier-Xu"
        showIcon: false
        opacity: 0.8
        height: 32
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 10
    }
}
