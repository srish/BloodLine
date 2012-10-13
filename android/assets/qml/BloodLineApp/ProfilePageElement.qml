// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0

Rectangle{
    id: rectangleElement
    width: parent.width
    height: 60
    border.color: "white"
    border.width: 1

    property string infoTabName: textElement.text
    signal buttonClicked()

    gradient: Gradient {
        GradientStop { position: 0; color: "#E3E8E4"; }
        GradientStop { position: 0.35; color: "#E0E0E1"; }
        GradientStop { position: 1; color: "#D5D7D5"; }
    }

    Text {
        id: textElement
        text: rectangleElement.infoTabName
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.pixelSize: 14
        color: "black"
    }


    Image {
        id: arrowImage
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:///Images/arrow.png"
        smooth: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.buttonClicked()
    }
}
