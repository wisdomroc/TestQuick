import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQml.Models 2.11
import QtQuick.Layouts 1.0

Rectangle {
    property bool refreshFlag: false
    property alias model: __listModel
    property alias view: __listView

    radius: 5
    border.width: 3
    border.color: __listView.activeFocus ? "lightGreen" : "gray"

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

    ListModel {
        id: __listModel
    }

    ListView{
        id:__listView
        anchors.fill: parent
        anchors.margins: 6
        keyNavigationEnabled: true
        keyNavigationWraps: true
        model: __listModel
        spacing: 10
        clip: true
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

        delegate: Rectangle{
            id: __listViewDelegate
            width: __listView.width
            height: 60
            radius: 5
            border.color: "white"
            border.width: 1
            color: ListView.isCurrentItem ? "lightGreen" : "steelBlue"
            //或者使用下面的方式
            //color: __listView.currentIndex === index ? "lightGreen" : "steelBlue"
            Label{
                anchors.centerIn: parent
                font.pointSize: 20
                text: name
            }
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    __listView.currentIndex = index
                    __listView.forceActiveFocus()
                    if(mouse.button === Qt.RightButton)
                    {
                        console.log("rightBtn click...")
                        contextMenu.popup()
                    }
                }
            }
            Component.onDestruction: console.log("ListModel " + index + "destroyed...")
            Component.onCompleted: console.log("ListModel " + index + "created...")
        }

        populate: Transition {
            NumberAnimation { properties: "x, y"; duration: 300 }
        }

        add: Transition {
            PropertyAction { properties: "transformOrigin"; value: Item.TopLeft }
            NumberAnimation { properties: "scale"; from: 0; to: 1.0; duration: 1000}
            NumberAnimation { properties: "opacity"; from: 0; to: 1.0; duration: 1000}
        }

        displaced: Transition {
            PropertyAction { properties: "opacity, scale"; value: 1 }
            NumberAnimation { properties: "x, y"; duration: 1000 }
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

    function addOneRecord(info) {
        __listModel.append(info)
    }

    function deleteOneRecord(index) {
        __listModel.remove(index)
    }
}


