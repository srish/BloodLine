import QtQuick 1.0

Rectangle {
    width: parent.width
    height: parent.height

    color: "white"

    signal showPushNotificationView()

    ListModel {
        id: listModel
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        height: parent.height * 0.7
        width: parent.width
        clip: true
        model: listModel

        delegate : Rectangle{
            id: rectangleElement
            width: parent.width
            height: 60
            border.color: "white"
            border.width: 1

            signal buttonClicked()

            gradient: Gradient {
                GradientStop { position: 0; color: "#E3E8E4"; }
                GradientStop { position: 0.35; color: "#E0E0E1"; }
                GradientStop { position: 1; color: "#D5D7D5"; }
            }


            Image {
                id: name
                source: image
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 60
                height: parent.height
                smooth: true
            }

            Text {
                id: ad
                text: story
                anchors.left: name.right
                anchors.leftMargin: 20
                wrapMode: Text.WordWrap
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }

        }
    }


    Button {
        buttonText: "Push Notification"
        fontSize: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.7
        height: 30
        radius: 5
        onButtonClicked:showPushNotificationView()
    }

    Component.onCompleted: {
//        foundation.parseNotificationList()
//        console.log("parse notification count" + foundation.notificationCount());
//        for(var i = 0; i<=10; i++)
//        {
//            var jsonString = foundation.notificationMessage(i);
//            authorizer.parseNotificationsMessage(jsonString)
//            listModel.append({story: "Every 2 seconds someone needs blood",
//                                 image: "qrc:///Images/blood_icon.png"
//                             })
//        listModel.append({story: "Your blood group ie. A+ is in need in your blood zone",
//                             image: "qrc:///Images/blood_icon.png"
//                         })

//        }
    }
}
