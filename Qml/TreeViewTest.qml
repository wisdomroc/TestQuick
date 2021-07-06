import QtQuick 2.0

Item {
   width: 600
   height: 600

   //Model
   ListModel {
      id: objModel
      Component.onCompleted: {
          objModel.append({"name":"A1","level":0,"subNode":[]})
          objModel.append({"name":"A2","level":0,"subNode":[]})
          objModel.append({"name":"A3","level":0,"subNode":[]})
          objModel.get(1).subNode.append({"name":"B1","level":1,"subNode":[]})
          objModel.get(1).subNode.append({"name":"B2","level":1,"subNode":[]})
          objModel.get(1).subNode.get(0).subNode.append({"name":"C3","level":2,"subNode":[]})
      }
   }

   //Delegate
   Component {
      id: objRecursiveDelegate
      Column {
          Row {
               //indent
               Item {
                  height: 1
                  width: model.level * 20
               }

               Text {
                   text:model.name
               }
            }

         Repeater {
            model: subNode
            delegate: objRecursiveDelegate
         }
      }
   }

   //View
  ListView{
       anchors.fill: parent
       model:objModel
       delegate: objRecursiveDelegate
   }
}
