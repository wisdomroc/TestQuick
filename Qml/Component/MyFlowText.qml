import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0

Rectangle {
        id: root
        width: myText.implicitWidth
        height: myText.implicitHeight
        color: "#1f1f1f"

        Text {
            id:myText
            anchors.centerIn: parent
            text: "Hello world!"
            font.bold: true
            font.pixelSize: 120
            font.family: "微软雅黑"
            visible: false
        }

        LinearGradient {
            source: myText
            anchors.fill: myText
            start: Qt.point(0, 0)
            end: Qt.point(myText.width, 0)
            gradient: Gradient {
                GradientStop{id: myGradientStart; position: 0.0; color: "#FFFFFFFF"}
                GradientStop{id: myGradientEnd; position: 0.1; color: "#FFFFFFFF"}
            }
        }

        ParticleSystem {
            id: myParticleSystem
            running: false
        }

        Emitter {
            id: myEmitter
            system: myParticleSystem
            anchors.verticalCenter: parent.verticalCenter

            //发射器区域宽和高
            width: 240
            height: 180

            //发射频率每秒500个元素
            emitRate: 500
            //每个元素的生命周期是1000毫秒
            lifeSpan: 1000
            //每个元素的大小是16*16像素
            size: 16
            //元素可以在±8*8像素范围内随机变化
            sizeVariation: 8
            //元素发射速度设置，使用点方向模式
            velocity: PointDirection {
                //水平方式速度 150像素/秒
                x: 150
                //随着变量调整
                xVariation: 60
                yVariation: 20
            }
            //元素行进加速度设置，使用点方式模式
            acceleration: PointDirection {
                x: 12
                //随着变量调整
                xVariation: 6
                yVariation: 5
            }
        }

        ImageParticle {
            system: myParticleSystem
            //Qt自带粒子图，可以换成自定义图片
            source: "qrc:///particleresources/fuzzydot.png"
            //粒子图使用白色
            color: "white"
            //颜色随机系数
            colorVariation: 0.1
        }

        ParallelAnimation {
            id: myAnimation

            //数值动画
            NumberAnimation {
                //设定动画的目标
                target: myEmitter
                //设定改变的属性是x坐标
                properties: "x"
                //x移动到父窗口的边沿
                to: root.width
                //在1秒内完成移动
                duration: 1000
            }

            SequentialAnimation {
                PropertyAnimation {
                    target: myGradientStart
                    properties: "color"
                    to: "#00FFFFFF"
                    duration: 200
                }

                ParallelAnimation {
                    PropertyAnimation {
                        target: myGradientEnd
                        properties: "position"
                        to: "1.0"
                        duration: 1000
                    }

                    PropertyAnimation {
                        target: myGradientStart
                        properties: "position"
                        to: "0.9"
                        duration: 1000
                    }
                }

                PropertyAnimation {
                    target: myGradientEnd
                    properties: "color"
                    to: "#00FFFFFF"
                    duration: 200
                }
            }
        }

        MouseArea {
            anchors.fill: parent

            //鼠标点击测试
            onClicked: {
                //让myEmitter窗口复位，这样鼠标可重复点击
                if (myEmitter.x > 0)
                {
                    myAnimation.stop()
                    myEmitter.x = 0;

                    myGradientStart.position = 0.0
                    myGradientStart.color = "#FFFFFFFF"

                    myGradientEnd.position = 0.1
                    myGradientEnd.color = "#FFFFFFFF"
                }

                //激活粒子系统
                myParticleSystem.restart()
                //激活动画
                myAnimation.restart()
            }
        }
    }
