import QtQuick
import GTViewerUI
import QtQuick.Controls

Window {
    width: mainScreen.width
    height: mainScreen.height

    visible: true
    title: "GTSclientUI"

    // Loader для загрузки QML файлов
        Loader {
            id: screenLoader
            anchors.fill: parent
            visible: false
        }

        Button {
            text: "Открыть GTU"
            anchors.centerIn: parent
            onClicked: {
                // Загружаем файл в Loader
                screenLoader.source = "ScreenGTU.ui.qml"
                screenLoader.visible = true

                // Если нужно скрыть кнопку
                visible = false
            }
        }


}

