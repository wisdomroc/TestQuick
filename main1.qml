import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0

Window {
    visible: true
    width: 250
    height: 350
    property bool checked: false
    property bool longWidth: false

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
