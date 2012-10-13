import QtQuick 1.0

ItemStack {
    id: notificationsTab

    Component.onCompleted: {
        // Create the very first item in the item stack
        var notificationsPageComponent = Qt.createComponent("NotificationsPage.qml");
        var notificationsPage = notificationsPageComponent.createObject(notificationsTab)

        notificationsPage.showPushNotificationView.connect(showUpdateStatus)
        notificationsTab.push(notificationsPage)
    }

    function showUpdateStatus()
    {
        var updatePageComponent = Qt.createComponent("PushNotifications.qml");
        var updatePage = updatePageComponent.createObject(notificationsTab)
        notificationsTab.push(updatePage)
    }
}
