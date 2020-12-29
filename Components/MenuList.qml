import QtQuick 2.8
import QtMultimedia 5.9
import "../Common"

FocusScope {
    id: root

    property int lastIndex: 0;
    property int menuIndex: 0;
    property int textMaxLength: 20;
    property var model;
    property var currentItem: model.get(0);
    
    function onChangeItem(){
        if(lastIndex !== menuIndex)
            return true
        return false    
    }

    Keys.forwardTo: [menuList]

    Rectangle {
        id: menuWapper    
        color: "transparent" 
        focus: true 



        Component {
            id: menuDelegate
            Column {
                id: menuItem
                width: 300
                Rectangle {
                    color: parent.ListView.isCurrentItem ? "#59D97C" : "transparent"
                    width: parent.width
                    height: childrenRect.height

                    Text {
                        width: parent.width
                        visible: (typeof(name) === "undefined" ? title : name).length < root.textMaxLength || !parent.parent.ListView.isCurrentItem
                        id: nameText
                        text: typeof(name) === "undefined" ? title.substring(0,24) : name.substring(0,24) //TODO refactor the truncate
                        //text: typeof(name) === "undefined" ? title : name //TODO refactor the truncate
                        font.capitalization: Font.AllUppercase
                        color: parent.parent.ListView.isCurrentItem ? "#000000" : "#59D97C"
                        font.pixelSize: 18
                        font.family: mainFont.name
                        leftPadding: 10
                        rightPadding: 10
                        //elide: Text.ElideRight
                       
                        
                    }
                                        
                    Rectangle {
                    id: itemAnimate
                        visible: (typeof(name) === "undefined" ? title : name).length >= root.textMaxLength && parent.parent.ListView.isCurrentItem
                        property alias text: t1.text
                        property int spacing: 30
                        width: parent.width-30
                        x: 10
                        height: t1.height
                        clip: true
                        color: "transparent"
                        Text {
                        id: t1
                            width: menuItem.width
                            leftPadding: 10
                            rightPadding: 10
                            color: "#000000" 
                            font.pixelSize: 18
                            font.family: mainFont.name
                            font.capitalization: Font.AllUppercase
                            text: typeof(name) === "undefined" ? title : name
                            NumberAnimation on x { running: true; from: 0; to: -150; duration: 10000; loops: Animation.Infinite }

                        }
                    }
                }
            }
        }

        ListView {
        id: menuList
            width: 350; height: 355
            x: 15
            y: 75
            clip:true
            model: root.model
            delegate: menuDelegate
            focus: true
            //snapMode: ListView.SnapOneItem
            snapMode: ListView.SnapPosition
            property var currentItem: root.model.get(currentIndex)


            Keys.onUpPressed: {
                sfxVerticalUp.play()
                root.lastIndex = currentIndex
                decrementCurrentIndex()
                root.menuIndex = currentIndex
                root.currentItem = currentItem

            }
            Keys.onDownPressed:{
                sfxVerticalDown.play()
                root.lastIndex = currentIndex
                incrementCurrentIndex()
                root.menuIndex = currentIndex
                root.currentItem = currentItem

            } 

            
        }


    }


    
    SoundEffect {
        id: sfxVerticalUp
        source: Resources.sound_rotary_vertical_01
        volume: 1.0
    }

    SoundEffect {
        id: sfxVerticalDown
        source: Resources.sound_rotary_vertical_03
        volume: 1.0
    }
}    