﻿import QtQuick 2.10
import QtQuick.Window 2.10

Window {
    id:rootWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("QQ登录界面实现")
    flags:Qt.Window | Qt.FramelessWindowHint//窗口设置为无边框
    color: "transparent"//颜色为透明

    property int originWidth: 500
    property int originHeight: 300

    Flipable {
        id: flipable
        anchors.centerIn: parent
        width: originWidth
        height: originHeight

        property bool flipped: false//翻转状态保存
        front:  Rectangle{//正面的内容
            id:front
            height: originHeight
            width: originWidth
            color: "gray"
            anchors.centerIn: parent
            Text {
                id: name
                text: "我是正面"
                color: "green"
                anchors.centerIn: parent
                font.pointSize: 14
                font.family: "微软雅黑"
            }
        }
        back: Rectangle{//背面的内容
            id:back
            height: originHeight
            width: originWidth
            color: "lightgray"
            anchors.centerIn: parent
            Text {
                id: name1
                text: "我是背面"
                color: "blue"
                anchors.centerIn: parent
                font.pointSize: 14
                font.family: "微软雅黑"
            }
        }

        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0
            angle: 0
        }
        SequentialAnimation {//接序动画（正面到背面的高度变化）
            id:toback
            NumberAnimation{ target: front; property: "height";from: rootWindow.height;to:rootWindow.height-200;duration:250}
            NumberAnimation{target: back;property: "height";from: rootWindow.height-200;to:rootWindow.height;duration: 250}
        }
        SequentialAnimation {//接序动画（背面到正面的高度变化）
            id:tofront
            NumberAnimation{ target: back; property: "height";from: rootWindow.height;to:rootWindow.height-200;duration:250}
            NumberAnimation{target: front;property: "height";from: rootWindow.height-200;to:rootWindow.height;duration: 250}
        }
        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle:180 }//将rotation角度调整为180度
            when: flipable.flipped//当flipable.flipped为真的时候
        }

        transitions: Transition {//转动的动画
            NumberAnimation { target: rotation; property: "angle"; duration: 500 }
        }
    }
    MouseArea {//鼠标事件
        anchors.fill: parent
        onClicked: {
            flipable.flipped = !flipable.flipped//翻转状态切换
//                            if(flipable.flipped){//根据翻转状态，调用不同的翻转高度变化动画
//                                toback.start()
//                                console.log("1")
//                            }else{
//                                tofront.start()
//                                console.log("2")
//                            }
        }
    }
}
