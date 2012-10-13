// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0

Rectangle {
    width: 400
    height: 600

    Image {
        source: "http://graph.facebook.com/" + authorizer.facebookUserName + "/picture"
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: 80
        height: 100
        smooth: true

        onStatusChanged: {
            if(status == Image.Loading)
                hourGlass.visible = true
            else if(status == Image.Ready)
                hourGlass.visible = false
        }

        HourGlass {
            id: hourGlass
            width: 30
            height: 30
            anchors.centerIn: parent
            visible: false
        }
    }

    Image {
        id: bloodlineIcon
        source: "qrc:///Images/bloodline2.png"
        width: 150
        height: 20
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 10
        smooth: true
    }

    Image {
        id: prayingHandsImage
        source: "qrc:///Images/pray.png"
        width: parent.width / 3
        height: parent.height / 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
        smooth: true
    }

    Text {
        id: welcomeText
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: prayingHandsImage.bottom
        anchors.topMargin: 30
        text: "Welcome "
        color: "#372A85"
        font.pixelSize: 35
        font.family: fontLoader.name
        font.bold: true
        visible: authorizer.facebookUserName.length > 0
    }

    Text {
        id: facebookUserName
        anchors.left: welcomeText.right
        anchors.leftMargin: 10
        anchors.top: prayingHandsImage.bottom
        anchors.topMargin: 30
        color: "#F60000"
        text: authorizer.facebookFirstName + ","
        font.pixelSize: 35
        font.family: fontLoader.name
        font.bold: true
        visible: authorizer.facebookUserName.length > 0
    }

    Text {
        id: thought
        width: parent.width * 0.9
        height: 50
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 4
        text: "We appreciate your concerns to this humble cause... Please complete your profile in order to help mankind."
        font.pixelSize: 20
        horizontalAlignment: Text.AlignJustify
        wrapMode: Text.WordWrap
        font.family: fontLoader.name
        font.bold: true
        visible: authorizer.facebookUserName.length > 0
    }

    Text {
        id: pray
        width: parent.width * 0.5
        height: 50
        text: "Click here..."
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        font.pixelSize: 30
        color: "#00AE00"
        horizontalAlignment: Text.AlignJustify
        wrapMode: Text.WordWrap
        font.family: fontLoader.name
        font.bold: true
        //visible: authorizer.facebookFirstName.length > 0

        MouseArea {
            anchors.fill: parent
            onClicked: menuLoader.source = "Menu.qml"
        }
    }

    FontLoader {
        id: fontLoader
        source: "qrc:///fonts/MLSJN.TTF"
    }

    HourGlass {
        id: hourGlassTwo
        anchors.centerIn: parent
        width: 50
        height: 50
        visible: authorizer.facebookUserName.length === 0
    }

    Loader {
        id: menuLoader
    }
}
