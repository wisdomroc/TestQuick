import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQml.Models 2.11
import QtQuick.Layouts 1.0

Rectangle {
    id: listViewWrapper
    property bool refreshFlag: false
    property alias model: listModel
    property alias view: listView

    radius: 5
    border.width: 2
    border.color: listView.activeFocus ? "blue" : "gray"

    activeFocusOnTab: true
    onFocusChanged: {
        listView.forceActiveFocus()
    }



    function initData(count) {
        var i = 0;
        while(i < count)
        {
            var info = {'name': "Row" + i}
            listModel.append(info)
            i ++
        }
    }

    function addOneRecord(num) {
        listModel.append(num)
    }

    function deleteOneRecord(index) {
        listModel.remove(index)
        console.log("listModel remove index: " + index)
    }



    Rectangle{
        width: parent.width
        height: -listView.contentY
        color: "cyan"
        ColumnLayout {
            anchors.fill: parent
            Item {
                Layout.fillHeight: true
            }

            Label{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                text:qsTr("下拉刷新")
                font.pointSize: 14
                visible: listView.contentY
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
        id: listModel
    }

    ListView{
        id:listView
        anchors.fill: parent
        anchors.margins: 6
        keyNavigationEnabled: true
        keyNavigationWraps: true
        model: listModel
        focus: true
        //! 可以用于切换界面的切换
        //orientation: ListView.Horizontal

        onContentYChanged: {
            if(-contentY > 40){
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
            width: listView.width
            height: 30
            color: index % 2 ? "white":"gray"
            border.width: 2
            border.color: listView.currentIndex == index ? "steelBlue" : "lightGray"
            Label{
                id:txt
                anchors.centerIn: parent
                font.pointSize: 20
                text: name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: listView.currentIndex = index
            }
        }
    }




}
