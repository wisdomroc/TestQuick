import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: root
    visible: true
    property string dynamicText: "Root text"

    Component.onCompleted: {
        var c = Qt.createComponent("DynamicText.qml")

        var obj1 = c.createObject(root, { 'text': Qt.binding(function() { return dynamicText + ' extra text' }) , 'y': 100 })
        root.dynamicText = "Modified root text"

        var obj2 = c.createObject(root, { 'text': Qt.binding(function() { return this.dynamicText + ' extra text' }) , 'y': 300 })
        obj2.dynamicText = "Modified dynamic text"
    }



    MyPartical {

    }

  }
