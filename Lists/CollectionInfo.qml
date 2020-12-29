import QtQuick 2.8
import SortFilterProxyModel 0.2
import "../Model"

Item {
id: root
    
    property string query: ""

    CollectionModel{
        id: collectionModel
    }

    SortFilterProxyModel {
    id: collectionProxyModel

        sourceModel: collectionModel
        filters: ValueFilter { roleName: "shortName"; value: query; }
        //filters: RegExpFilter { roleName: "tags"; pattern: "["+query+"]"; caseSensitivity: Qt.CaseInsensitive;}


        
    }

    property var data: {
        console.error("query");
        console.error(query);
        console.error("collectionProxyModel.description");
        console.error(collectionProxyModel.get(0).description);
        console.error("collectionProxyModel.image");
        console.error(collectionProxyModel.get(0).image);
        if(collectionProxyModel.count > 0 )
            return collectionProxyModel.get(0)
        
        return {
            image: "",
            description: "",
            year: ""
        }

    }
}