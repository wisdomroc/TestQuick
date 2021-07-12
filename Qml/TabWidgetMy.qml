import QtQuick 2.0

Item {
    /* 自定义的一个类，使用的时候，直接在该类中添加Rectangle，底色为#e3e3e3，然后定义一个title属性。就可以使用了
       在Rectangle里面可以进行界面定制 */
    id: tabWidget

    default property alias content: stack.children

    property int current: 0;

    onCurrentChanged: setOpacities()
    Component.onCompleted: setOpacities()

    function setOpacities() {
        for(var i = 0; i < stack.children.length; ++i) {
            stack.children[i].opacity = (i === current ? 1 : 0)
        }
    }

    Row {
        id: header

        Repeater {
            model: stack.children.length
            delegate: Rectangle {
                width: tabWidget.width / stack.children.length; height: 36

                Rectangle {
                    width: parent.width; height: 1
                    anchors { bottom: parent.bottom; bottomMargin: 1 }
                    color: "#acb2c2"
                }
                BorderImage {
                    anchors { fill: parent; leftMargin: 2; topMargin: 5; rightMargin: 1 }
                    border { left: 7; right: 7 }
                    source: "qrc:/Image/tab.png"
                    visible: tabWidget.current === index
                }
                Text {
                    horizontalAlignment: Qt.AlignHCenter; verticalAlignment: Qt.AlignVCenter
                    anchors.fill: parent
                    text: stack.children[index].title
                    elide: Text.ElideRight
                    font.bold: tabWidget.current === index
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: tabWidget.current = index
                }
            }
        }
    }


    Item {
        id: stack
        width: tabWidget.width
        anchors.top: header.bottom; anchors.bottom: tabWidget.bottom
    }

}
