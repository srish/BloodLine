import QtQuick 1.0

Rectangle {
    id: button
    width: textLabel.implicitWidth*1.4
    height: 45
    radius: 6

    property alias buttonText: textLabel.text
    property alias fontSize: textLabel.font.pixelSize
    property alias fontColor: textLabel.color
    property color buttonBorderColor: "#969696"
    property color buttonTopColor: "#F0F0F0"
    property color buttonBottomColor: "#D3D3D3"
    property string buttonType: "standard"
    signal buttonClicked()

    gradient: Gradient {
        GradientStop { position: 0.0; color: mouseArea.pressed ? button.buttonBottomColor : button.buttonTopColor }
        GradientStop { position: 1.0; color: mouseArea.pressed ? button.buttonTopColor : button.buttonBottomColor }
    }

    onButtonTypeChanged: {
        if(buttonType == "green") {
            buttonTopColor = "#43CB60"
            buttonBottomColor = "#36AE3C"
            buttonBorderColor = "#216B29"
            fontColor = "#ffffff"
        } else if(buttonType == "red") {
            buttonTopColor = "#990000"
            buttonBottomColor = "#990000"
            buttonBorderColor = "lightgray"
            fontColor = "#ffffff"
        } else if(buttonType == "lightgreen") {
            buttonTopColor = "#43CB60"
            buttonBottomColor = "#36AE3C"
            buttonBorderColor = "#216B29"
            fontColor = "#ffffff"
            opacity = 0.5
            enabled = false
        } else if(buttonType == "white") {
            buttonTopColor = "#ffffff"
            buttonBottomColor = "#dedede"
            fontColor = "#2181B8"
            border.color = "#c7c7c7"
            radius = 3
            border.width = 1
        } else if(buttonType == "blackAndWhite")
        {
            buttonTopColor = "#ffffff"
            buttonBottomColor = "#f0f0f0"
            fontColor = "black"
            border.color = "black"
            radius = 1
            border.width = 1

        } else if(buttonType == "whiteAndBlack")
        {
            buttonTopColor = "black"
            buttonBottomColor = "black"
            fontColor = "white"
            fontSize = 16
            border.color = "white"
            border.width = 2
            radius =  2
       }
        else {
            buttonTopColor = "#F0F0F0"
            buttonBottomColor = "#D3D3D3"
            buttonBorderColor = "#969696"
            fontColor = "#666666"
        }
    }

    border.color: button.buttonBorderColor
    border.width: 1

    Item {
        anchors.fill: parent
        anchors.leftMargin: mouseArea.pressed ? 2 : 0
        anchors.topMargin: mouseArea.pressed ? 2 : 0
        anchors.rightMargin: mouseArea.pressed ? -2 : 0
        anchors.bottomMargin: mouseArea.pressed ? -2 : 0

        Text {
            id: textLabel
            anchors.centerIn: parent
            font.pixelSize: 16
            color: "#666666"
            text: "button"
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.buttonClicked()
    }
}
