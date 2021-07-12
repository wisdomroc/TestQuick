import QtQuick 2.0
import QtQuick.Layouts 1.13
import QtQuick.Controls 1.2 as QC12
import QtQuick.Controls 2.0

Item {
    width: 900
    height: 800
    property Item tanhuang: tanhuang
    property alias model: tableView.model
    ColumnLayout {
        anchors.fill: parent
        QC12.TableView {
            id :tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            model: []

            headerDelegate: headerDel  //表格头委托
            rowDelegate: rowDel    //表格行委托
            itemDelegate: Item {  //数据item委托
                Canvas{  //创建一个画布画矩形框的左边垂直线
                    width: 1 //宽度为1
                    height: parent.height    //高度为item的高度
                    anchors.left: parent.left //为item靠左对齐
                    visible: styleData.column == 0 ? false : false  //如果当前列是0列则显示，防止重叠
                    onPaint: {
                        var ctx = getContext("2d"); //获取画笔对象
                        ctx.strokeStyle = "red";  //设置颜色
                        ctx.lineWidth = 1;  //设置宽度，默认为1，可不写

                        ctx.beginPath();  //开始画路径
                        ctx.moveTo(0,0);  //移动到0,0点
                        ctx.lineTo(0,height); //移动到0,height点，此时为左边竖线
                        ctx.stroke();  //画出该图形
                    }
                }

                Canvas{ //画矩形框底线，每个item都要画
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.beginPath();
                        ctx.moveTo(0,0);
                        ctx.lineTo(width,0);
                        ctx.stroke();
                    }
                }

                Canvas{//画矩形框右边竖线，每个item都要画
                    width: 1
                    height: parent.height
                    anchors.right: parent.right
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.beginPath();
                        ctx.moveTo(0,0);
                        ctx.lineTo(0,height);
                        ctx.stroke();
                    }
                }

                Text{ //数据显示
                    color: "black"
                    anchors.centerIn: parent
                    text: styleData.value
                    font {
                        family: qsTr("微软雅黑")
                        pixelSize: 18
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: tableView.currentRow = styleData.row
                }
            }

            Component{ //表头委托，用于设置表头行高，内容显示，色彩等
                id: headerDel
                Rectangle{
                    color: "steelBlue"
                    border.width: 0
                    radius: 0
                    height: 30

                    Canvas{ //画矩形框底线，每个item都要画
                        width: parent.width
                        height: 1
                        anchors.bottom: parent.bottom
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.beginPath();
                            ctx.moveTo(0,0);
                            ctx.lineTo(width,0);
                            ctx.stroke();
                        }
                    }

                    Canvas{//画矩形框右边竖线，每个item都要画
                        width: 1
                        height: parent.height
                        anchors.right: parent.right
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.beginPath();
                            ctx.moveTo(0,0);
                            ctx.lineTo(0,height);
                            ctx.stroke();
                        }
                    }
                    Text{
                        anchors.centerIn: parent
                        text: styleData.value
                        color: "black"
                        font {
                            family: qsTr("微软雅黑")
                            pixelSize: 20
                        }
                    }
                }
            }

            Component{ //行委托，用于设置行高和每行背景色等，此处为透明
                id: rowDel
                Rectangle {
                    height: 30
                    color: tableView.currentRow === styleData.row ? "lightGray" : "transparent"
                }
            }

            QC12.TableViewColumn {
                role: "id"
                title: "ID"
                width: 80
                movable: false
            }

            QC12.TableViewColumn {
                role: "name"
                title: "NAME"
                width: 120
                movable: false
            }
            QC12.TableViewColumn {
                role: "sex"
                title: "SEX"
                width: 40
                movable: false
            }

            QC12.TableViewColumn {
                role: "value1"
                title: "VALUE1"
                width: 80
                movable: false
            }
            QC12.TableViewColumn {
                role: "value2"
                title: "VALUE2"
                width: 80
                movable: false
            }
            /*
            QC12.TableViewColumn {
                role: "value3"
                title: "VALUE3"
                width: 80
                movable: false
            }
            QC12.TableViewColumn {
                role: "value4"
                title: "VALUE4"
                width: 80
                movable: false
            }
            QC12.TableViewColumn {
                role: "value5"
                title: "VALUE5"
                width: 80
                movable: false
            }
            QC12.TableViewColumn {
                role: "value6"
                title: "VALUE6"
                width: 80
                movable: false
            }
            QC12.TableViewColumn {
                role: "value7"
                title: "VALUE7"
                width: 80
                movable: false
            }*/
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
                    studentTableModel.insertRows(2, 2);

                }
            }
            Button {
                id:removeRowBtn
                width: 120;
                height: 30;
                text: "Remove Rows"
                onClicked: {
                    console.log("Remove Rows Btn Clicked ...")
                    studentTableModel.removeRows(2,2);
                }
            }
            Item {
                id: tanhuang
                Layout.fillWidth: true
            }
        }
    }
}
