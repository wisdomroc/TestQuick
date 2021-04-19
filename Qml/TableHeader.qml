import QtQuick 2.12
import QtQuick.Controls 2.12

Item{
    id: header_horizontal

    //暂存鼠标拖动的位置
    property int posXTemp: 0
    MouseArea{
        anchors.fill: parent
        onPressed: header_horizontal.posXTemp=mouseX;
        onPositionChanged: {
            if(table_view.contentX+(header_horizontal.posXTemp-mouseX)>0){
                table_view.contentX+=(header_horizontal.posXTemp-mouseX);
            }else{
                table_view.contentX=0;
            }
            header_horizontal.posXTemp=mouseX;
        }
    }
    Row {
        id: header_horizontal_row
        anchors.fill: parent
        leftPadding: -table_view.contentX
        clip: true

        Repeater {
            model: table_view.columns > 0 ? table_view.columns : 0

            Rectangle {
                id: header_horizontal_item
                width: table_view.columnWidthProvider(index)+table_view.columnSpacing
                height: parent.height
                color: "red"//自己配色


                border.width: 1
                border.color: "#1a2b3c"


                Label {
                    width:parent.width
                    height:control.horHeaderHeight
                    horizontalAlignment: Text.AlignHCenter
                    //anchors.fill: parent
                    text: _sourceModel.headerData(index,Qt.Horizontal)
                }

                Rectangle {
                    width: parent.width
                    height: filterMode*25
                    anchors.bottom: parent.bottom
                    color: "blue"
                    visible:height !== 0
                    TextInput{
                        anchors.fill: parent
                        onTextChanged:{
                          //  console.log(text,index)
                            //设置过滤条件
                            _displayModel.setCondition(index,text)

                            table_view.forceLayout()
                        }
                    }
                    Behavior on height {
                        PropertyAnimation{ duration : 200 }
                    }
                }





                Rectangle{
                    width: 1
                    height: parent.height
                    anchors.right: parent.right
                    color: "black"
                    opacity: 0.5
                }
                MouseArea{
                    width: 3
                    height: parent.height
                    anchors.right: parent.right
                    cursorShape: Qt.SplitHCursor
                    onPressed: header_horizontal.posXTemp=mouseX;
                    onPositionChanged: {
                        if((header_horizontal_item.width-(header_horizontal.posXTemp-mouseX))>10){
                            header_horizontal_item.width-=(header_horizontal.posXTemp-mouseX);
                        }else{
                            header_horizontal_item.width=10;
                        }
                        header_horizontal.posXTemp=mouseX;

                        //改变某列的宽度
                        control._columnWidthArr[index]=(header_horizontal_item.width-table_view.columnSpacing);
                        //刷新布局，这样宽度才会改变
                        table_view.forceLayout();
                    }
                }
            }
        }
    }
}
