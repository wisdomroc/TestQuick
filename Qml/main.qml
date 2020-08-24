import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.0 as QC10
import QtQuick.Controls.Styles 1.0 as QCS10
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.11
import QtQuick.Particles 2.0
import "."

ApplicationWindow {
    id: root
    visible: false
    flags: Qt.FramelessWindowHint
    width: Screen.desktopAvailableWidth - 400
    height: Screen.desktopAvailableHeight - 200

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#0d1725"}
            GradientStop { position: 1; color: "#1d7078"}
        }
    }

    Loader {
        id: loader
        source: "qrc:/Qml/TimLogin.qml"
        visible: status === Loader.Ready
    }

    Connections {
        target: loader.item
        onLogin: {
            loader.source = ""
            root.visible = true
        }
    }

    PageIndicator {
        id: indicator

        count: swipeView.count
        currentIndex: swipeView.currentIndex

        anchors.bottom: swipeView.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    header: Rectangle {
        id: titleBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 10
        }
        height: 60

        color: "#2f2e4b"

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            property point cliCkPos: "0,0"
            onPressed: {
                cliCkPos=Qt.point(mouse.x,mouse.y) //得到鼠标的位置
            }
            onPositionChanged: {//鼠标按下后位置改变
                var delta=Qt.point(mouse.x-cliCkPos.x,mouse.y-cliCkPos.y)
                root.x=(root.x+delta.x) //mainWindow.x y 恒为0
                root.y=(root.y+delta.y)
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10

            Item {
                Layout.fillWidth: true
            }

            GoogleButton {
                id: googleButton
                height: closeBtn.height
            }

            Button {
                id: closeBtn
                text: "关闭"
                onClicked:Qt.quit()
                font.pointSize: 12
                font.family:"微软雅黑"

                contentItem: Text {
                    text: closeBtn.text
                    font: closeBtn.font
                    opacity: enabled ? 1.0 : 0.3
                    color: closeBtn.down ? "white" : "lightGray"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 80
                    implicitHeight: 36
                    color: "#2c66a5"
                    border.width: 2//按钮边框
                    border.color: closeBtn.hovered ? "lightGray":"gray"
                    radius: 4
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors{
            top: titleBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 10
        }

        currentIndex: 1

        Item {
            id: centerWidget

            ColumnLayout {
                anchors.fill: parent


                Rectangle {
                    id: splitter
                    Layout.fillWidth: true
                    height: 2
                    color: "black"
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 20

                    Rectangle {
                        id: listViewWrapper
                        width: 400
                        Layout.fillHeight: true
                        border.width: 2
                        border.color: "steelBlue"
                        radius: 5
                        anchors.top: splitter.bottom
                        anchors.topMargin: 20
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                        ListView {
                            id: recordView
                            anchors.fill: parent
                            anchors.margins: 6
                            model: readerModel
                            //            highlight: Rectangle { border.color: "red"; radius: 5 }
                            focus: true
                            spacing: 10
                            delegate: listdelegate

                            FontMetrics {
                                id: fontMetrics
                                font.family: "Microsoft Yahei"
                                font.pointSize: 10
                            }


                            Component{
                                id:listdelegate
                                Rectangle{
                                    id:delegateitem
                                    width: recordView.width
                                    height:fontMetrics.height
                                    TextEdit { text: id + "\t\t\t" + password; font: fontMetrics.font; anchors.fill: parent;
                                        readOnly: false
                                        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter;
                                        color: delegateitem.ListView.isCurrentItem ? "red" : "gray"
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                                        onClicked:{
                                            delegateitem.ListView.view.currentIndex = index
                                        }
                                        onPressed: {
                                            if(mouse.button == Qt.RightButton)
                                            {
                                                contextMenu.popup()
                                            }
                                        }

                                    }
                                }
                            }
                        }
                        Menu {
                            id: contextMenu
                            MenuItem { text: "Cut" }
                            MenuItem { text: "Copy" }
                            MenuItem { text: "Paste" }
                        }
                    }


                    Rectangle {
                        width: 400
                        Layout.fillHeight: true
                        ColumnLayout {
                            width: parent.width
                            height: parent.height
                            Rectangle {
                                id: tableViewWrapper
                                Layout.fillHeight: true
                                width: parent.width
                                border.width: 2
                                border.color: "steelBlue"
                                radius: 5

                                QC10.TableView {

                                    id :tableView
                                    anchors.fill: parent
                                    alternatingRowColors : false
                                    selectionMode: 1
                                    QC10.TableViewColumn {
                                        id: checkedColumn
                                        role: "id"
                                        title: "Id"
                                        width: tableView.viewport.width/tableView.columnCount
                                    }
                                    QC10.TableViewColumn {
                                        role: "password"
                                        title: "Password"
                                        width: tableView.viewport.width/tableView.columnCount
                                    }
                                    model: readerTableModel

                                    //自定义表头代理
                                    headerDelegate:
                                        Rectangle{
                                        //color: "#00498C"
                                        gradient: Gradient {
                                            GradientStop { position: 0.0; color: "#085FB2" }
                                            GradientStop { position: 1.0; color: "#00498C" }
                                        }
                                        //color : styleData.selected ? "blue": "darkgray"
                                        width: 100;
                                        height: 40
                                        border.color: "black"
                                        //border.width: 1
                                        //radius: 5
                                        Text
                                        {
                                            anchors.centerIn : parent
                                            text: styleData.value
                                            font.pixelSize: parent.height*0.5
                                        }
                                    }

                                    //行代理可以修改行高等信息
                                    rowDelegate: Rectangle {
                                        height: 50
                                        color: "#052641"
                                        anchors.leftMargin: 2

                                    }
                                    itemDelegate: Rectangle{
                                        border.width: 1
                                        color : styleData.selected ? "#dd00498C": "#052641"

                                        TextInput
                                        {
                                            anchors.fill: parent
                                            text: styleData.value
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            color: tableView.currentRow === styleData.row ? "red" : "green"
                                            visible: styleData.column === 0
                                            font.family: "Microsoft Yahei"
                                            font.pointSize: 20
                                        }
                                        TextArea {
                                            id: nameTextInput
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            text: styleData.value
                                            selectionColor: "#4283aa"
                                            selectedTextColor: "#ffffff"
                                            color: tableView.currentRow === styleData.row ? "red" : "green"
                                            visible: styleData.column === 1
                                            font.family: "Microsoft Yahei"
                                            font.pointSize: 20


                                            selectByMouse: true
                                        }
                                    }

                                    style: QCS10.TableViewStyle{
                                        textColor: "white"
                                        highlightedTextColor : "#00CCFE"  //选中的颜色
                                        backgroundColor : "#052641"

                                    }
                                }
                            }

                            RowLayout {
                                spacing: 10
                                Button {
                                    width: 120;
                                    height: 30;
                                    text: "Add Rows"
                                    onClicked: {
                                        console.log("Add Rows Btn Clicked ...")
                                        readerTableModel.insertRows(2, 2);

                                    }
                                }
                                Button {
                                    width: 120;
                                    height: 30;
                                    text: "Remove Rows"
                                    onClicked: {
                                        console.log("Remove Rows Btn Clicked ...")
                                        readerTableModel.removeRows(2,2);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        Item {
            Item {
                width: parent.width / 2
                height: parent.height
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 6
                    MyListView {
                        id: myListView
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Component.onCompleted: myListView.initData(10)
                    }

                    ColumnLayout {
                        Button {
                            id: addBtn
                            text: "Add"
                            onClicked: {
                                myListView.addOneRecord({'name': String(myListView.model.count)})
                                if(longWidth)
                                {
                                    longWidth = false
                                }
                                else
                                {
                                    longWidth = true
                                }
                            }
                        }
                        Button {
                            id: deleteBtn
                            text: "Delete"
                            onClicked: {
                                myListView.deleteOneRecord(myListView.view.currentIndex)
                            }
                        }
                    }


                    states: [
                        State {
                            name: "state_long"
                            when: longWidth
                            PropertyChanges {
                                target: addBtn
                                width: 200
                            }
                            PropertyChanges {
                                target: deleteBtn
                                width: 200
                            }
                        }

                    ]

                    transitions: [
                        Transition {
                            from: "*"
                            to: "*"
                            SequentialAnimation {
                                PropertyAnimation {target: addBtn; property: "width"; duration: 200;}
                                PropertyAnimation {target: deleteBtn; property: "width"; duration: 200;}
                            }
                        }
                    ]
                }
            }
        }
        Item {
            TreeView {
                id: item_tree
                width: parent.width/2
                anchors{
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 10
                }
                //model: []

                //set model data
                Component.onCompleted: {
                    setTestDataA();
                }
            }
            Column{
                anchors{
                    right: parent.right
                    top: parent.top
                    margins: 10
                }
                spacing: 10
                Button{
                    text: "ChangeModel"
                    checkable: true
                    //changed model data
                    onCheckedChanged: {
                        if(checked){
                            setTestDataB();
                        }else{
                            setTestDataA();
                        }
                    }
                }
                Button{
                    text: "AutoExpand"
                    onClicked: item_tree.autoExpand=!item_tree.autoExpand
                }
            }
        }
        TestTable {
            id: page5
        }
    }

    function setTestDataA(){
        item_tree.model=JSON.parse('[
        {
            "text":"1 one",
            "istitle":true,
            "subnodes":[
                {"text":"1-1 two","istitle":true},
                {
                    "text":"1-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"1-2-1 three","isoption":true},
                        {"text":"1-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"2 one",
            "istitle":true,
            "subnodes":[
                {"text":"2-1 two","istitle":true},
                {
                    "text":"2-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"2-2-1 three","isoption":true},
                        {"text":"2-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"3 one",
            "istitle":true,
            "subnodes":[
                {"text":"3-1 two","istitle":true},
                {"text":"3-2 two","istitle":true}
            ]
        }
    ]')
    }

    function setTestDataB(){
        item_tree.model=JSON.parse('[
        {
            "text":"1 one",
            "istitle":true,
            "subnodes":[
                {
                    "text":"1-1 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"1-1-1 three","isoption":true},
                        {"text":"1-1-2 three","isoption":true}
                    ]
                },
                {
                    "text":"1-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"1-2-1 three","isoption":true},
                        {"text":"1-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {
            "text":"2 one",
            "istitle":true,
            "subnodes":[
                {"text":"2-1 two","istitle":true},
                {
                    "text":"2-2 two",
                    "istitle":true,
                    "subnodes":[
                        {"text":"2-2-1 three","isoption":true},
                        {"text":"2-2-2 three","isoption":true}
                    ]
                }
            ]
        },
        {"text":"3 one","istitle":true},
        {
            "text":"4 one",
            "istitle":true,
            "subnodes":[
                {"text":"4-1 two","istitle":true},
                {"text":"4-2 two","istitle":true}
            ]
        }
    ]')
    }


    ParticleSystem
    {
        anchors.centerIn: parent
        ImageParticle
        {
            source: "qrc:///Image/flower.png"
            colorVariation: 0.75
        }

        Emitter
        {
            id: emitter
            enabled: false
            emitRate: 2000
            size: 32
            lifeSpan: 4000
            velocity: AngleDirection
            {
                magnitude: 200
                angleVariation: 360
            }

            Timer
            {
                id: emitterTimer
                running: emitter.enabled
                interval: 2000
                property var nextScene
                property var thisScene
                onTriggered:
                {
                    thisScene.visible = false;
                    nextScene.visible = true;
                    emitter.enabled = false;
                }
            }
        }
    }

    function sceneTransition( thisScene, nextScene )
    {
        emitterTimer.thisScene = thisScene;
        emitterTimer.nextScene = nextScene;
        emitter.enabled = true;
    }
}

