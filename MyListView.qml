import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0

ListView{
        id:thelist
        property bool isClicked: false //初始化没有点击事件
        width: 300
        height: 500
        clip:true
        interactive: !isClicked
        focus: true
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {id:scrollBar;active: true;}
        Keys.onUpPressed: scrollBar.decrease()
        Keys.onDownPressed: scrollBar.increase()
        move:Transition {
            NumberAnimation{
                properties: "x,y";
                duration: 300
            }
        }
        spacing: 4
        cacheBuffer: 50

        model: ListModel{
            id:sstpModel;
            ListElement{
                air_iden:"111111"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高 ALT-高度
                status:"TAI"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//departureTime 起飞时间 离港时间
                arrivalTime:"1423"// arrivalTime到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//takeOffRunway 起飞跑道
                landingRunway:"xx"//landingRunway 降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
            ListElement{
                air_iden:"222222"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高
                status:"HANDOVER"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//起飞时间 离港时间
                arrivalTime:"1423"//到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//起飞跑道
                landingRunway:"xx"//降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
            ListElement{
                air_iden:"333333"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高
                status:"CLR"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//起飞时间 离港时间
                arrivalTime:"1423"//到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//起飞跑道
                landingRunway:"xx"//降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
            ListElement{
                air_iden:"444444"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高
                status:"OFF"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//起飞时间 离港时间
                arrivalTime:"1423"//到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//起飞跑道
                landingRunway:"xx"//降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
            ListElement{
                air_iden:"555555"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高
                status:"DESCENT"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//起飞时间 离港时间
                arrivalTime:"1423"//到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//起飞跑道
                landingRunway:"xx"//降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
            ListElement{
                air_iden:"666666"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高
                status:"DISENGAGE"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//起飞时间 离港时间
                arrivalTime:"1423"//到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//起飞跑道
                landingRunway:"xx"//降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
            ListElement{
                air_iden:"777777"//呼号 航班号
                type:"A319"//机型
                el:"07056"//机场标高
                status:"TAI"// 管制按钮  HANDOVER-移交 CLR-放行 TAI-滑行  OFF-起飞 DESCENT-降落 DISENGAGE-脱离
                etd:"1215"//预计离港时间
                eta:"1413"//预计到达时间
                departureTime:"1215"//起飞时间 离港时间
                arrivalTime:"1423"//到达时间 到港时间
                ades:"ZSPD"//到达机场 目的地
                takeOffRunway:"xx"//起飞跑道
                landingRunway:"xx"//降落跑道
                procedure:"xxx"//进离场程序

                //tas:"K0860"//巡航速度 860km/h
                //waypoint1:"TEBUN";//航路点
                //assr:"6255"//应答机编码
                //cvsm:"S0820"//对应高度层 82km
            }
        }

        delegate:Rectangle{
            id:sstpDelegate
            property int fromIndex:0
            property int toIndex:0
            width: parent.width
            height: 80
            MouseArea {
                id:mousearea
                anchors.fill: parent
                onClicked: {
                    thelist.currentIndex = index
                }
                onPressed: {
                    thelist.currentIndex = index
                    sstpDelegate.fromIndex = index
                    thelist.isClicked = true //每项按钮点击就true

                }
                onReleased: {
                    thelist.isClicked = false //每项按钮点击就false
                    console.log("fromIndex:",sstpDelegate.fromIndex,"toIndex:",sstpDelegate.toIndex)
                }
                onPositionChanged: {
                    var lastIndex = thelist.indexAt(mousearea.mouseX + sstpDelegate.x,mousearea.mouseY + sstpDelegate.y);
                    if ((lastIndex < 0) || (lastIndex > sstpModel.rowCount()))
                        return;
                    if (index !== lastIndex){
                        sstpModel.move(index, lastIndex, 1);
                        console.log("******index: " + index +", lastIndex: " + lastIndex)
                    }
                    sstpDelegate.toIndex = lastIndex;
                }
            }
            Row{
                Rectangle{
                    id:curRect
                    width: 5
                    height: sstpDelegate.height
                    color: index===thelist.currentIndex ? "red" : "blue"//选中颜色设置
                }
                Rectangle{//info
                    id:infoRect
                    width: sstpDelegate.width - controlRect.width - 5
                    height: sstpDelegate.height
                    RowLayout{
                        spacing: 6
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        ColumnLayout{
                            spacing: 6
                            Text{//航班呼号
                                text: air_iden
                                color: "red"
                            }
                            TextInput{//预计起飞时间
                                text: etd
                                color: "green"
                                font.pointSize: 12
                                onEditingFinished: {

                                }
                            }
                            TextInput{//起飞时间
                                text: departureTime
                                color: "blue"
                                font.pointSize: 12
                                onEditingFinished: {

                                }
                            }
                        }
                        ColumnLayout{
                            spacing: 6
                            Text{//飞行机型
                                text: type
                            }
                            TextInput{//预计到达时间
                                text: eta
                                color: "lightGray"
                                font.pointSize: 12
                                onEditingFinished: {

                                }
                            }
                            TextInput{//到达时间
                                text: arrivalTime
                                color: "gray"
                                font.pointSize: 12
                                onEditingFinished: {

                                }
                            }
                        }
                        ColumnLayout{
                            spacing: 6
                            Text{//机场标高
                                text: el
                                color: "lightGreen"
                            }
                            TextInput{//目的机场
                                text: ades
                                color: "green"
                                font.pointSize: 12
                                onEditingFinished: {

                                }
                            }
                        }
                        ColumnLayout{
                            spacing: 6
                            TextInput{//起飞跑道
                                text: takeOffRunway
                                color: "lightBlue"
                                font.pointSize: 12
                            }
                            TextInput{//进离场程序
                                text: procedure
                                color: "blue"
                                font.pointSize: 12
                                onEditingFinished: {

                                }
                            }
                        }
                        TextInput{//降落跑道
                            Layout.alignment: Qt.AlignTop
                            text: takeOffRunway
                            color: "steelBlue"
                            font.pointSize: 12
                        }
                    }
                }

                Rectangle{
                    id:controlRect
                    width: 100
                    height: sstpDelegate.height
                    ColumnLayout{
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        Button{
                            implicitWidth: 80
                            implicitHeight: 30
                            text: qsTr("TestBtn")
                            MouseArea{
                                anchors.fill: parent

                                onClicked: {
                                    thelist.interactive = false
                                    sstpModel.move(0, 1, 1)
                                }
                            }
                        }
                        Text{
                            width: 80
                            height: 30
                            Layout.alignment: Qt.AlignHCenter
                            font.family: "FontAwesome"
                            text: '\uf014'
                            MouseArea{
                                anchors.fill: parent
                                onClicked: an_del.open()
                            }
                        }
                    }
                }
            }
        }

        Dialog{
            id:an_del;
            x:100;
            y:100;
            implicitWidth: 400
            implicitHeight: 260

            signal clicked
            title: "Title";
            standardButtons: Dialog.Ok | Dialog.Cancel;
            MouseArea {
                anchors.fill: parent
                onClicked: clicked()
            }
        }
        Connections{
            target: an_del;
            onClicked:{
                //anAirModel.remove(thelist.currentIndex)
                sstpModel.remove(thelist.currentIndex)
                an_del.close()
            }
        }
    }
