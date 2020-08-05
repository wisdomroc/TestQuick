import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

ApplicationWindow {
    id:rootWindow
    visible: true
    width: 800
    height: 600
    flags: Qt.Window | Qt.FramelessWindowHint
    background: Item {

    }

    property int originWidth: 500
    property int originHeight: 300
    property string fontFamily: "微软雅黑"
    property int fontSize: 12

    MouseArea {
        anchors.fill: parent
        property point originalPos
        property bool isPressed: false
        onPressed: {
            isPressed = true
            originalPos = Qt.point(mouse.x, mouse.y)
            console.log("originalPos-->" + originalPos)
        }
        onPositionChanged: {
            if(isPressed)
            {
                var newPos = Qt.point(mouse.x, mouse.y)
                var dis_x = newPos.x - originalPos.x
                var dis_y = newPos.y - originalPos.y
                console.log("distance-->" + dis_x + ", " + dis_y)
                rootWindow.x += dis_x
                rootWindow.y += dis_y
            }
        }
        onReleased: {
            isPressed = false
        }
    }


    Flipable {
        id: flipable
        anchors.centerIn: parent
        width: 500
        height: 300

        property bool flipped: false//翻转状态保存
        front:  Rectangle{//正面的内容
            id:front
            height: flipable.width
            width: flipable.height
            color: "gray"
            anchors.centerIn: parent
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 6
                Text {
                    id: name
                    text: "我是正面"
                    horizontalAlignment: Qt.AlignHCenter
                    color: "green"
                    font.family: fontFamily
                    font.pointSize: fontSize
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                }

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 200
                    Layout.preferredHeight: 80
                    radius: 5
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "gray"
                        anchors.centerIn: parent
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        TextEdit {
                            id: username
                            Layout.fillWidth: true
                            font.family: fontFamily
                            font.pointSize: fontSize

                            Text {
                                text: "用户名/邮箱/手机号"
                                font.family: fontFamily
                                font.pointSize: fontSize
                                color: "lightGray"
                                visible: username.text === ""
                                anchors.fill: username
                            }

                            Text {
                                text: "注册账号"
                                color: "blue"
                                visible: username.text === ""
                                anchors.left: username.right
                            }
                        }

                        TextEdit {
                            id: password
                            Layout.fillWidth: true
                            font.family: fontFamily
                            font.pointSize: fontSize

                            Text {
                                text: "密码"
                                font.family: fontFamily
                                font.pointSize: fontSize
                                color: "lightGray"
                                visible: password.text === ""
                                anchors.fill: password
                            }

                            Text {
                                text: "忘记密码"
                                color: "blue"
                                visible: password.text === ""
                                anchors.left: password.right
                            }
                        }
                    }
                }

                Row {
                    Layout.alignment: Qt.AlignHCenter
                    CheckBox {
                        text: "记住密码"
                    }

                    CheckBox {
                        text: "自动登录"
                    }
                }

                Button {
                    text: "安全登录"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        flipable.flipped = !flipable.flipped

                        var component = Qt.createComponent("main.qml");
                                  if (component.status === Component.Ready) {
                                      var mainWindow = component.createObject(NULL);
                                      rootWindow.showMaximized()
                                  }
                    }
                }

            }
        }
        back: Rectangle{//背面的内容
            id:back
            height: flipable.width
            width: flipable.height
            color: "lightgray"
            anchors.centerIn: parent

            Button {
                text: "BACK"
                width: 100
                height: 40
                onClicked: flipable.flipped = !flipable.flipped
            }

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
            NumberAnimation { target: rotation; property: "angle"; duration: 2000 }
        }
    }




//    MouseArea {//鼠标事件
//        anchors.fill: parent
//        onClicked: {
//            flipable.flipped = !flipable.flipped//翻转状态切换
//                            if(flipable.flipped){//根据翻转状态，调用不同的翻转高度变化动画
//                                toback.start()
//                                console.log("1")
//                            }else{
//                                tofront.start()
//                                console.log("2")
//                            }
//        }
//    }




//    Flipable {
//        id: flipable
//        anchors.centerIn: parent
//        width: 240
//        height: 240

//        property bool flipped: false

//        front: Rectangle { width: flipable.width; height: flipable.height; color: "red"; anchors.centerIn: parent }
//        back: Rectangle { width: flipable.width; height: flipable.height; color: "green"; anchors.centerIn: parent }

//        transform: Rotation {
//            id: rotation1
//            origin.x: flipable.width/2
//            origin.y: flipable.height/2
//            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
//            angle: 0    // the default angle
//        }

//        states: State {
//            name: "back"
//            PropertyChanges { target: rotation1; angle: 180 }
//            when: flipable.flipped
//        }

//        transitions: Transition {
//            NumberAnimation { target: rotation1; property: "angle"; duration: 4000 }
//        }

//        MouseArea {
//            anchors.fill: parent
//            onClicked: flipable.flipped = !flipable.flipped
//        }
//    }



}
