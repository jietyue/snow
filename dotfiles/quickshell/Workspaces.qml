import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
    implicitWidth: row.implicitWidth + 20
    implicitHeight: 33
    color: "#111111"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: 9

            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1
                color: isActive ? "#f1c61b" : (ws ? "#ffffff" : "#111111")
                font { family: "Iosevka" ; pixelSize: 14;}
            

                Behavior on color {
                    ColorAnimation {
                        duration: 0
                    }
                }
            }
        }
    }
}