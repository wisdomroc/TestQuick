import QtQuick 2.0
import QtQuick.Controls 1.4 as QC14

Item {
    anchors.fill: parent


    QC14.TreeView {
        anchors.fill: parent
        model: treeModel

        QC14.TableViewColumn {
            title: "Name"
            role: "name"
            width: 150
        }
        QC14.TableViewColumn {
            title: "YuWen"
            role: "yuwen"
            width: 200
        }
        QC14.TableViewColumn {
            title: "ShuXue"
            role: "shuxue"
            width: 200
        }
        QC14.TableViewColumn {
            title: "WaiYu"
            role: "waiyu"
            width: 200
        }
        QC14.TableViewColumn {
            title: "Score"
            role: "zongfen"
            width: 150
        }
        QC14.TableViewColumn {
            title: "AverageScore"
            role: "pingjunfen"
            width: 200
        }
        QC14.TableViewColumn {
            title: "HeGe"
            role: "hege"
            width: 200
        }
        QC14.TableViewColumn {
            title: "YouXiu"
            role: "youxiu"
            width: 200
        }
        itemDelegate: Item {
            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: "red"
                elide: styleData.elideMode
                text: styleData.value
            }
        }
        property bool isCollapse: true
        onClicked: {
            console.log("onClicked:", index)
            console.log("isExpanded:",isExpanded(index))
            if (isCollapse)
            {
                console.log("expand")
                emit: view.expand(index);
                isCollapse = false;
            }
            else
            {
                console.log("collapse")
                emit: view.collapse(index);
                isCollapse = true;
            }
            /*if (isExpanded(index))
                    {
                        collapse(index);
                    }
                    else
                    {
                        expand(index);
                    }*/
        }
    }
}
