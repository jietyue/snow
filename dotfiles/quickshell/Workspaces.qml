import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
    implicitWidth: row.implicitWidth + 20
    implicitHeight: 33
    color: "#1C202B"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: Hyprland.workspaces

            Text {
                required property var modelData

                text: modelData.id
                color: modelData.active ? "#8196c7" : "#ffffff"

                font.family: "Lilex"
                font.pixelSize: modelData.active ? 17 : 15
                font.bold: modelData.active

                Layout.alignment: Qt.AlignVCenter

                Behavior on font.pixelSize {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }
            }
        }
    }
}