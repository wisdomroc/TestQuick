import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls 1.0 as QC10
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

    MyToggleButton {
        id: myToggleButton
        anchors.right: img.left
        anchors.top: parent.top
    }


    ListView {
      visible: true
      id: recordView
      width: parent.width
      height: parent.height
      model: readerModel
      delegate:Rectangle{
          width: 200
          height: 40
          RowLayout{
              spacing: 10
              Label {
                  text: id
              }
              Label {
                  text: password
              }
              Label {
                  text: record
              }
          }
          Component.onCompleted: {
            console.log(readerModel)
          }
      }
    }





    Button {
        id: button
        anchors.right: img.left
        anchors.top: r.bottom
        text: "Test Button"
        onClicked: {
            console.log("button clicked ...")
            myToggleButton.grabToImage(function(result) {
                result.saveToFile("D:/something.png");
            })
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: { button.onClicked();  }
    }



    Image {
        id: img
        visible: false
        width: 500
        height: 347
        source: "images/feather.jpg"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.leftMargin: 0
    }

    Image {
        visible: false
        id: invisibleImg
        source: "file:///D:/something.png"
    }

    ShaderEffect {
        id: r
        height: myToggleButton.height
        width: myToggleButton.width
        anchors.top: myToggleButton.bottom
        anchors.right: myToggleButton.right

        property variant source: invisibleImg
        property size sourceSize: Qt.size(0.5 / myToggleButton.width, 0.5 / myToggleButton.height)


        fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform lowp sampler2D source;
                uniform lowp vec2 sourceSize;
                uniform lowp float qt_Opacity;
                void main() {
                    lowp vec2 tc = qt_TexCoord0 * vec2(1, -1) + vec2(0, 1);
                    lowp vec4 col = 0.25 * (texture2D(source, tc + sourceSize)
                                            + texture2D(source, tc- sourceSize)
                                            + texture2D(source, tc + sourceSize * vec2(1, -1))
                                            + texture2D(source, tc + sourceSize * vec2(-1, 1))
                                           );
                    gl_FragColor = col * qt_Opacity * (1.0 - qt_TexCoord0.y) * 0.5;
                }"
    }
}

