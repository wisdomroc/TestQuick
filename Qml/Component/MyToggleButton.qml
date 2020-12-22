import QtQuick 2.0

Rectangle {
    id: toggleButton
    width: 100
    height:40
    radius: 20
    color: "#EAEAEA"
    signal stateChanged()

    property alias root_state: handle.state
    Rectangle {
        id: handle
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        state: "left"
        radius: parent.radius
        width: 60
        color: handle.state == "left"? "#4040FF" : "#CCCCCC"

        Text {
            anchors.centerIn: parent
            text: handle.state === "left" ? qsTr("打开") : qsTr("关闭")
            color: handle.state === "left" ? "black": "#4040FF"
        }

        states: [
            State {
                name: "right"
                PropertyChanges {
                    target: handle
                    x: toggleButton.width - handle.width
                }
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { property: "x"; duration: 200 }
            }
        ]
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(handle.state == "left")
            {
                handle.state = "right";
            }
            else
            {
                handle.state = "left";
            }
        toggleButton.stateChanged()
        }
    }
}
