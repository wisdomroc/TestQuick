import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQml.Models 2.11
import QtQuick.Layouts 1.0

//! 使用ListView自定义的TableView
//! 这里有个问题：
//! 如果在ListView的Component.onCompleted里面初始化，然后在自定义表头中取不到相关的值
//! 如果在studentListView中初始化，那么自定义表头中就可以正常取到值

FocusScope {
    property bool refreshFlag: false
    property alias view: __listView
    property alias currentIndex: __listView.currentIndex

    clip: true

    property var headerWidth: []

    //添加新列
    function insertColumn(tableIndex,columnName,roleName,width){
        headerWidth.splice(tableIndex,0,width)
        studentListModel.insertColumn(tableIndex,columnName,roleName,width)
    }



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

//        header: horizontalHeader
        delegate: Rectangle {
            id: listViewDelegate
            width: ListView.view.width
            height: 30
            color: ListView.view.currentIndex === index ? "gray" : "lightGray"
            property var myModel: model.value.split(",")

            Row {
                Repeater {
                    model: headerWidth.length

                    Text{
                        text: myModel[index]
                        width: headerWidth[index]
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



                    console.log("######## columnCount: " + studentListModel.columnCount())
                    console.log("######## headerData: " + studentListModel.headerData(index, Qt.Horizontal))
                    console.log("######## headerWidth: " + headerWidth[index])
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
            leftPadding: 0 //-__listView.contentX
            clip: true
            Repeater {
                model: headerWidth.length
                Text{
                    id: header_horizontal_item
                    text: studentListModel.headerData(index, Qt.Horizontal)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    width: headerWidth[index]
                    height: horizontalHeader.height
                    Rectangle {
                        width: 1
                        height: parent.height
                        anchors.right: parent.right
                        visible: index === headerWidth.length ? false : true
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
                            headerWidth[index] = header_horizontal_item.width;

                            //刷新布局，这样宽度才会改变
                            __listView.forceLayout()
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
        color: "cyan"
    }


    Component.onCompleted: {
        headerWidth = studentListModel.headerWidths()
        /*
        insertColumn(0, qsTr("序号"), "id", 40);
        insertColumn(1, qsTr("姓名"), "name", 40);
        insertColumn(2, qsTr("性别"), "sex", 40);
        insertColumn(3, qsTr("保留1"), "reserve1", 100);
        insertColumn(4, qsTr("保留2"), "reserve2", 100);
        insertColumn(5, qsTr("保留3"), "reserve3", 100);
        insertColumn(6, qsTr("保留4"), "reserve4", 100);
        insertColumn(7, qsTr("保留5"), "reserve5", 100);
        insertColumn(8, qsTr("保留6"), "reserve6", 100);
        insertColumn(9, qsTr("保留7"), "reserve7", 100);
        insertColumn(10, qsTr("保留8"), "reserve8", 100);
        insertColumn(11, qsTr("保留9"), "reserve9", 100);
        insertColumn(12, qsTr("保留10"), "reserve10", 100);
        insertColumn(13, qsTr("保留11"), "reserve11", 100);
        insertColumn(14, qsTr("保留12"), "reserve12", 100);
        insertColumn(15, qsTr("保留13"), "reserve13", 100);
        insertColumn(16, qsTr("保留14"), "reserve14", 100);
        insertColumn(17, qsTr("保留15"), "reserve15", 100);
        insertColumn(18, qsTr("保留16"), "reserve16", 100);
        insertColumn(19, qsTr("保留17"), "reserve17", 100);
        insertColumn(20, qsTr("保留18"), "reserve18", 100);
        insertColumn(21, qsTr("保留19"), "reserve19", 100);
        insertColumn(22, qsTr("保留20"), "reserve20", 100);
        */
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


