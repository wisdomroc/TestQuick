
import QtQuick 2.12
import QtQuick.Controls 2.5

/* 用在EfficientTable.qml中，提供水平和垂直滚动条 */

ScrollBar {
    id:scroRoot
    policy: ScrollBar.AlwaysOn
    contentItem: Rectangle{
        visible: (scroRoot.size<1.0)
        color: scrollBarColor
    }
}
