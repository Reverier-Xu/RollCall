import QtQuick 2.15
import QtGraphicalEffects 1.15

PushArea {
    id: root
    property string theName
    property int theNo
    flat: true
    border.color: "transparent"

    height: 36

    Rectangle {
        anchors.verticalCenter: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        height: 1
        color: "#60808080"
    }

    Text {
        id: noLabel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 15
        color: "#808080"
        text: root.theNo.toString().padStart(2, '0')
        font.pixelSize: 16
    }

    TextMetrics {
        id: titleMetrics
        elide: Text.ElideRight
        font.pixelSize: 16
        text: root.theName
        elideWidth: nameLabel.width
    }

    Text {
        id: nameLabel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: noLabel.right
        anchors.right: parent.right
        anchors.leftMargin: 15
        anchors.rightMargin: 25
        font.pixelSize: 16
        color: display.contentColor
        text: titleMetrics.elidedText
    }
}
