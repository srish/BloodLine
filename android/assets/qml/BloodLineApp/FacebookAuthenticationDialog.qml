// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import QtWebKit 1.0

WebView {
    id: webView
    anchors.fill: parent

    preferredWidth: width
    preferredHeight: height

    property bool loadFinshes: false;
    signal loadStarted(url address)

    focus: true

    onUrlChanged: {
        loadStarted(url)

        if(url.toString().indexOf("http://www.facebook.com/connect/login_success.html") == 0)
        {
            authorizer.extractAccessToken(url)
            authorizer.getFacebookData();
            authorizer.getUserInfo();
            url = ""
        }
    }

    onLoadStarted: {
        webView.loadFinshes = false
    }

    onLoadFinished:  {
        webView.loadFinshes = true
    }

    url : "http://www.facebook.com/dialog/oauth?client_id=462789277089305&redirect_uri=http://www.facebook.com/connect/login_success.html&response_type=token&scope=publish_stream,user_birthday,user_location,email,user_relationship_details,read_stream&display=touch"
}
