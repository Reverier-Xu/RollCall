import QtQuick 2.15

Rectangle {
    id: root
    color: "transparent"

    property int num: 0

    Rectangle {
        id: upLine
        color: display.contentColor
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        height: 8
        radius: 2
        visible: num == 0 || num == 2 || num == 3 || num == 5 || num == 6 || num == 7 || num == 8 || num == 9
    }

    Rectangle {
        id: downLine
        color: display.contentColor
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        height: 8
        radius: 2
        visible: num== 0 || num == 2 || num == 3 || num == 5 || num == 6 || num == 8 || num == 9
    }

    Rectangle {
        id: centerLine
        color: display.contentColor
        anchors.centerIn: parent
        width: upLine.width
        radius: 2
        height: 8
        visible: num == 2 || num == 3 || num == 4 || num == 5 || num == 6 || num == 8 || num == 9
    }

    Rectangle {
        id: leftUpLine
        color: display.contentColor
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: 4
        anchors.left: parent.left
        width: 8
        radius: 2
        visible: num == 0 || num == 4 || num == 5 || num == 6 || num == 8 || num == 9
    }

    Rectangle {
        id: rightUpLine
        color: display.contentColor
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: 4
        anchors.right: parent.right
        width: 8
        radius: 2
        visible: num == 0 || num == 1 || num == 2 || num == 3 || num == 4 || num == 7 || num == 8 || num == 9
    }

    Rectangle {
        id: leftDownLine
        color: display.contentColor
        anchors.left: parent.left
        anchors.top: parent.verticalCenter
        anchors.topMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: 8
        radius: 2
        visible: num == 0 || num == 2 || num == 6 || num == 8
    }

    Rectangle {
        id: rightDownLine
        color: display.contentColor
        anchors.right: parent.right
        anchors.top: parent.verticalCenter
        anchors.topMargin: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: 8
        radius: 2
        visible: num == 0 || num == 1 || num == 3 || num == 4 || num == 5 || num == 6 || num == 7 || num == 8 || num == 9
    }
}
