import QtQuick 1.0

Rectangle {
    id: itemStack
 //   color: "#dadcd1";

    signal itemPoped()
    signal itemPushed()

    ListModel {
        id: itemStackModel
    }

    ListView {
        id: itemStackView
        anchors.fill: parent
        clip: true

        model: itemStackModel
        delegate: Rectangle {
            id: stackViewItem
            width: itemStackView.width
            height: itemStackView.height
            //color: "#dadcd1";

            Component.onCompleted: {
                item.parent = stackViewItem;
                item.anchors.fill = stackViewItem
                item.visible = true
            }
            Component.onDestruction: {
                if(itemStack.mode == "push") {
                    item.parent = itemStack
                    item.visible = false
                }
            }
        }

        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        interactive: false
        flickDeceleration: 5000
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 240
        highlightRangeMode: ListView.StrictlyEnforceRange

        onCurrentIndexChanged: {
            if(currentIndex >= 1)
                itemStack.backButtonRequired = true
            else
                itemStack.backButtonRequired = false
        }
    }

    property string mode: "none"
    property bool backButtonRequired: false

    function push(itemObject) {
        cleanupItemStackModel();

        itemStack.mode = "push"
        itemStackModel.append({"item": itemObject})
        itemStackView.currentIndex = itemStackModel.count-1
        itemPushed()
    }

    function pop() {
        if(!backButtonRequired)
            return;
        itemStack.mode = "pop"
        itemStackView.currentIndex = itemStackView.currentIndex-1
        itemPoped()
        postPopTimer.start();
    }

    function currentItem() {
        var currentIndex = itemStackView.currentIndex;
        return itemStackModel.get(currentIndex).item
    }

    Timer {
        id: postPopTimer
        interval: 500
        onTriggered: cleanupItemStackModel()
        running: false
    }

    function cleanupItemStackModel() {
        postPopTimer.stop();

        var currentIndex = itemStackView.currentIndex
        var count = itemStackModel.count
        if(currentIndex == count-1)
            return;

        for(var index=count-1; index>currentIndex; index--)
            itemStackModel.remove(index);
    }
}
