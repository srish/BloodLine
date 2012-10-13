import QtQuick 1.0

Rectangle {
    id: menuList
    width: 400
    height: 600
    color: "white"

    property alias title: currentTab.text
    property ItemStack itemStack;

    Rectangle {
        id: upperTab
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width
        height: 60
        color: "#800909"

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: upperTab.verticalCenter
            height: parent.height * 0.8

            Rectangle {
                id: highlightButton
                radius: 4
                width: backButton.width + 5
                height: backButton.height + 5
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }

            Image {
                id: backButton
                source: "qrc:///Images/back.png"
                height: 50
                width: 50
                anchors.verticalCenter: parent.verticalCenter
                smooth: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        highlightButton.visible = true
                        highlightButton.color = "lightsteelblue"
                        menuList.backButtonRequested()

                    }
                }
            }
        }


        Text {
            id: currentTab
            text:  "Profile"
            font.pixelSize: 16
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
        }

        Image {
            source: "http://graph.facebook.com/" + authorizer.facebookUserName + "/picture"
            smooth: true
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            height: parent.height
            width: parent.width * 0.2

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
    }

    ToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: ((parent.height/4) > 65)? 65 : parent.height/4
        state: "Profile"
        currentStateTitle: "Profile"
        onCurrentStateTitleChanged: {
            currentTab.text = toolBar.currentStateTitle
        }

        onStateChanged: {
            if(state == "Profile")
            {
                pageListView.currentIndex = 0;
                itemStack = profileTab
                //switchIcon()
            }
            else if(state == "Notifications")
            {
                pageListView.currentIndex = 1;
                itemStack = notificationsTab
                //switchIcon()
            }
            else if(state == "Credits")
            {
                pageListView.currentIndex = 2
                itemStack = creditsTab
                //homeIcon.visible = true
            }
            else if(state == "Settings")
            {
                pageListView.currentIndex = 3
                itemStack = settingsTab
                //homeIcon.visible = true
                //refreshIcon.visible = false
            }
        }
    }

    VisualItemModel {
        id: pageModel

        ProfileTab {
            id: profileTab
            width: pageListView.width
            height: pageListView.height
        }

        NotificationsTab {
            id: notificationsTab
            width: pageListView.width
            height: pageListView.height
        }

        CreditsTab {
            id: creditsTab
            width: pageListView.width
            height: pageListView.height
        }

        SettingsTab {
            id: settingsTab
            width: pageListView.width
            height: pageListView.height
        }
    }

    Rectangle {
        id: pageListViewContainer
        anchors.top: parent.top
        anchors.topMargin: upperTab.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: toolBar.height
        anchors.left: parent.left
        anchors.right: parent.right

        ListView {
            id: pageListView
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height
            anchors.bottomMargin: 4

            clip: true
            model: pageModel
            currentIndex: 0

            interactive: false
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            boundsBehavior: Flickable.StopAtBounds
            flickDeceleration: 5000
            highlightFollowsCurrentItem: true
            highlightMoveDuration:240
            highlightRangeMode: ListView.StrictlyEnforceRange
        }
    }

    function backButtonRequested()
    {
        if(pageListView.currentIndex == 0)
            profileTab.pop()
        else if(pageListView.currentIndex == 1)
            notificationsTab.pop()
        else if(pageListView.currentIndex == 2)
            creditsTab.pop()
        else if(pageListView.currentIndex == 3)
            settingsTab.pop()
        backButtonTimer.start()
    }

    Timer {
        id: backButtonTimer
        interval: 500
        onTriggered: {
            backButtonTimer.stop();
            highlightButton.visible = false
        }
    }
}
