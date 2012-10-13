// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0

Rectangle {
    width: 100
    height: 20
    border.color: "gray"
    border.width: 1
    radius: 5

    property alias text: inputBox.text
    property alias echoMode: inputBox.echoMode

    TextInput {
        id: inputBox
        anchors.fill: parent
        anchors.margins: parent.radius
        font.pixelSize: 9
    }
}
