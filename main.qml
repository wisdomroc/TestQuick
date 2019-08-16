import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.0 as QC10
import QtQuick.Controls.Styles 1.0 as QCS10
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import "."

ApplicationWindow {
    property int standardWidth: 50
    property int standardHeight: 50
    id: root
    visible: true
    width: 1600
    height: 1000
    title: qsTr("c")


    Rectangle {
        id: listViewWrapper
        width: 300
        height: 200
        border.width: 2
        border.color: "steelBlue"
        radius: 5

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
        id: tableViewWrapper
        anchors.top: listViewWrapper.bottom
        width: 500
        height: 400
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
                //color: "#052641"
                border.width: 1
                color : styleData.selected ? "#dd00498C": "#052641"

//                CheckBox
//                {
//                    anchors.centerIn: parent
//                    checked: styleData.value === "1" ? true : false
//                    visible: isCheckColumn( styleData.column )
//                }

                TextInput
                {
                    anchors.fill: parent
                    text: styleData.value
                    color: tableView.currentRow === styleData.row ? "red" : "green"
                    visible: !isCheckColumn( styleData.column )
                }
                TextArea {
                    id: nameTextInput
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: styleData.value
                    selectionColor: "#4283aa"
                    selectedTextColor: "#ffffff"
                    color: tableView.currentRow === styleData.row ? "red" : "green"
                    visible: !isCheckColumn( styleData.column )

                    selectByMouse: true


                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            if (pressed) {
                                tableView.currentColumn = styleData.column;
                            }
                            mouse.accepted = false;
                        }
                    }
                }

                function isCheckColumn( columnIndex )
                {
                    return tableView.getColumn( columnIndex ) === checkedColumn
                }
            }

            style: QCS10.TableViewStyle{
                textColor: "white"
                highlightedTextColor : "#00CCFE"  //选中的颜色
                backgroundColor : "#052641"

            }
        }
    }

    MyListView {
        x: 600
        anchors.top: parent.top

    }
}

