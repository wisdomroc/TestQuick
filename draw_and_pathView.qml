import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0 as QC2
import Qt.labs.platform 1.0

Window {
    visible: true
    width: 800
    height: 800

    Row {
        id: button_row
        Button {
            id: clear
            text: "Clear"
            onClicked: {
                canvas
            }
        }
        Button {
            id: save
            text: "Save"
            onClicked: {
                saveDlg.open()
                var path = fileDialog.folder
                canvas.save(path)
            }
        }
    }

    FileDialog {
        id: saveDlg
        visible: false
        title: "Save Image File"
        fileMode: FileDialog.SaveFile
        nameFilters: ["Image files (*.jpg)", "Image files (*.png)"]
        onAccepted: {
            console.log(saveDlg.file)
            var ok = canvas.save(saveDlg.file)
            console.log("result: " + ok)
        }
    }

    Rectangle {
        id: canvas_frame
        border.color: "blue"
        width: parent.width;
        height: 200
        anchors.top: button_row.bottom

        Canvas {
            id: canvas
            anchors.fill: parent
            property int lastX: 0
            property int lastY: 0

            onPaint: {
                var ctx = getContext("2d")
                ctx.lineWidth = 2
                ctx.strokeStyle = "red"
                ctx.beginPath()
                ctx.moveTo(lastX, lastY)
                lastX = area.mouseX
                lastY = area.mouseY
                ctx.lineTo(lastX, lastY)
                ctx.stroke()
            }

            MouseArea {
                id: area
                anchors.fill: parent
                onPressed: {
                    canvas.lastX = mouseX
                    canvas.lastY = mouseY
                }
                onPositionChanged: {
                    canvas.requestPaint()
                }
            }
        }
    }

    Rectangle {
        id: pathViewRectangle
        anchors.top: canvas_frame.bottom
        width: 240; height: 200
        border.color: "cyan"


        Component {
            id: pathViewDelegate
            QC2.Button {
                width: 100
                height: 100
                text: model.name
                highlighted: true
                onClicked: pathView.currentIndex = index
                scale: PathView.iconScale
            }
        }

        PathView {
            id: pathView
            anchors.fill: parent
            model: ContactModel {}
            delegate: pathViewDelegate

            path: Path {
                startX: 120; startY: 100
                PathAttribute { name: "iconScale"; value: 1.0 }
                PathAttribute { name: "iconOpacity"; value: 1.0 }
                PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
                PathAttribute { name: "iconScale"; value: 0.3 }
                PathAttribute { name: "iconOpacity"; value: 0.5 }
                PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
            }
        }
    }
}


