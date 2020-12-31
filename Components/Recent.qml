import QtQuick 2.8
import QtGraphicalEffects 1.12
import "../Common"
import "../Model"
import "../Lists"


FocusScope {
    id: root
    focus: true    

    LastPlayedGames {
        id: lastPlayedGames
    }

    Component.onCompleted: {
        console.error("[Recent][onCompleted]")
    }


    MenuList{
        id: recentMenu
        model: lastPlayedGames.data
        focus: true
        Keys.onPressed: {
            if (api.keys.isAccept(event)) {
                sfxOK.play()
                event.accepted = true;
                recentMenu.currentItem.launch()
                return;
            }   

            if (api.keys.isCancel(event)) {
                event.accepted = true;
                goTo('recent');
                return;
            }   
            
        }                      
            
    }


   Rectangle {
    id: gameView
        //border.color: "#59D97C"
        //border.width: 3
        color: "transparent"
        x: 320
        y: 60
        width: 300
        height: 240
        Image {
            id: gameViewImage
            anchors { 
                centerIn: gameView
            }
            height: 200
            fillMode: Image.PreserveAspectFit
            source: recentMenu.currentItem.assets.boxFront
            smooth: true
            visible: false
        }

        ShaderEffect {
            id: gameViewImageShader
            anchors { 
                centerIn: gameView
            }
            width: gameViewImage.width; height: gameViewImage.height
            property variant src: gameViewImage
            vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                varying highp vec2 coord;
                void main() {
                    coord = qt_MultiTexCoord0;
                    gl_Position = qt_Matrix * qt_Vertex;
                }"
            fragmentShader: "
                varying highp vec2 coord;
                uniform sampler2D src;
                uniform lowp float qt_Opacity;
                void main() {
                    lowp vec4 tex = texture2D(src, coord);
                    gl_FragColor = vec4(vec3(dot(tex.rgb,
                                        vec3(0.344, 0.5, 0.156))),
                                            tex.a) * qt_Opacity;
                }"
        }
        
        ColorOverlay {
            anchors.fill: gameViewImageShader
            source: gameViewImageShader
            //color: "#8000FF"
            color: "#7359D97C"
        }
        
    }



    Rectangle {
        id: gameContentBox
        x: 320
        y: 305
        width: 300
        height: 140
        color: "transparent"
        border.color: "#59D97C"
        border.width: 3
        radius: 0



        Text {
            id: system
            text: "["+recentMenu.currentItem.collections.get(0).name+"]"
            visible: (recentMenu.currentItem.title)
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
        }

        Text {
            id: summary
            text: recentMenu.currentItem.summary
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
            y: 20
        }

        Text {
            id: launchGameText
            text: "A:LAUNCH GAME"
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
            y: 92
        }

        Text {
            id: loadSaveStateText
            text: "X:LOAD SAVE STATE"
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
            y: 112
        }
    }


    // Input bar
    Image {
        id: inputBarImage
        x: 320
        y: 450
        source: Resources.input_bar_games
    }
    
}    