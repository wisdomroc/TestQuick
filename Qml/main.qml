import QtQuick 2.13
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import QtQuick.Window 2.12
import QtQuick.Particles 2.12
import "."
import "Component"

ApplicationWindow {
    id: root
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#0d1725"}
            GradientStop { position: 1; color: "#1d7078"}
        }
    }

    Loader {
        id: loader
        source: ""  //qrc:/Qml/TimLogin.qml
        visible: status === Loader.Ready
    }

    Connections {
        target: loader.item
        onLogin: {
            loader.source = ""
            root.visible = true
        }
    }

    MyBusyIndicator {
        width: 200
        height: 200
        anchors.centerIn: parent
        z: 10
        visible: false
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
        height: 60
        color: "#2f2e4b"
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            property point clickPos: "0,0"
            onPressed: {
                clickPos=Qt.point(mouse.x,mouse.y) //得到鼠标的位置
            }
            onPositionChanged: {//鼠标按下后位置改变
                var delta=Qt.point(mouse.x-clickPos.x,mouse.y-clickPos.y)
                root.x=(root.x+delta.x) //mainWindow.x y 恒为0
                root.y=(root.y+delta.y)
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Text {
                    id: titleName
                    anchors.fill: parent
                    color: "white"
                    text: swipeView.titleList[swipeView.currentIndex]
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    font{
                        family: qsTr("微软雅黑")
                        pixelSize: 20
                    }
                }
            }

            GoogleButton {
                id: googleButton
                height: closeBtn.height
            }

            Button {
                id: closeBtn
                text: "关闭"
                onClicked:Qt.quit()
                font{
                    family: qsTr("微软雅黑")
                    pointSize: 12
                }

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
                    implicitHeight: 40
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
        clip: true
        currentIndex: 1
        property var titleList: ["Control_1.TableView & Control_2.TableView Examples", "DragRefresh、ListModel、ListView、AddRow、RemoveRow", "TreeView Examples", "Test Examples"]
        Item {
            id: page0
            RowLayout {
                anchors.fill: parent

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.width: 2
                    border.color: tableView.activeFocus || addRowBtn.activeFocus || removeRowBtn.activeFocus ? "red" : "gray"
                    radius: 5
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        TableView {
                            id :tableView
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            columnSpacing: 1
                            rowSpacing: 1
                            clip: true






                            model: readerTableModel

                            //自定义表头代理
//                                                        headerDelegate:
//                                                            Rectangle{
//                                                            //color: "#00498C"
//                                                            gradient: Gradient {
//                                                                GradientStop { position: 0.0; color: "#085FB2" }
//                                                                GradientStop { position: 1.0; color: "#00498C" }
//                                                            }
//                                                            //color : styleData.selected ? "blue": "darkgray"
//                                                            width: 100;
//                                                            height: 40
//                                                            border.color: "black"
//                                                            //border.width: 1
//                                                            //radius: 5
//                                                            Text
//                                                            {
//                                                                anchors.centerIn : parent
//                                                                text: styleData.value
//                                                                font.pixelSize: parent.height*0.5
//                                                            }
//                                                        }




                            delegate: Rectangle {
                                implicitWidth: 100
                                implicitHeight: 50
                                Text {
                                    text: id + password
                                }
                            }

                        }

                        RowLayout {
                            Layout.fillWidth: true
                            height: addRowBtn.height
                            Button {
                                id: addRowBtn
                                width: 120;
                                height: 30;
                                text: "Add Rows"
                                onClicked: {
                                    console.log("Add Rows Btn Clicked ...")
                                    readerTableModel.insertRows(2, 2);

                                }
                            }
                            Button {
                                id:removeRowBtn
                                width: 120;
                                height: 30;
                                text: "Remove Rows"
                                onClicked: {
                                    console.log("Remove Rows Btn Clicked ...")
                                    readerTableModel.removeRows(2,2);
                                }
                            }
                            Item {
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: page1
            ColumnLayout {
                anchors.fill: parent
                MyListView {
                    id: myListView
                    width: 600
                    Layout.fillHeight: true
                    Component.onCompleted: {
                        myListView.initData(10)
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignBottom
                    Button {
                        id: addBtn
                        text: "Add"
                        onClicked: {
                            myListView.addOneRecord({'name': String("Construc Info " + myListView.model.count)})
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
            }
        }
        Item {
            id: page2
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
            id: page3
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

