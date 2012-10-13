import QtQuick 1.0

ItemStack {
    id: settingsTab

    Component.onCompleted: {
        // Create the very first item in the item stack
        var settingsPageComponent = Qt.createComponent("SettingsPage.qml");
        var settingsPage = settingsPageComponent.createObject(settingsTab)

        settingsPage.listOfCities.connect(showListOfCities)
        settingsPage.aboutUsPage.connect(showAboutUsPage)
        settingsTab.push(settingsPage)
    }

    function showListOfCities()
    {
        var citiesListComponent = Qt.createComponent("CitiesList.qml");
        var citiesPage = citiesListComponent.createObject(settingsTab)
        citiesPage.listOfDelhi.connect(showListOfDelhi)
        citiesPage.listOfBangalore.connect(showListOfBangalore)
        settingsTab.push(citiesPage)
    }

    function showListOfDelhi()
    {
        var listDelhiComponent = Qt.createComponent("ListDelhi.qml");
        var listDelhiPage = listDelhiComponent.createObject(settingsTab)
        settingsTab.push(listDelhiPage)
    }

    function showListOfBangalore()
    {
        var listBangaloreComponent = Qt.createComponent("ListBangalore.qml");
        var listBangalorePage = listBangaloreComponent.createObject(settingsTab)
        settingsTab.push(listBangalorePage)

    }

    function showAboutUsPage()
    {
        var aboutUsPageComponent = Qt.createComponent("AboutUs.qml")
        var aboutUsPage = aboutUsPageComponent.createObject(settingsTab)
        settingsTab.push(aboutUsPage)
    }
}
