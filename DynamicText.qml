﻿import QtQuick 2.0

Text {
      id: textElement
      width: 200
      height: 200
      text: "Default text"
      property string dynamicText: "Dynamic text"
      onTextChanged: console.log(text)
  }
