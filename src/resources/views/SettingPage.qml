import QtQuick 2.15
import QtQuick.Controls 2.15
import "qrc:/components"

Rectangle {
    id: root
    color: display.colorStyle? "white" : "#1b1b1b"

    property bool inEdit: false

    Behavior on color {
        ColorAnimation {
            duration: 280
        }
    }

    TextLabel {
        id: listTitle
        text: "学生列表"
        icon: "qrc:/assets/apps.svg"
        height: 32
        anchors.topMargin: 16
        anchors.top: parent.top
        anchors.left: parent.horizontalCenter
    }

    TextLabel {
        id: opTitle
        text: "操作"
        icon: "qrc:/assets/settings.svg"
        height: 32
        anchors.topMargin: 16
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 16
    }

    PushButton {
        id: enterEditButton
        text: "修改学生列表"
        showIcon: false
        height: 32
        anchors.top: opTitle.bottom
        anchors.left: parent.left
        anchors.leftMargin: 32
        enabled: !root.inEdit
        onClicked: {
            root.inEdit = true
        }
    }

    ListView {
        id: list
        clip: true
        anchors.top: listTitle.bottom
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 16
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        model: studentList
        ScrollBar.vertical: UXScrollBar { }
        delegate: StudentItem {
            width: ListView.view.width
            theNo: studentNo
            theName: studentName
        }
    }

    Rectangle {
        id: editRectangle
        color: display.colorStyle? "white" : "#1b1b1b"
        anchors.top: listTitle.bottom
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 16
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        visible: root.inEdit

        InputArea {
            id: editArea
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
        }

        PushButton {
            id: saveListButton
            anchors.top: editArea.bottom
            anchors.topMargin: 8
            height: 32
            anchors.right: parent.right
            icon: "qrc:/assets/archive.svg"
            text: "保存"
        }
    }
}
