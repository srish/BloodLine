// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import QtWebKit 1.0

Rectangle {
    width: 400
    height: 600

    color: "white"

    WebView {
        id: webView
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        width: parent.width
        height: parent.height * 0.9

        preferredWidth: width

        property bool loadFinshes: false;
        signal loadStarted(url address)

        focus: true

        onUrlChanged: {
            loadStarted(url)

            if(url.toString().indexOf("http://www.facebook.com/connect/login_success.html") == 0)
            {
                messageBox.visible = true
                timer.start()

                authorizer.extractPostId(url)
                foundation.setFile(authorizer.postId)
                authorizer.getNotificationMessage("https://graph.facebook.com/" + authorizer.postId + "?access_token=" + authorizer.accessToken)

                url = "https://www.facebook.com/dialog/feed?app_id=462789277089305&link=https://developers.facebook.com/docs/reference/dialogs/&picture=http://fbrell.com/f8.jpg&name=BloodLine&caption=Be+a+Blood+Donor+and+make+a+difference.&description=Social%20Awareness%20Application.&redirect_uri=http://www.facebook.com/connect/login_success.html&response_type=token&scope=publish_stream,read_stream&display=touch"
            }
        }

        onLoadStarted: {
            webView.loadFinshes = false
        }

        onLoadFinished:  {
            webView.loadFinshes = true
        }

        onHeightChanged: {
            console.log("height changed "+height)
        }

        onWidthChanged: {
            console.log("width changed "+width)
        }

        url: "https://www.facebook.com/dialog/feed?app_id=462789277089305&link=https://developers.facebook.com/docs/reference/dialogs/&picture=http://fbrell.com/f8.jpg&name=BloodLine&caption=Be+a+Blood+Donor+and+make+a+difference.&description=Social%20Awareness%20Application.&message=hello&redirect_uri=http://www.facebook.com/connect/login_success.html&response_type=token&scope=publish_stream,read_stream&display=touch"
    }

    Rectangle {
        id: messageBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
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
            text: "A new story is created!"
            color: "white"
            font.pixelSize: 14
        }
    }

    HourGlass {
        id: hourGlass
        anchors.centerIn: parent
        width: 50
        height: 50
        visible: webView.loadFinshes == false
    }

    Timer {
        id: timer
        interval: 5000
        onTriggered: {
            messageBox.visible = false
            timer.stop()
        }
    }
}
