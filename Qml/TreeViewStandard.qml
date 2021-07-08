import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2
//! 存在问题：TreeView的下面有一小段空白
Rectangle {
    border.color: "darkCyan"

    TreeView {
        id: myTree
        height: parent.height
        width: parent.width*(3/4)
        model: treeModel
        selection: sel
        style: treeViewStyle

        TableViewColumn {
            title: "Name"
            role: "name"
            width: 150
        }
        TableViewColumn {
            title: "YuWen"
            role: "yuwen"
            width: 200
        }
        TableViewColumn {
            title: "ShuXue"
            role: "shuxue"
            width: 200
        }
        TableViewColumn {
            title: "WaiYu"
            role: "waiyu"
            width: 200
        }
        TableViewColumn {
            title: "Score"
            role: "zongfen"
            width: 150
        }
        TableViewColumn {
            title: "AverageScore"
            role: "pingjunfen"
            width: 200
        }
        TableViewColumn {
            title: "HeGe"
            role: "hege"
            width: 200
        }
        TableViewColumn {
            title: "YouXiu"
            role: "youxiu"
            width: 200
        }

        itemDelegate: Item {
            Text{
                id:itemText
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                elide: styleData.elideMode
                text: styleData.value
                color: styleData.selected ? "#007dff":"white"
                font.pointSize:styleData.selected ? 12:10
                font.bold: styleData.selected ? true:false

                //! [使支持拖拽操作]
                Drag.active: styleData.depth<1 ? false:itemMosue.drag.active;   //一级节点不可拖动
                Drag.supportedActions: Qt.CopyAction;                           //选择复制数据到DropArea
                Drag.dragType: Drag.Automatic;                                  //选择自动开始拖动
                Drag.mimeData: {"text": text}                                   //选择要传的数据，这里传文本

                MouseArea{
                    id:itemMosue
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: itemText

                    Drag.onDragStarted: {
                        console.log("start")
                    }
                    onPressed: {
                        //点击了文字，选中该节点[QItemSelectionModel::Current为0x0010]
                        //                     [QItemSelectionModel::Select为 0x0002]
                        sel.setCurrentIndex(styleData.index,0x0010)

                        if(styleData.isExpanded)
                        {
                            myTree.collapse(styleData.index)
                        }
                        else
                        {
                            myTree.expand(styleData.index)
                        }
                    }
                    //onReleased: parent.Drag.drop()
                }
            }
        }
    }

    ItemSelectionModel {            //自定义添加选中
        id: sel
        model: treeModel;
    }

    Component {
        id:treeViewStyle            //树的自定义样式
        TreeViewStyle {
            indentation: 30         //节点间隔
            branchDelegate: Image { //节点的展开标记图
                id:image
                source: styleData.isExpanded ? "qrc:/Image/collapse.png" : "qrc:/Image/expansion.png"
                width: 9
                height:9
                anchors.top:parent.top
                anchors.topMargin: 2
            }
            rowDelegate: Rectangle {
                height: 26
                color:styleData.selected? "lightGray" : "steelBlue" //这里决定了选中的颜色和背景颜色
            }
            headerDelegate: Rectangle {
                height: 30
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "lightBlue" }
                    GradientStop { position: 0.5; color: "blue" }
                    GradientStop { position: 1.0; color: "darkBlue" }
                }
                Text {
                   anchors.fill: parent
                   color: "white"
                   text: styleData.value
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignHCenter
                }
                Rectangle {
                    width: 1
                    height: parent.height
                    anchors.right: parent.right
                    color: "steelBlue"
                }
            }
        }
    }

    Rectangle{
        id:dropContainer
        height: parent.height
        width: parent.width/4
        anchors.left: myTree.right
        Text {
            id: accptedText
            text: qsTr("请拖动树节点到该矩形框!!!")
            color: "red"
        }
        border.color: "red"
        border.width: 1
        DropArea{
            id:myDropArea
            anchors.fill: parent
            onDropped: {
                if(drop.supportedActions == Qt.CopyAction){
                    accptedText.text=drop.getDataAsString("text")
                }
            }
        }
    }
}
