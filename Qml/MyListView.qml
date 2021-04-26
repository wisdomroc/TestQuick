import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQml.Models 2.11
import QtQuick.Layouts 1.0

FocusScope {
    property bool refreshFlag: false
    property alias view: __listView
    property alias currentIndex: __listView.currentIndex
    property var headerLabels: ["学号", "姓名", "性别", "保留位1", "保留位2", "保留位3", "保留位4", "保留位5", "保留位6", "保留位7"]
    property var headerRoles: ["id", "name", "sex", "reserve1", "reserve2", "reserve3", "reserve4", "reserve5", "reserve6", "reserve7"]
    property var headerWidths: [40, 40, 40, 100, 100, 100, 100, 100, 100, 100]

    clip: true


    // 下拉刷新功能的实现代码
    Rectangle{
        width: parent.width
        height: Math.max(-__listView.contentY, 30)
        y: __listView.contentY +30>0 ?   -(__listView.contentY +30) : 0
        color: "steelBlue"
        ColumnLayout {
            anchors.fill: parent
            Item {
                Layout.fillHeight: true
            }

            Label{
                Layout.alignment: Qt.AlignHCenter
                text:qsTr("下拉刷新")
                font.family: "微软雅黑"
                font.pointSize: 16
                color: "white"
            }
        }
    }

    BusyIndicator{
        id:busy
        z:4
        running: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height / 3.
        Timer{
            interval: 2000
            running: busy.running
            onTriggered: {
                busy.running = false
            }
        }
    }

    ListView{
        id:__listView
        anchors {
            fill: parent
            topMargin: 30
        }

        keyNavigationEnabled: true
        keyNavigationWraps: true
        model: studentListModel
        spacing: 1

        cacheBuffer: 20
        focus: true

        onContentYChanged: {
            if(contentY < -40){
                refreshFlag = true
            }
        }
        onMovementEnded: {
            if(refreshFlag){
                refreshFlag = false
                busy.running = true
            }
        }

        onCurrentIndexChanged: {
            console.log("current index = ",currentIndex)
        }

        delegate: Rectangle {
            id: listViewDelegate
            width: ListView.view.width
            height: 30
            color: ListView.view.currentIndex === index ? "gray" : "lightGray"
            property var myModel: model

            Row {
                Repeater {
                    model: headerWidths

                    Text{
                        text: myModel[headerRoles[index]]
                        width: headerWidths[index]
                        height: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Rectangle {
                            width: 1
                            height: listViewDelegate.height
                            anchors.right: parent.right
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    __listView.currentIndex = index
                }
            }

            Component.onDestruction: console.log("ListModel " + index + "destroyed...")
            Component.onCompleted: console.log("ListModel " + index + "created...")
        }
    }

    //! 自定义表头
    Rectangle {
        id: horizontalHeader
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 30
        color: "steelBlue"

        //暂存鼠标拖动的位置
        property int posXTemp: 0


        MouseArea{
            anchors.fill: parent
            onPressed: horizontalHeader.posXTemp=mouseX;
            onPositionChanged: {
                if(__listView.contentX+(horizontalHeader.posXTemp-mouseX)>0){
                    __listView.contentX+=(horizontalHeader.posXTemp-mouseX);
                }else{
                    __listView.contentX=0;
                }
                horizontalHeader.posXTemp=mouseX;
            }
        }


        Row {
            anchors.fill: parent
            leftPadding: -__listView.contentX
            clip: true
            Repeater {
                model: headerLabels
                Text{
                    id: header_horizontal_item
                    text: headerLabels[index]
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    width: headerWidths[index]
                    height: horizontalHeader.height
                    Rectangle {
                        width: 1
                        height: parent.height
                        anchors.right: parent.right
                        visible: index === headerLabels.length ? false : true
                    }
                    MouseArea{
                        width: 3
                        height: parent.height
                        anchors.right: parent.right
                        cursorShape: Qt.SplitHCursor
                        onPressed: horizontalHeader.posXTemp=mouseX;
                        onPositionChanged: {
                            if((header_horizontal_item.width-(horizontalHeader.posXTemp-mouseX)) > 10)
                            {
                                header_horizontal_item.width-=(horizontalHeader.posXTemp-mouseX);
                            }
                            else
                            {
                                header_horizontal_item.width=10;
                            }
                            horizontalHeader.posXTemp = mouseX;

                            //改变某列的宽度
                            headerWidths[index]=(header_horizontal_item.width);

                            //刷新布局，这样宽度才会改变
                            __listView.forceLayout()
                            __listView.forceActiveFocus()
                        }
                    }
                }
            }
        }

    }

    VScrollBar {
        id:scrollBar
        theList:__listView
        width:6
        color:parent.color
    }

    Menu {
        id: contextMenu
        MenuItem { text: "Cut" }
        MenuItem { text: "Copy" }
        MenuItem { text: "Paste" }
    }

    function initData(count) {
        var i = 0;
        while(i < count)
        {
            var info = {'name': "Construct Info " + i}
            __listModel.append(info)
            i ++
        }
    }

    function insertOneRecord(index, info) {
        __listModel.insert(index, info)
    }

    function deleteOneRecord(index) {
        __listModel.remove(index)
    }

    function moveDown() {
        if(currentIndex + 1 < model.count) {
            model.move(currentIndex, currentIndex + 1, 1)
        }
    }



    //! 以下为动画效果
    /*
        add: Transition {
            NumberAnimation { properties: "y"; from: 0; duration: 1000}
            NumberAnimation { properties: "opacity"; from: 0; to: 1.0; duration: 1000}
        }

        displaced: Transition {
            SpringAnimation { properties: "y"; spring: 2; damping: 0.5; epsilon: 0.25 }
        }

        remove: Transition {
            SequentialAnimation {
                PropertyAction { properties: "transformOrigin"; value:Item.TopLeft }
                NumberAnimation { properties: "scale"; to: 0; duration: 1000 }
                NumberAnimation { properties: "opacity"; to: 0; duration: 1000 }
            }
        }

        move: Transition {
            NumberAnimation { properties: "y"; duration: 1000; easing.type: Easing.OutQuart }
        }

        populate: Transition {
            NumberAnimation { properties: "y"; duration: 1000 }
        }
        */
}


