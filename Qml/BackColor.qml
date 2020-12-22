import QtQuick 2.0
/**
  *配合MouseArea组合成 带一个图片作为底色&有外框 的Button*
  **/

Item {
    property alias visibleRec: rec.visible
    property alias source: image.source
    property alias color: rec.color
    width: 30
    height: 30
    visible: true
    Rectangle{
        id:rec
        width: 30
        height: 30
        color: "#bdbdbd"
        opacity: 0.5
        visible:false
    }
    Image{
        anchors.centerIn: parent
        id:image
        source: "qrc:/image/add.png"
    }
}
