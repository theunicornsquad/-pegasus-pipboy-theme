import QtQuick 2.8
import QtGraphicalEffects 1.12
import "../Common"


FocusScope {
    id: root
    focus: true 
  

    TitleBox{
       id: gamesTitle
       title: currentCollection.name
    }

    MenuList{
        id: gamesMenu
        model: api.collections.get(collectionIndex).games
        focus: true
        Keys.onPressed: {
            if (api.keys.isAccept(event)) {
                sfxOK.play()
                event.accepted = true;
                gamesMenu.currentItem.launch()
                return;
            }   

            if (api.keys.isCancel(event)) {
                event.accepted = true;
                goTo('collections');
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
            source: gamesMenu.currentItem.assets.boxFront
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
            id: title
            //text: gamesMenu.currentItem.description
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pointSize: 12
            font.family: mainFont.name
            padding: 5
        }


        Text {
            id: description
            //text: collectionsMenu.currentItem.description
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pointSize: 12
            font.family: mainFont.name
            padding: 5
        }
        Text {
            id: listCount
            //text: collectionsMenu.currentItem.games.count
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pointSize: 12
            font.family: mainFont.name
            padding: 5
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


    Image {
        id:returnButton
        source: Resources.return_button
        x: 20
        y: 450
    }

    // Input bar
    Image {
        id: inputBarImage
        x: 320
        y: 450
        source: Resources.input_bar_games
    }

}    