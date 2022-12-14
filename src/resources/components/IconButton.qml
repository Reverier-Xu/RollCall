import QtQuick 2.15
import QtGraphicalEffects 1.15

PushArea {
    id: root

    property color contentColor: display.contentColor
    property int iconSize: 16
    property bool noOverlay: false
    property alias icon: iconImage.source
    property int rotation: 0
    opacity: enabled ? 1.0 : 0.5

    Image {
        id: iconImage
        width: root.iconSize
        height: root.iconSize
        anchors.centerIn: parent
        sourceSize: Qt.size(iconSize, iconSize)
        smooth: true
        antialiasing: true
        visible: root.noOverlay?true:false
    }

    ColorOverlay {
        id: overlay
        anchors.fill: iconImage
        source: iconImage
        rotation: root.rotation
        color: root.contentColor
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        smooth: true
        antialiasing: true
        visible: root.noOverlay?false:true
    }
}
