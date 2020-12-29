import QtQuick 2.8
import QtGraphicalEffects 1.12
import "../Common"

FocusScope {
    id: loadingComponet

    property var source;

    state: "hidden"
   
    states: [
        State {
            name: "show-loading"
            PropertyChanges { target: loading; visible: true }
        },
        State {
            name: "hidden-loading"
            PropertyChanges { target: loading; visible: false }
        }
    ]

    Timer {
        id: timerHidden
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            parent.state = "hidden"
        }
    }

    function show(){
        parent.state = "show"
        timerHidden.start()
    }

    RecursiveBlur {
    id:loading    
        anchors.fill: source
        source: source
        loops: 2
        radius: 4.5
        visible: false;
    }



}        