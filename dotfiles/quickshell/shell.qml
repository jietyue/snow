import Quickshell  
import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData 
            screen: modelData
            
            anchors { top: true; left: true; right: true }
            margins { top: 11}
            implicitHeight: 33
            color: "transparent"

            // --- Media Controller Fix ---
            // 1. Safely extract the first acvitive player from the array wrapper using [0]
            readonly property var activePlayer: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
            
            // 2. Safely read Quickshell's built-in player properties
            readonly property bool isPlaying: activePlayer ? activePlayer.isPlaying : false
            readonly property string trackTitle: activePlayer ? activePlayer.trackTitle : ""

            Poller {
                id: clock
                command: "date +%H:%M"
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
                anchors.leftMargin: 14
                spacing: 8

                Pill { 
                    visible: bar.activePlayer !== null && bar.trackTitle !== ""
                    icon: "" 
                    label: bar.trackTitle
                    iconColor: "#2e2825" 
                }

            }
            
            RowLayout {
                id: centerGroup
                anchors.centerIn: parent
                spacing: 8

                // SoundCloud / Music Pill
                // Displays whenever any player is tracked by MPRIS


                Pill { icon: ""; label: clock.value; iconColor: "#ffffff"}
                Workspaces {}
            }

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 14
                spacing: 8

                Pill { icon: ""; label: vol.value + "%"; iconColor: "#ffffff"}
                Pill { icon: ""; label: net.value; iconColor: "#ffffff"}
                Pill { icon: ""; label: clock.value; iconColor: "#ffffff"}
            }
        }
    }
}
