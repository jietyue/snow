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
            color: "transparent"

            readonly property var activePlayer: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
            readonly property bool isPlaying: activePlayer ? activePlayer.isPlaying : false
            readonly property string trackTitle: activePlayer ? activePlayer.trackTitle : ""

            Poller {
                id: clock
                command: "date +'%A, %B %d   %H:%M'"
                interval: 60000
            }

            Poller {
                id: vol
                command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf\"%d\", $2*100}'"
                interval: 100
            }

            Poller {
                id: net
                command: "nmcli -t -f NAME connection show --active | head -n1"
                interval: 5000
            }

            Poller {
                id: mem
                command: "free --mega | awk '/^Mem/ {print ($3)/1024}'| cut -c-4"
                interval: 2000
            }

            Poller {
                id: cpu
                command: "awk '/cpu MHz/ {printf \"%.2f\\n\", $4/1000; exit}' /proc/cpuinfo"
                interval: 2000
            }            

            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 0
                spacing: 0

                Workspaces {}

                  /* Text {
                    text: Hyprland.activeToplevel?.title ?? ""
                    color: "#ffffff"
                    font.family: "Iosevka"
                    font.pixelSize: 14
                    
                } 

              /*  Pill { 
                    visible: bar.activePlayer !== null && bar.trackTitle !== ""
                    icon: "equalizer" 
                    label: bar.trackTitle
                    iconColor: "#ffffff" 
                } */ 

            }
            
            RowLayout {
                id: centerGroup
                anchors.centerIn: parent
                spacing: 0


                Pill { icon: ""; label: vol.value + "%"; iconColor: "#ffffff"}
                Pill { icon: ""; label: net.value; iconColor: "#ffffff"}
                Pill { icon: ""; label: clock.value; iconColor: "#ffffff"}

            }

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 0
                spacing: -10

                Pill { icon: ""; label: cpu.value + "ghz"; iconColor: "#ffffff"}
                Pill { icon: ""; label: mem.value + "g"; iconColor: "#ffffff"}
                /* Pill { icon: ""; label: vol.value + "%"; iconColor: "#ffffff"}
                Pill { icon: ""; label: net.value; iconColor: "#ffffff"}
                Pill { icon: ""; label: clock.value; iconColor: "#ffffff"} */
            }
        }
    }
}
