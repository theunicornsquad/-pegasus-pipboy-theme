import QtQuick 2.8
import "../Common"


FocusScope {
id: root
    property int tabIndex: 0
    property string switcher: Resources.tab_switcher
    property string border: Resources.tab_left 
    property int currentIndex: 0
    property int currentPageIndex: 0;
    
    state: "center"
   
    states: [
        State {
            name: "left"
            PropertyChanges { target: tabSwitcher; source: Resources.tab_switcher_left }
        },
        State {
            name: "right"
            PropertyChanges { target: tabSwitcher; source: Resources.tab_switcher_right }
        },
        State {
            name: "center"
            PropertyChanges { target: tabSwitcher; source: Resources.tab_switcher }
        }
    ]

    Timer {
        id: timeSwitch
        interval: 400 
        running: false
        repeat: false
        onTriggered: {
            root.state = "center"
        }
    }

    function getCurrentPageIndex() {
        return currentPageIndex;
    }


    function setCurrentIndex(index){
        currentIndex = index
    }

    function next() {
        if( currentPageIndex==2 ){
            currentPageIndex = 0
        }else{
            currentPageIndex++
        }
        setCurrentIndex(currentPageIndex)
        rightAnimate()
        

    }

    function prev() {
        if( currentPageIndex==0 ){
            currentPageIndex = 2
        }else{
            currentPageIndex--
        }
        setCurrentIndex(currentPageIndex)
        leftAnimate()
        
    }

    function leftAnimate(index){
        console.error("leftAnimate");
        root.state = "left"
        timeSwitch.start()
    } 

    function rightAnimate(index){
        console.error("rightAnimate");
        root.state = "right"
        timeSwitch.start()
    }  

    Item {
    id: tabContent
        anchors.fill: parent
        
            Image {
                id:tabBorderLeft
                source: Resources.tab_left
                visible: root.currentIndex == 0
                x: 0
                y: 0
                
            }

            Image {
                id:tabBorderCenter
                source: Resources.tab_center
                visible: root.currentIndex == 1
                x: 0
                y: 0
                
            }

            Image {
                id:tabBorderRight
                source: Resources.tab_right
                visible: root.currentIndex == 2
                x: 0
                y: 0                
            }

            Image {
                id:tabSwitcher
                source: Resources.tab_switcher
                x: 0
                y: 0
            }


            Text {
                id: tabEmulatorsTitle
                x: 95
                y: 16
                text: "EMULATORS" 
                color: "#59D97C"
                font.pixelSize: 20
                font.family: mainFont.name
                leftPadding: 15
                rightPadding: 15
            }

            Text {
                id: tabRecentTitle
                x: 270
                y: 16
                text: "RECENT" 
                color: "#59D97C"
                font.pixelSize: 20
                font.family: mainFont.name
                leftPadding: 10
                rightPadding: 10
            }

            Text {
                id: tabSettingsTitle
                x: 410
                y: 16
                text: "SETTINGS" 
                color: "#59D97C"
                font.pixelSize: 20
                font.family: mainFont.name
                leftPadding: 15
                rightPadding: 15
            }
             
    }


}    

