import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: myRec
    width: 800
    height: 600

    ColumnLayout {
        id: colLayout
       anchors.bottom: myRec.bottom
       anchors.margins: 0

       RowLayout {
           anchors.top: colLayout.top
           Rectangle {
               width: 100
               height: 100
               anchors.top: myRec.top
           }
       }

       Rectangle {
           id: twoRec
           Layout.minimumHeight: 30
           width: 100
           height: 30
       }
       Rectangle {
           Layout.minimumHeight: 30
           width: 100
           height: 30
       }
    }
}
