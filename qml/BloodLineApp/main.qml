// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0

Rectangle {
    id: splashScreen
    width: 400
    height: 600

    signal loadStarted(url address)

    Image {
        id: bloodLineLogo
        source: "qrc:///Images/blood_icon.png"
        height: parent.height / 3
        width: parent.width / 4
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
    }

    Image {
        id: header
        source: "qrc:///Images/Bloodline.png"
        height: 40
        width: 250
        anchors.top: bloodLineLogo.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
    }

    Image {
        source: "qrc:///Images/FB_Login.png"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 4
        anchors.horizontalCenter: parent.horizontalCenter
        width: 250
        height: 50
        smooth: true

        MouseArea {
            anchors.fill: parent
            onClicked: authDialog.visible = true
        }
    }

    FacebookAuthenticationDialog {
        id: authDialog
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height
        onLoadStarted: splashScreen.loadStarted(address)

        HourGlass {
            id: hourGlass
            width: 50
            height: 50
            anchors.centerIn: parent
            visible: authDialog.loadFinshes == false
        }
    }

    states: [
        State {
            name: "unauthorized"; when: authorizer.accessToken.length === 0
            PropertyChanges {
                target: authDialog
                opacity: 1
            }
        }
    ]

    Menu {
        id: mainWindow
        visible: authorizer.accessToken.length > 0
        width: parent.width
        height: parent.height
        anchors.fill: parent
    }
}
