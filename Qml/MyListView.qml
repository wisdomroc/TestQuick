import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQml.Models 2.11
import QtQuick.Layouts 1.0

Rectangle {
    property bool refreshFlag: false
    property alias model: _listModel
    property alias view: _listView

    radius: 5
    border.width: 3
    border.color: _listView.activeFocus ? "lightGreen" : "gray"

    // 下拉刷新功能的实现代码
    Rectangle{
        width: parent.width
        height: Math.max(-_listView.contentY, 30)
        y: _listView.contentY +30>0 ?   -(_listView.contentY +30) : 0
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
        id: _listModel
        ListElement { name: "ConstructInfo 0" }
        ListElement { name: "ConstructInfo 1" }
        ListElement { name: "ConstructInfo 2" }
        ListElement { name: "ConstructInfo 3" }
        ListElement { name: "ConstructInfo 4" }
        ListElement { name: "ConstructInfo 5" }
        ListElement { name: "ConstructInfo 6" }
        ListElement { name: "ConstructInfo 7" }
        ListElement { name: "ConstructInfo 8" }
        ListElement { name: "ConstructInfo 9" }
    }

    ListView{
        id:_listView
        anchors.fill: parent
        anchors.margins: 6
        keyNavigationEnabled: true
        keyNavigationWraps: true
        model: _listModel
        clip: true

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
            width: _listView.width
            height: 30
            radius: 5
            border.color: "white"
            border.width: 1
            color: _listView.currentIndex === index ? "lightGreen" : "steelBlue"
            Label{
                anchors.centerIn: parent
                font.pointSize: 20
                text: name
            }
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    _listView.currentIndex = index
                    _listView.forceActiveFocus()
                    if(mouse.button === Qt.RightButton)
                    {
                        console.log("rightBtn click...")
                        contextMenu.popup()
                    }
                }
            }
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
        theList:_listView
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
        //        var i = 0;
        //        while(i < count)
        //        {
        //            var info = {'name': "Construc Info " + i}
        //            _listModel.append(info)
        //            i ++
        //        }
    }

    function addOneRecord(info) {
        _listModel.append(info)
    }

    function deleteOneRecord(index) {
        _listModel.remove(index)
    }
}
