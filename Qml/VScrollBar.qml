import QtQuick 2.0

Rectangle {
    property var theList: null

    id: scrollbar
    height: parent.height
    x: parent.width - width;
    y:0
    radius: width
    clip:true
    // 按钮
    Rectangle {
        id: button
        x: 0
        y: theList.visibleArea.yPosition * scrollbar.height
        width: parent.width
        height: theList.visibleArea.heightRatio * scrollbar.height;
        color: "#818b81"
        radius: width
        clip: true
        // 鼠标区域
        MouseArea {
            id: mouseArea
            anchors.fill: button
            drag.target: button
            drag.axis: Drag.YAxis
            drag.minimumY: 0
            drag.maximumY: scrollbar.height - button.height
            // 拖动
            onMouseYChanged: {
                theList.contentY = button.y / scrollbar.height * theList.contentHeight
            }
        }
    }

}
