import QtQuick 2.8
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12
import QtMultimedia 5.9
import "Components"
import "Common"

FocusScope {
    id: root
    width: 640
    height: 480

    property string currentPage: "collections";
    property int collectionIndex: 0;
    property var currentCollection;

    state: ""
   
    states: [
        State {
            name: "loading-hidden"
            PropertyChanges { target: loading; visible: false }
        },
        State {
            name: "loading-show"
            PropertyChanges { target: loading; visible: true }
        }
    ]

    /**
     *  Fonts  
     */
    FontLoader {
        id: mainFont
            source: "assets/fonts/ChicagoFLF.ttf" 
    }

    /** 
     * Sounds 
     */

    SoundEffect {
        id: sfxOK
        source: Resources.sound_OK
        volume: 1.0
    }
    
    SoundEffect {
        id: sfxHorizontalPrev
        source: Resources.sound_rotary_horizontal_01
        volume: 1.0
    }

    SoundEffect {
        id: sfxHorizontalNext
        source: Resources.sound_rotary_horizontal_02
        volume: 1.0
    }



    /**
     *  Background  
     */
    Image {
        id: wapperBackground
            source: "assets/images/background/bg_green.png"
        //asynchronous: false
    }

    TabBar {
       id: tabBar
       visible: currentPage !== "games"; 
    }

    /**
     * Components
     */
    Component {
    id: collectionsView
        Collections { focus: true }
    }

    Component {
    id: recentView
        Recent { focus: true }
    }

    Component {
    id: gamesView
        Games { focus: true }
    }

    Component {
    id: settingsView
        Settings { focus: true }
    }
   


    Item{
    id: content

        Loader  {
        id: collectionsLoader
            focus: (currentPage === "collections")
            active: opacity !== 0
            opacity: focus ? 1 : 0
            anchors.fill: parent
            sourceComponent: collectionsView
            asynchronous: true
        }
        Loader  {
        id:recentLoader
            focus: (currentPage === "recent")
            active: opacity !== 0
            opacity: focus ? 1 : 0
            anchors.fill: parent
            sourceComponent: recentView
            asynchronous: true
        }
        
        Loader  {
        id:settingsLoader
            focus: (currentPage === "settings")
            active: opacity !== 0
            opacity: focus ? 1 : 0
            anchors.fill: parent
            sourceComponent: settingsView
            asynchronous: true
        }

        Loader  {
        id:gamesLoader
            focus: (currentPage === "games")
            active: opacity !== 0
            opacity: focus ? 1 : 0
            anchors.fill: parent
            sourceComponent: gamesView
            asynchronous: true
        }

    }




    function goTo(page){
       currentPage = page

    }

    function goToCurrentPage(index){
        let page = ""
        switch (index) {
            case 0:
            page = "collections"
            break;
            case 1:
            page = "recent"
            break;
            case 2:
            page = "settings"
            break;
            default:
                page = "settings"
        }

        goTo(page);
    }

    function next() {
        if(currentPage === "games")
            return
        sfxHorizontalPrev.play()
        //showLoading()
        tabBar.next()
        goToCurrentPage(tabBar.getCurrentPageIndex())
    }

    function prev() {
        if(currentPage === "games")
            return
        sfxHorizontalNext.play()
        //showLoading()
        tabBar.prev()
        goToCurrentPage(tabBar.getCurrentPageIndex())

    }
 
    Keys.onReleased: {

        //debug.text = "key = "+event.key
        
        if (event.isAutoRepeat)
            return;
            
        // Debug
        if (event.key == Qt.Key_1) {
          event.accepted = true;
          prev()
          return;   
        }
        // Debug
        if (event.key == Qt.Key_2) {
          event.accepted = true;
          next()
          return; 
        }

        if( event.key === Retroid.key_ZL ){
          event.accepted = true;  
          prev()
          return;     
        }

        if( event.key === Retroid.key_ZR ){
          event.accepted = true;
          next()
          return;      
        }

    }





    /**
    Text {
         id: debug
         color: "white"
         font.family: mainFont.name
         font.pointSize: 20
         x: 20
         y: 450
         text: ''
    }
     */
    

    function showLoading(){
        root.state = "loading-show"
        timerHidden.start()
    }   

    Timer {
        id: timerHidden
        interval: 500 //300
        running: false
        repeat: false
        onTriggered: {
            root.state = "loading-hidden"
        }
    }

    /**
    RecursiveBlur {
    id:loading    
        anchors.fill: root
        source: root
        width: parent.width
        height: parent.height
        loops: 1
        radius: 8.5
        visible: false;

    }
    
    FastBlur {
    id: loading
        anchors.fill: root
        source: root
        radius: 32
    }

    */

    GaussianBlur {
    id: loading
        visible: false;
        anchors.fill: root
        source: root
        radius: 8
        samples: 80
    }


    
}