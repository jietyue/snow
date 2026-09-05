import Quickshell  
import QtQuick
import QtQuick.Layouts

ShellRoot {
    Variants {
        // see Variants for details
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData 
            screen: modelData
            
            anchors {top: true; left: true; right: true }
            implicitHeight: 33
            color: "transparent"

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

            // battery
        /* Poller {
                id: bat
                command: "cat /sys/class/power_supply/BAT1/capacity"
                interval: 30000
            } 
            */ 

            Poller {
                id: net
                command: "nmcli -t -f NAME connection show --active | head -n1"
                interval: 5000
            }
            
            RowLayout {
                id: centerGroup
                anchors.centerIn: parent
                spacing: 8

                Pill { icon: ""; label: clock.value; iconColor: "#ffffff"}

                
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