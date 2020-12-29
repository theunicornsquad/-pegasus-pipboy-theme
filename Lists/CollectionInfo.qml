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
    }

    property var data: {
        if(collectionProxyModel.count > 0 )
            return collectionProxyModel.get(0)
        console.error("CollectionInfo.data.image");
        console.error(collectionProxyModel.get(0).image);
        return {
            image: "",
            description: "",
            year: ""
        }

    }
}