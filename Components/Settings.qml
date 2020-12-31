import QtQuick 2.8
import "../Common"

FocusScope {
    id: root

    ListModel {
    id: settingsModel

        ListElement {
            settingName: "Hide emulators"
            key:"hide_emulators"
            setting: "Yes,No"
        }
        ListElement {
            settingName: "Hide non-game apps"
            key:"hide_non_game_apps"
            setting: "No,Yes"
        }
        ListElement {
            settingName: "Hide android games"
            key:"hide_android_games"
            setting: "No,Yes"
        }
    }

    Component.onCompleted: {
        console.error("[settings]")
        console.error(settingsModel)
    }


    ListView {
    id: pagelist
        focus: true
        snapMode: ListView.SnapPosition
        model: settingsModel
        delegate: settingsDelegate
        width: 350; height: 355
        x: 60
        y: 75
        clip: true
    }


    Component {
        id: settingsDelegate


        Item {
            id: menuItem
            width: pagelist.width
            height: 30

            Component.onCompleted: {
                console.error("[settingsDelegate][onCompleted]")
            }

            property variant settingList: setting.split(',')
            property int savedIndex: api.memory.get(key + '_index') || 0

            

            function saveSetting() {
                api.memory.set(key + '_index', savedIndex);
                api.memory.set(key, settingList[savedIndex]);
            }

            function nextSetting() {
                if (savedIndex != settingList.length -1)
                    savedIndex++;
                else
                    savedIndex = 0;
            }

            function prevSetting() {
                if (savedIndex > 0)
                    savedIndex--;
                else
                    savedIndex = settingList.length -1;
            }


            Text {
            id: settingNameText
            
                text: settingName
                color: "#59D97C"
                font.pixelSize: 20
                font.capitalization: Font.AllUppercase
                font.family: mainFont.name
                height: parent.height

            }

            /**
            Text { 
            id: settingtext; 
            
                text: settingList[savedIndex]; 
                color: "#59D97C"
                font.pixelSize: 20
                font.capitalization: Font.AllUppercase
                font.family: mainFont.name
                height: parent.height
            }
            */
        }
    }


}    