import Quickshell  
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData 
            screen: modelData
            
            anchors { top: true; left: true; right: true }
            margins { top: 0 }
            implicitHeight: 25
            color: "#1C202B"

            readonly property var activePlayer: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
            readonly property bool isPlaying: activePlayer ? activePlayer.isPlaying : false
            readonly property string trackTitle: activePlayer ? activePlayer.trackTitle : ""

            Poller {
                id: clock
                command: "date +'%A, %B %d   %H %M'"
                interval: 60000
            }

            Poller {
                id: vol
                command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf\"%d\", $2*100}'"
                interval: 1000
            }

            Poller {
                id: net
                command: "nmcli -t -f NAME connection show --active | head -n1"
                interval: 5000
            }

            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
                spacing: -10

                Workspaces {}

                Pill { 
                    visible: bar.activePlayer !== null && bar.trackTitle !== ""
                    icon: "" 
                    label: "Now Playing: " + bar.trackTitle
                    iconColor: "#2e2825" 
                }

            }
            
            RowLayout {
                id: centerGroup
                anchors.centerIn: parent
                spacing: 0

                Text {
                    text: Hyprland.activeToplevel?.title ?? "No active window"
                    color: "#ffffff"
                    font.family: "Iosevka"
                    font.pixelSize: 12
                    
                }
            }

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: -5
                spacing: -10

                Pill { icon: ""; label: "Vol: " + vol.value + "%"; iconColor: "#ffffff"}
                Pill { icon: ""; label: net.value; iconColor: "#ffffff"}
                Pill { icon: ""; label: clock.value; iconColor: "#ffffff"}
            }
        }
    }
}
