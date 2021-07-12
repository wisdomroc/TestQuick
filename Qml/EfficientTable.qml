import QtQuick 2.12

//import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12
import EfficientModel 0.1
import SortFilterModel 0.1

/* 自定义QtQuick 2中的TableView */
Item {
    id: control


    //行表头-竖向的
    property int rowHeight: 30

    //列表头-横向的
    property int horHeaderHeight: 30

    //滚动条
    property color scrollBarColor: "yellow"
    property int scrollBarWidth: 11
    //行数
    property alias  rows: table_view.rows
    //当前选中行
    property int currentIndex: -1

    //是否使用过滤模式
    property bool filterMode:true

    property alias  table: table_view

    //列宽
    property variant _columnWidthArr: []


    EfficientModel{
        id:_sourceModel
    }

    SortFilterModel {
        id:_displayModel
    }

    Component.onCompleted: {
        _displayModel.setModel(_sourceModel)
    }

    //表格内容（不包含表头）
    TableView{
        id: table_view
        anchors{
            fill: parent
            topMargin: _tableHeader.height
        }

        clip: true /* 会根据外框Item的边界进行剪切 */
        boundsBehavior: Flickable.StopAtBounds

        //rowSpacing: 1

        //视图的高度
        //contentHeight: rowHeightProvider(0) * rows + rowHeightProvider(rows-1)
        //视图的宽度
        //contentWidth:
        //content内容区域边距，但是不影响滚动条的位置
        //leftMargin:
        //topMargin:
        //此属性可以包含一个函数，该函数返回模型中每行的行高
        rowHeightProvider: function (row) {
            return control.rowHeight;
        }
        //此属性可以保存一个函数，该函数返回模型中每个列的列宽
        columnWidthProvider: function (column) {
            return control._columnWidthArr[column];
        }
        ScrollBar.horizontal: TableScrollBar {
            id: scroll_horizontal
            anchors.bottom: parent.bottom
            implicitHeight:scrollBarWidth
        }
        ScrollBar.vertical: TableScrollBar {
            id: scroll_vertical
            anchors.right: parent.right
            implicitWidth: scrollBarWidth
        }

        //model是在C++中定义的
        model:_sourceModel

        delegate: TableCell{}
        MouseArea { /*** 直接将MouseArea覆盖到TableView上，那么mouse.y会跟着TableView的滚动而变大 ***/
            anchors.fill: parent
            onClicked: {
                control.currentIndex = parseInt(mouse.y/control.rowHeight)
                console.log("mouse.y: " + mouse.y )
            }
        }
    }


    //横项表头
    TableHeader{
        id:_tableHeader
        anchors{
            left: parent.left
            right: parent.right
        }
        height: control.horHeaderHeight + filterMode*25
        Behavior on height {
            PropertyAnimation{ duration : 200 }
        }
        z: 2
    }


    //添加新列
    function insertColumn(tableIndex,columnName,roleName,width){
        _columnWidthArr.splice(tableIndex,0,width)
        _sourceModel.insertColumn(tableIndex,columnName,roleName)
    }
    //添加数据
    function insertRow(row,data){
        _sourceModel.insertRow(row,data)
    }
    //添加数据
    function insertRows(row,datas){
        _sourceModel.insertDatas(row,datas)
    }


    //删除数据
    function removeRow(row,count){
        _sourceModel.removeRows(row,count)
    }
}

