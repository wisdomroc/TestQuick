
import QtQuick 2.0

Rectangle {
    property string btnText: "click"//文本
    id: par
    border.width: mouse.containsMouse? 2 : 0.5//按钮边框
    border.color: mouse.containsMouse?"lightblue":"lightgray"

    height: 30
    width: 70
    color: "transparent"
    clip: true
    radius: 4
    Text {//按钮文字
        id: btnText
        text: qsTr("设置")
        anchors.centerIn: parent
        font.pointSize: 12
        font.family:"微软雅黑"
        color: "lightgray"
    }

    MouseArea {//数据区域
        id:mouse
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {//点击
            child.startx=mouse.x//鼠标点击点作为圆心
            child.starty=mouse.y
            showAni.from=5//动态的起始大小
            showAni.to=carculate(mouse.x,mouse.y)*2//计算一下圆心与最远角的距离
            showAni.start()//启用动画
        }
        onReleased: {
            child.visible=false//隐藏动态显示对象
        }
    }
    Rectangle{
        property int startx:0
        property int starty: 0
        id:child
        opacity:0.5
        color: "lightblue"
        x:startx-height/2//根据圆心计算出该显示对象的起始坐标
        y:starty-height/2
        width: height//宽度等于高度
        radius:height/2//显示对象为一个圆
        visible: false

        NumberAnimation on height {//高度控制的动画
            id:showAni
            running: false
            duration: 1000//动画周期
            easing.type:Easing.Bezier//贝塞尔曲线
            easing.bezierCurve: [ 0.40, 0.05, 0.22, 0.97, 1, 1 ]
            onStarted: {
                child.visible = true//动画开始前显示该对象
            }
        }



    }
    function carculate(x,y)//圆心距离最远角的距离计算函数（根据点击点的不同位置确认最远点，分四种情况）
    {
        var i=0
        if(x<par.width/2)
        {
            if(y<par.height/2)
            {
                i= Math.sqrt(Math.pow(par.width-x,2)+Math.pow(par.height-y,2))
              // console.log("00000:",i)
                return i
            }
            else
            {
                i= Math.sqrt(Math.pow(par.width-x,2)+Math.pow(y,2))
               // console.log("22222:",i)
                return i
            }
        }
        else
        {
            if(y<par.height/2)
            {
                i=Math.sqrt(Math.pow(x,2)+Math.pow(par.height-y,2))
                console.log("111111:",i)
                return i
            }
            else
            {
                i=Math.sqrt(Math.pow(x,2)+Math.pow(y,2))
              //  console.log("33333:",i)
                return i
            }
        }
    }
}
