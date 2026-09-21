import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
    implicitWidth: row.implicitWidth + 20
    implicitHeight: 33
    color: "#B3000000"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: 9

            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1 
                color: isActive ? "#ffffff" : (ws ? "#685891" : "#B3000000")
                font { family: "Lilex" ; pixelSize: 14;}
            

                Behavior on color {
                    ColorAnimation {
                        duration: 0
                    }
                }
            }
        }
    }
}