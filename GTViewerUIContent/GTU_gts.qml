import QtQuick
import QtQuick.Controls 6.2
import QtQuick.Window 2.15
import QtQuick.Layouts
import QtQuick.Shapes 1.9
import "./components"


//Перемещаем изображение после масштабирования
Item {
    id: root
    width: 1920
    height: 1080

    Component.onCompleted: {
        console.log("QML GTU size:", width, height)
    }

    property bool _rotateOn : true
    property bool _fireOn : true

    //Параллельная анимация для плавного масштабирования и перемещения
    ParallelAnimation {
        id: zoomAnimation
        NumberAnimation {
            target: imageScale
            properties: "xScale,yScale"
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "imagePosition.x"
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "imagePosition.y"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
    //Анимация возврата в исходное состояние
    ParallelAnimation {
        id: resetAnimation
        NumberAnimation {
            target: imageScale
            properties: "xScale,yScale"
            to: 1.0  //Возврат к исходному масштабу
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "imagePosition.x"
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: root
            property: "imagePosition.y"
            to: 0
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    Image {
        id: imgBlock1
        anchors.centerIn: parent
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/base.svg"
        sourceSize: Qt.size(1280, 1041) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "#cccccc"
            border.width: 1
            radius: 5 / imageScale.xScale
        }
    }

    AnimatedImage {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/rotate.gif"
        sourceSize: Qt.size(475, 250)
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: _rotateOn
        scale: 0.90
        anchors {
            top: imgBlock1.top
            topMargin: 575
            left: imgBlock1.left
            leftMargin: 497
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 0
        opacity: 1.0  //Полупрозрачность (0.0 - 1.0)
    }

    //Камера сгорания
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam1.svg"
        sourceSize: Qt.size(225, 115) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 660  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 252  //Отступ слева 20px
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam1.svg"
        sourceSize: Qt.size(225, 115) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 543  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 252  //Отступ слева 20px
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam2.svg"
        sourceSize: Qt.size(235, 154) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 390  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 252  //Отступ слева 20px
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam3.svg"
        sourceSize: Qt.size(235, 154) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 140  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 252  //Отступ слева 20px
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam4.svg"
        sourceSize: Qt.size(225, 115) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 22  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 252  //Отступ слева 20px
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/turboFireEx.svg"
        sourceSize: Qt.size(375, 225) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 228  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 40  //Отступ слева 20px
        }
    }
    AnimatedImage {
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/firecam.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: Number(aiKC1.pv >= 180) && _rotateOn
        scale: 0.7
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 600  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 230  //Отступ слева 20px
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 270
        opacity: 0.9  //Полупрозрачность (0.0 - 1.0)
    }
    AnimatedImage {
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/firecam.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: Number(aiKC2.pv >= 180) && _rotateOn
        scale: 0.7
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 480  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 230  //Отступ слева 20px
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 270
        opacity: 0.9  //Полупрозрачность (0.0 - 1.0)
    }
    AnimatedImage {
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/firecam.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: Number(aiKC3.pv >= 180) && _rotateOn
        scale: 0.7
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 363  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 230  //Отступ слева 20px
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 270
        opacity: 0.9  //Полупрозрачность (0.0 - 1.0)
    }
    AnimatedImage {
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/firecam.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: Number(aiKC4.pv >= 180) && _rotateOn
        scale: 0.7
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 28  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 230  //Отступ слева 20px
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 270
        opacity: 0.9  //Полупрозрачность (0.0 - 1.0)
    }
    AnimatedImage {
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/firecam.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: Number(aiKC5.pv >= 180) && _rotateOn
        scale: 0.7
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: -92  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: 230  //Отступ слева 20px
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 270
        opacity: 0.9  //Полупрозрачность (0.0 - 1.0)
    }
    AnimatedImage {
        z: -1
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/fire.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: _fireOn && _rotateOn
        scale: 1.2
        anchors {
            bottom: imgBlock1.bottom
            bottomMargin: 195  //Отступ сверху 15px
            right: imgBlock1.right
            rightMargin: -90  //Отступ слева 20px
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 90
        opacity: 1.0  //Полупрозрачность (0.0 - 1.0)
    }

    // AIpb {

    //     anchors {
    //         top: imgBlock1.top
    //         topMargin: 80  //Отступ сверху 15px
    //         left: imgBlock1.left
    //         leftMargin: 90  //Отступ слева 20px
    //     }
    // }

}
