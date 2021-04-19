import QtQuick 2.12
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: amazingText
    width: myText.implicitWidth
    height: myText.implicitHeight
    color: "transparent"

    Text {
        id:myText
        anchors.centerIn: parent
        text: "Hello world!"
        font.bold: true
        font.pixelSize: 64
        font.family: "微软雅黑"
        color: "#ffffffff"
        opacity: 1;
        visible: false;
    }

    LinearGradient {
        id: gradientPanel
        source: myText
        anchors.fill: myText
        start: Qt.point(0, 0)
        end: Qt.point(0, myText.height)
        gradient: Gradient {
            GradientStop{id: myGradientStart; position: 0; color: "#FFFFFFFF"}
            GradientStop{id: myGradientEnd; position: 1; color: "#FFFFFFFF"}
        }
    }

    ParticleSystem {
        id: myParticleSystem
    }

    ImageParticle {
        system: myParticleSystem

        source: "qrc:///particleresources/glowdot.png"
        color: "#30333333"
    }
    Emitter {
        id: myEmitter
        system: myParticleSystem
        enabled: false

        width: myText.width
        height: myText.height / 2
        anchors.left: myText.left
        y: amazingText.height / 2 - 12

        lifeSpan: 1000
        lifeSpanVariation: 500
        emitRate: 4000
        size: 16
        sizeVariation: 8
        endSize: 8

        velocity: PointDirection {
            y: -32
            x: 32
            xVariation: 16
            yVariation: 16
        }
    }

    Turbulence {
        id: myTurb
        enabled: true
        anchors.fill: parent
        strength: 48
        system: myParticleSystem
    }

    SequentialAnimation{
        id: myAnimation

        ParallelAnimation {
            PropertyAnimation  {
                target: myEmitter
                properties: "emitRate"
                from: 0
                to: 4000
                duration: 1000
            }

            PropertyAnimation  {
                target: myText
                properties: "opacity"
                to: 0.7
                duration: 1000
            }

            PropertyAnimation {
                target: myGradientEnd
                properties: "color"
                from: "#ffffffff"
                to: "#00ffffff"
                duration: 1000
            }

            PropertyAnimation {
                target: myGradientStart
                properties: "color"
                from: "#ffffffff"
                to: "#77ffffff"
                duration: 1000
            }
        }

        ParallelAnimation {
            //数值动画
            PropertyAnimation  {
                target: myText
                properties: "opacity"
                to: 0.0
                duration: 1000
            }

            PropertyAnimation {
                target: myGradientStart
                properties: "color"
                to: "#001f1f1f"
                duration: 1000
            }

            PropertyAnimation {
                target: myEmitter
                properties: "emitRate"
                to: 0
                duration: 1000
            }
        }

        onStopped: myEmitter.enabled = false
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            myEmitter.enabled = true
            myText.opacity = 1
            myEmitter.emitRate = 4000
            myAnimation.restart()
        }
    }
}
