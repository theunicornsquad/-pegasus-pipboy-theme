import QtQuick 2.8
import SortFilterProxyModel 0.2

Item {
id: root
    property int max: 20



    SortFilterProxyModel {
    id: lastPlayedGamesProxy
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder }
        filters: ValueFilter { roleName: "lastPlayed"; value: ""; inverted: true}
        
    }

    property var data: {
        if ( lastPlayedGamesProxy.count > 0)
            return lastPlayedGamesProxy
        return []
    }
}    
    
    
