import QtQuick 2.8
import "../Common"
import "../Model"
import "../Lists"


FocusScope {
    id: root
    focus: true    
    
    Component.onCompleted: {
        console.error("[onCompleted]")
        console.error(collectionInfo.data.image);
        console.error(collectionsMenu.currentItem.shortName);
    }
    
    CollectionInfo{
        id: collectionInfo
        query: collectionsMenu.currentItem.shortName
    }


    MenuList{
        id: collectionsMenu
        model: api.collections
        focus: true
        Keys.onPressed: {
            if (api.keys.isAccept(event)) {
                sfxOK.play()
                currentCollection = collectionsMenu.currentItem
                collectionIndex = collectionsMenu.menuIndex
                goTo('games');
                return;
            }    
        }                         
            
    }


    //TODO: refactoring image source and hexadecimal colors


    Rectangle {
    id: gameCollectionView
        //border.color: "#59D97C"
        //border.width: 3
        color: "transparent"
        x: 320
        y: 60
        width: 300
        height: 240
        Image {
            id: gameCollectionImage
            anchors { 
                centerIn: gameCollectionView
            }
            source: "../assets/images/collections/"+collectionInfo.data.image
            //source: "../assets/images/collections/"+collectionsMenu.currentItem.shortName+".png"
            
        }
    }

    Rectangle {
        id: collectionContentBox
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
            text: "["+collectionsMenu.currentItem.name+"]"
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
        }
        Text {
            id: year
            visible: collectionInfo.data.year
            text: "[YEAR OF RELEASE]: "+collectionInfo.data.year
            font.capitalization: Font.AllUppercase
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
            y: 20
        }
        Text {
            id: description
            text: collectionInfo.data.description
            font.capitalization: Font.AllUppercase
            wrapMode: Text.WordWrap
            width: parent.width-20
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
            y: 40
        }
        Text {
            id: listCount
            text: "No. Of ROMS: "+collectionsMenu.currentItem.games.count
            visible: collectionsMenu.currentItem.games.count>0
            color: "#59D97C"
            font.pixelSize: 15
            font.family: mainFont.name
            padding: 5
            y: 112
        }
    }


    // Input bar
    Rectangle 
    {
        id: inputBar
        anchors.fill: parent
        color: "transparent"
        Image {
            x: 140
            y: 210
            id: inputBarImage
            source: Resources.input_bar
        }
    }

    
}    