import QtQuick 2.12

import QtQuick.Controls 1.4

/* 配合EfficientTable进行使用，提供delegate支持 */

Rectangle{
    color: currentIndex === model.row ?
               "gray" :"lightGray"

    border.width :0
    Label{
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        //elide: Text.ElideRight
        text:model.value
    }

    Rectangle {
        height: 2
        width: parent.width
        anchors.bottom: parent.bottom
        color: "#00000000"
        border.color: "white"
    }
}
