﻿import QtQuick 2.7
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
    visible: true
    width: loginDlg.width
    height: loginDlg.height
    flags: Qt.Window | Qt.FramelessWindowHint //need Qt.Window, because of the windows's statusBar need


    Timer {
        id: delayTimer
        running: false
        interval: 500
        repeat: false
        onTriggered: {
            loginDlg.visible = false
            centerWidget.visible = true
            root.showMaximized()
        }
    }


    TimLogin {
        id: loginDlg
        visible: true
        anchors.centerIn: parent
    }


    Item {
        id: centerWidget
        anchors.fill: parent

        visible: false
        ColumnLayout {
            anchors.fill: parent
            Rectangle {
                id: titleBar
                Layout.fillWidth: true
                height: closeBtn.height

                color: "lightGray"

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
                    spacing: 10
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
                            color: "gray"
                            border.width: closeBtn.hovered ? 2 : 0.5//按钮边框
                            border.color: closeBtn.hovered ? "lightblue":"lightgray"
                            radius: 4
                        }
                    }

                    GoogleButton {
                        id: googleButton
                        height: closeBtn.height
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                }
            }

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

                MyListView {
                    id: listView
                    width: root.width / 2
                    Layout.fillHeight: true
                    Component.onCompleted: listView.initData(10)
                }

            }
        }
    }

    ParticleSystem
    {
        anchors.centerIn: parent
        ImageParticle
        {
            source: "qrc:///images/flower.png"
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

