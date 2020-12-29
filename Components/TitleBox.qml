import QtQuick 2.8
import "../Common"


FocusScope {
    id: root

    property string title: "" 

    Rectangle {
        id: titleBox
        x: 5
        y: 0
        width: 620
        height: 50
        color: "transparent"
    
        Rectangle {
            id: titleBorderTop
            x: 5
            y: parent.y+10
            height: 3
            width: parent.width
            //anchors.top: parent.top
            color: "#59D97C"
        }
    
        Rectangle {
            id: titleBorderBottom
            x: 5
            y: parent.y + parent.height
            height: 3
            width: parent.width
            //anchors.top: parent.top
            color: "#59D97C"
        }


        Rectangle {
            id: titleText
            x: 5
            y: parent.y+5
            height: parent.height
            width: parent.width
            color: "transparent"
            Text {
                anchors { 
                    centerIn: titleText
                }
                text: root.title
                color: "#59D97C"
                font.pixelSize: 24
                font.family: mainFont.name
                font.capitalization: Font.AllUppercase
            }
        }
    }


}