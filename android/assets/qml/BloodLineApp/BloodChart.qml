import QtQuick 1.0

Rectangle {
    width: 100
    height: 62

    color: "white"

    property string bloodReceivers;

    Image {
        id:  bloodChart
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        width: parent.width * 0.8
        source: "qrc:///Images/CompatibilityChart.png"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
        id: row
        width: parent.width
        height: 30
        anchors.top: bloodChart.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 5

        Text {
            text: "Enter your blood group :"
            color: "black"
            font.pixelSize: 12
            width: parent.width * 0.5
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }

        InputField {
            id: zone
            width: parent.width * 0.3
            height: parent.height
        }

        Button {
            buttonText: "Go!"
            height: parent.height
            width: parent.width * 0.1
            radius : 2
            onButtonClicked: {
                bloodReceivers = foundation.possibleReceiverGroups(zone.text)
                messageBox.visible = true
                timer.start()
            }

        }
    }

    Rectangle {
        id: messageBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: row.bottom
        anchors.topMargin: 5
        radius: 2
        color: "black"
        border.width: 2
        border.color: "white"
        height: 25
        width: parent.width * 0.8
        visible: false

        Text {
            anchors.verticalCenter: messageBox.verticalCenter
            anchors.horizontalCenter: messageBox.horizontalCenter
            text: bloodReceivers
            color: "white"
            font.pixelSize: 14
        }
    }

    Timer {
        id: timer
        interval: 5000
        onTriggered: {
            messageBox.visible = false
            timer.stop()
        }
    }


    Component.onCompleted: menuList.title = "Blood Chart"
    Component.onDestruction: menuList.title = "Profile"
}
