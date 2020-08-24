
import QtQuick 2.6
import QtQuick.Particles 2.0

/*
 * 作者: yubo
 * 功能: 粒子背景发射器
 * 描述: 三维粒子发射角度，中线点坐标需要按需求设置，粒子数量，速度，变化量，颜色可控制
 * 日期: 2018-07-12
 */
ParticleSystem {
    id: sys
        // 发射器状态
        property bool emitterStatus: true
        // 发射器粒子图片
        property string particleColor: "red"
        // 发射器粒子颜色
        property string particleImage: "qrc:///Image/star.png"
        // 发射器形状背景图片
        property string maskBackground: "qrc:///Image/yuan.png"
        // 发射器角度
        property real senderAngle: 90
        running: emitterStatus
        // 背景图片ID
        property var backgroundId: background

        ImageParticle {
            id: part
            visible: emitterStatus
            system: sys
            groups: "A"
            color: particleColor

            source: particleImage
            rotation: 180
            rotationVariation: 180
            rotationVelocity: 15
            rotationVelocityVariation: 15
            entryEffect: ImageParticle.Scale
            autoRotation: true
        }

        Emitter {
            id: emitter
            system: sys
            width: 200
            height: 200
            emitRate: 100
            lifeSpan: 9000
            lifeSpanVariation: 1000
            size: 30
            sizeVariation: 4
            endSize: 60
            shape: MaskShape { source: maskBackground }
            group: "A"
            velocity: PointDirection {
                y: 4
                yVariation: 4
            }
        }

        Rectangle {
            id: background
            anchors.fill: parent
            width: 200
            height: 200
            border.color: "red"
            border.width: 2
        }
    }
