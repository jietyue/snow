import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color iconColor: "#0c0b41"
    property int maxLabelWidth: 400

    implicitWidth: row.implicitWidth + 5
    implicitHeight: 25
    color: "#B3000000"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: root.icon
            color: root.iconColor
            font.family: "Material Symbols Rounded"
            font.pixelSize: 16
        }

        Text {
            text: root.label
            color: "#685891"
            font.family: "Lilex"
            font.pixelSize: 14
            elide: Text.ElideRight
            Layout.maximumWidth: root.maxLabelWidth
            visible: root.label !== ""
        }
    }
}