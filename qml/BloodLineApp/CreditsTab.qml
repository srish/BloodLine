import QtQuick 1.0

ItemStack {
    id: creditsTab

    Component.onCompleted: {
        // Create the very first item in the item stack
       //// var settingsPageComponent = Qt.createComponent("SettingsPage.qml");
       // var settingsPage = settingsPageComponent.createObject(settingsTab)

       // settingsPage.unsubscribeChannels.connect(showUnsubscribeChannelsPage)
       // settingsTab.push(settingsPage)
        var creditsPageComponent = Qt.createComponent("Credits.qml");
        var creditsPage = creditsPageComponent.createObject(creditsTab)

//        settingsPage.listOfCities.connect(showListOfCities)
//        settingsPage.aboutUsPage.connect(showAboutUsPage)
        creditsTab.push(settingsPage)
    }
}
