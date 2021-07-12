import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import "Component"

Item {

    id:root
    width: 640
    height: 480

    //    TreeViewStandard {
    //        id: treeViewTest
    //        anchors.fill: parent
    //        anchors.bottomMargin: 50
    //    }

        property var ss: 0





    EfficientTable {
        id:tableRoot
        anchors.fill: parent;
        anchors.bottomMargin: 50
    }


    Row {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        Button {
            text:"添加数据"
            onClicked: {
                if (dataTimer.running)
                {
                    dataTimer.stop()
                }
                else
                {
                    dataTimer.start()
                }
            }
        }

        Button {
            text:"删除数据"
            onClicked: {

                tableRoot.removeRow(tableRoot.currentIndex,1)
            }
        }

        Button {
            text:"过滤数据"
            onClicked: {
                tableRoot.filterMode = !tableRoot.filterMode
            }
        }

        Button {
            text:"打印"
            onClicked: {
                console.log(tableRoot.rows)
            }
        }
    }

    Component.onCompleted: {

        for (var j=0; j <300;j++){
            tableRoot.insertColumn(j,"列"+String(j) , "C"+String(j) ,100)
        }

        dataTimer.start();
    }

    Timer {
        id:dataTimer
        interval:1000
        repeat: false
        onTriggered: {
            console.time("test1")


            var datas = []
            for (var j=0; j <100;j++)
            {
                var data = {}
                for (var i=0; i < 300; i++)
                {
                    var roleName = "C"+String(i)
                    data[roleName]= "----"+String(ss)
                }

                ss =  ss +1
                datas.push(data)
            }
            console.timeEnd("test1")
            tableRoot.insertRows(tableRoot.rows,datas)
            tableRoot.table.contentY = tableRoot.table.contentHeight + tableRoot.height
            console.log("contentHeight: " + tableRoot.table.contentHeight)
        }
    }
}

