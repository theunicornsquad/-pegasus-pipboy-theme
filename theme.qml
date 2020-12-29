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

    property string currentPage: "Collections";
    property int currentPageIndex: 0;
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
     *  Background  
     */
    Image {
        id: wapperBackground
            source: "assets/images/background/bg_green.png"
        //asynchronous: false
    }

    /**
     *  Fonts  
     */
    FontLoader {
        id: mainFont
            source: "assets/fonts/ChicagoFLF.ttf" 
    }

    TabBar {
       id: tabBar
       visible: currentPage !== "Games"; 
    }


    Collections {
      id: collection
      visible: currentPage === "Collections";
      focus: visible
     
      
    }

    Recent {
      id: recent
      visible: currentPage === "Recent";
      focus: visible
    }

    
    Games {
      id: gameList
      visible: currentPage === "Games";
      focus: visible
    }

    function goTo(page){
        currentPage = page
    }

    function goToCurrentPage(index){
        let page = ""
        switch (index) {
            case 0:
            page = "Collections"
            break;
            case 1:
            page = "Recent"
            break;
            case 2:
            page = "Setting"
            break;
            default:
                page = "Setting"
        }

        goTo(page);
    }

    function next() {
        if( currentPageIndex==2 ){
            currentPageIndex = 0
        }else{
            currentPageIndex++
        }
        tabBar.setCurrentIndex(currentPageIndex)
        tabBar.rightAnimate()
        goToCurrentPage(currentPageIndex)

    }

    function prev() {
        if( currentPageIndex==0 ){
            currentPageIndex = 2
        }else{
            currentPageIndex--
        }
        tabBar.setCurrentIndex(currentPageIndex)    
        tabBar.leftAnimate()
        goToCurrentPage(currentPageIndex)

    }
    /*     
    Keys.onLeftPressed: {
          prev()
          return;  

    }
    Keys.onRightPressed:{
          next()
          return;  
    }  */

    Keys.onReleased: {

        //debug.text = "key = "+event.key
        
        if (event.isAutoRepeat)
            return;
            
        // Debug
        if (event.key == Qt.Key_1) {
          event.accepted = true;
          showLoading()
          sfxHorizontalPrev.play()
          prev()
          return;   
        }
        // Debug
        if (event.key == Qt.Key_2) {
          event.accepted = true;
          showLoading()
          sfxHorizontalNext.play()
          next()
          return; 
        }

        if( event.key === Retroid.key_ZL ){
          event.accepted = true;  
          showLoading()
          sfxHorizontalPrev.play()
          prev()
          return;     
        }

        if( event.key === Retroid.key_ZR ){
          event.accepted = true;
          showLoading()
          sfxHorizontalNext.play()
          next()
          return;      
        }

    }


    //Sounds

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
    

 /**
    Rectangle {
        id: rectangle1
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#000000"
        opacity: 0.49


    }



            */

    function showLoading(){
        root.state = "loading-show"
        timerHidden.start()
    }   

    Timer {
        id: timerHidden
        interval: 300
        running: false
        repeat: false
        onTriggered: {
            root.state = "loading-hidden"
        }
    }

    RecursiveBlur {
    id:loading    
        anchors.fill: root
        source: root
        width: parent.width
        height: parent.height
        loops: 7
        radius: 4.5
        visible: false;
    }
    
}