import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Shapes
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
    property real aiKC1: 190
    property real aiKC2: 190
    property real aiKC3: 190
    property real aiKC4: 190
    property real aiKC5: 190

    //Параллельная анимация для плавного масштабирования и перемещения
    // ParallelAnimation {
    //     id: zoomAnimation
    //     NumberAnimation {
    //         // target:
    //         properties: "xScale,yScale"
    //         duration: 200
    //         easing.type: Easing.InOutQuad
    //     }
    //     NumberAnimation {
    //         target: root
    //         property: "imagePosition.x"
    //         duration: 200
    //         easing.type: Easing.InOutQuad
    //     }
    //     NumberAnimation {
    //         target: root
    //         property: "imagePosition.y"
    //         duration: 200
    //         easing.type: Easing.InOutQuad
    //     }
    // }
    //Анимация возврата в исходное состояние
    // ParallelAnimation {
    //     id: resetAnimation
    //     NumberAnimation {
    //         // target:
    //         properties: "xScale,yScale"
    //         to: 1.0  //Возврат к исходному масштабу
    //         duration: 200
    //         easing.type: Easing.InOutQuad
    //     }
    //     NumberAnimation {
    //         target: root
    //         property: "imagePosition.x"
    //         to: 0
    //         duration: 200
    //         easing.type: Easing.InOutQuad
    //     }
    //     NumberAnimation {
    //         target: root
    //         property: "imagePosition.y"
    //         to: 0
    //         duration: 200
    //         easing.type: Easing.InOutQuad
    //     }
    // }

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
            // radius:
        }
    }

    AnimatedImage {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/rotate.gif"
        sourceSize: Qt.size(475, 250)
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: _rotateOn
        scale: 0.87
        anchors {
            top: imgBlock1.top
            topMargin: 550
            left: imgBlock1.left
            leftMargin: 470
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
        scale: 0.95
        anchors {
            top: imgBlock1.top
            topMargin: 247
            left: imgBlock1.left
            leftMargin: 768
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam1.svg"
        sourceSize: Qt.size(225, 115) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        scale: 0.95
        anchors {
            top: imgBlock1.top
            topMargin: 362
            left: imgBlock1.left
            leftMargin: 768
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam2.svg"
        sourceSize: Qt.size(235, 154) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        scale: 0.95
        anchors {
            top: imgBlock1.top
            topMargin: 477
            left: imgBlock1.left
            leftMargin: 760
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam3.svg"
        sourceSize: Qt.size(235, 154) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        scale: 0.95
        anchors {
            top: imgBlock1.top
            topMargin: 717
            left: imgBlock1.left
            leftMargin: 760
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/cam4.svg"
        sourceSize: Qt.size(225, 115) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        scale: 0.95
        anchors {
            top: imgBlock1.top
            topMargin: 870
            left: imgBlock1.left
            leftMargin: 768
        }
    }
    Image {
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/turboFireEx.svg"
        sourceSize: Qt.size(375, 225) //Указываем явный размер, иначе Qt уменьшает SVG до размера экрана при загрузке
        visible: _fireOn
        anchors {
            top: imgBlock1.top
            topMargin: 562
            left: imgBlock1.left
            leftMargin: 825
        }
    }
    AnimatedImage {
        width: 300
        height: 300
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        source: "img/gtu/firecam.gif"
        playing: true  //Автоматическое воспроизведение (!!!!!! Привязать в температуре в КС !!!!!!)
        visible: Number(aiKC1 >= 180) && _rotateOn
        scale: 0.7
        anchors {
            top: imgBlock1.top
            topMargin: 130
            left: imgBlock1.left
            leftMargin: 710
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
        visible: Number(aiKC2 >= 180) && _rotateOn
        scale: 0.7
        anchors {
            top: imgBlock1.top
            topMargin: 245
            left: imgBlock1.left
            leftMargin: 710
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
        visible: Number(aiKC3 >= 180) && _rotateOn
        scale: 0.7
        anchors {
            top: imgBlock1.top
            topMargin: 360
            left: imgBlock1.left
            leftMargin: 710
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
        visible: Number(aiKC4 >= 180) && _rotateOn
        scale: 0.7
        anchors {
            top: imgBlock1.top
            topMargin: 680
            left: imgBlock1.left
            leftMargin: 710
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
        visible: Number(aiKC5 >= 180) && _rotateOn
        scale: 0.7
        anchors {
            top: imgBlock1.top
            topMargin: 795
            left: imgBlock1.left
            leftMargin: 710
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
            top: imgBlock1.top
            topMargin: 520
            left: imgBlock1.left
            leftMargin: 980
        }

        //Если нужно вращение вокруг центра (по умолчанию вращение вокруг (0,0))
        transformOrigin: Item.Center  //Вращение вокруг центра элемента
        rotation: 90
        opacity: 1.0  //Полупрозрачность (0.0 - 1.0)
    }


    //Аналоговые параметры

    //=========== Метеостанция ========================
    Rectangle {
        width: 395
        height: 70
        color: "transparent"
        border.color: "#cccccc"
        border.width: 1
        anchors {
            top: imgBlock1.top
            topMargin: 30
            left: imgBlock1.left
            leftMargin: 30
        }

        AI {
            id: aiPT908
            name: "Ратм"
            symbol: "PT908"
            pv: 0
            lrv: 0
            urv: 200
            stw: 0
            unit: "кПа"
            onEmitAddToChart: (data)=> {
                                  _addCharForPlot(data)
                              }
            scale: 0.70
            anchors {
                top: parent.top
                topMargin: 5
                left: parent.left
                leftMargin: 0
            }
        }
        AI {
            id: aiAT901
            name: "Влажность"
            symbol: "AT901"
            pv: 0
            lrv: 0
            urv: 100
            stw: 0
            unit: "%"
            onEmitAddToChart: (data)=> {
                                  _addCharForPlot(data)
                              }
            scale: 0.70
            anchors {
                top: parent.top
                topMargin: 5
                left: parent.left
                leftMargin: 120
            }
        }
        AI {
            id: aiTT903
            name: "Tатм"
            symbol: "TT903"
            pv: 0
            lrv: -40
            urv: 110
            stw: 0
            unit: "℃"
            onEmitAddToChart: (data)=> {
                                  _addCharForPlot(data)
                              }
            scale: 0.70
            anchors {
                top: parent.top
                topMargin: 5
                left: parent.left
                leftMargin: 240
            }
        }
    }
    //======================================================

    //=========== Топливная система ========================
    AI {
        id: aiPT421
        name: "Ртг на фильтре"
        symbol: "PT421"
        pv: 0
        lrv: 0
        urv: 2
        stw: 0
        unit: "МПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 60
            left: imgBlock1.left
            leftMargin: 1815
        }
    }
    AI {
        id: aiPT422
        name: "Ртг компр"
        symbol: "PT422"
        pv: 0
        lrv: 0
        urv: 2
        stw: 0
        unit: "МПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 60
            left: imgBlock1.left
            leftMargin: 1535
        }
    }
    AI {
        id: aiTT421
        name: "Tтг компр"
        symbol: "TT421"
        pv: 0
        lrv: -50
        urv: 100
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 10
            left: imgBlock1.left
            leftMargin: 1535
        }
    }
    AI {
        id: aiGfuel_1
        name: "Расход ТГ"
        symbol: "FT421"
        pv: 0
        lrv: 0
        urv: 250
        stw: 0
        unit: "г/с"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 50
            left: imgBlock1.left
            leftMargin: 1395
        }
    }
    AI {
        id: aiPT403
        name: "Ртг FV401_1"
        symbol: "PT403"
        pv: 0
        lrv: 0
        urv: 2
        stw: 0
        unit: "МПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 60
            left: imgBlock1.left
            leftMargin: 1235
        }
    }
    AI {
        id: aiPT404
        name: "Ртг FV401_2"
        symbol: "PT404"
        pv: 0
        lrv: 0
        urv: 2
        stw: 0
        unit: "МПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 10
            left: imgBlock1.left
            leftMargin: 1235
        }
    }
    AI {
        id: aiTT401
        name: "Tтг"
        symbol: "TT401"
        pv: 0
        lrv: -50
        urv: 100
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 145
            left: imgBlock1.left
            leftMargin: 1235
        }
    }
    //======================================================

    //=========== Маслосистема =============================
    AI {
        id: aiLT201
        name: "Уровень масла"
        symbol: "LT201"
        pv: 0
        lrv: 0
        urv: 500
        stw: 0
        unit: "мм"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 985
            left: imgBlock1.left
            leftMargin: 0
        }
    }
    AI {
        id: aiTT204
        name: "Tмасла МБ"
        symbol: "TT204"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 855
            left: imgBlock1.left
            leftMargin: 55
        }
    }
    AI {
        id: aiPT203
        name: "Рм"
        symbol: "PT203"
        pv: 0
        lrv: 0
        urv: 1
        stw: 0
        unit: "МПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 905
            left: imgBlock1.left
            leftMargin: 150
        }
    }
    AI {
        id: aiPDT204
        name: "Перепад"
        symbol: "PDT204"
        pv: 0
        lrv: 0
        urv: 160
        stw: 0
        unit: "кПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 985
            left: imgBlock1.left
            leftMargin: 265
        }
    }
    AI {
        id: aiPT206B
        name: "Рм ГТД_2"
        symbol: "PT206B"
        pv: 0
        lrv: 0
        urv: 630
        stw: 0
        unit: "кПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 810
            left: imgBlock1.left
            leftMargin: 450
        }
    }
    AI {
        id: aiPT206A
        name: "Рм ГТД_1"
        symbol: "PT206A"
        pv: 0
        lrv: 0
        urv: 630
        stw: 0
        unit: "кПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 855
            left: imgBlock1.left
            leftMargin: 450
        }
    }
    AI {
        id: aiTT205
        name: "Tмвых АВОМ"
        symbol: "TT205"
        pv: 0
        lrv: -50
        urv: 100
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 900
            left: imgBlock1.left
            leftMargin: 450
        }
    }
    AI {
        id: aiTT206
        name: "Tмвых ред"
        symbol: "TT206"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 740
            left: imgBlock1.left
            leftMargin: 375
        }
    }
    AI {
        id: aiTT207
        name: "Tмвых ГТД"
        symbol: "TT207"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 740
            left: imgBlock1.left
            leftMargin: 600
        }
    }
    //======================================================

    //=========== ГТД =============================
    AI {
        id: aiTE521
        name: "T КС1_1"
        symbol: "TE521"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 220
            left: imgBlock1.left
            leftMargin: 720
        }
    }
    AI {
        id: aiTE522
        name: "T КС2_1"
        symbol: "TE522"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 335
            left: imgBlock1.left
            leftMargin: 720
        }
    }
    AI {
        id: aiTE523
        name: "T КС3_1"
        symbol: "TE523"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 450
            left: imgBlock1.left
            leftMargin: 720
        }
    }
    AI {
        id: aiTE524
        name: "T КС4_1"
        symbol: "TE524"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 770
            left: imgBlock1.left
            leftMargin: 720
        }
    }
    AI {
        id: aiTE525
        name: "T КС5_1"
        symbol: "TE525"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 885
            left: imgBlock1.left
            leftMargin: 720
        }
    }
    AI {
        id: aiTE531
        name: "T КС1_2"
        symbol: "TE531"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 285
            left: imgBlock1.left
            leftMargin: 830
        }
    }
    AI {
        id: aiTE532
        name: "T КС2_2"
        symbol: "TE532"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 400
            left: imgBlock1.left
            leftMargin: 830
        }
    }
    AI {
        id: aiTE533
        name: "T КС3_2"
        symbol: "TE533"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 515
            left: imgBlock1.left
            leftMargin: 830
        }
    }
    AI {
        id: aiTE534
        name: "T КС4_2"
        symbol: "TE534"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 835
            left: imgBlock1.left
            leftMargin: 830
        }
    }
    AI {
        id: aiTE535
        name: "T КС5_2"
        symbol: "TE535"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 950
            left: imgBlock1.left
            leftMargin: 830
        }
    }
    AI {
        id: aiST50
        name: "Обороты турб"
        symbol: "ST50"
        pv: 0
        lrv: 0
        urv: 30000
        stw: 0
        unit: "об"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 645
            left: imgBlock1.left
            leftMargin: 735
        }
    }
    AI {
        id: aiTE701
        name: "Tв компр"
        symbol: "TE701"
        pv: 0
        lrv: -50
        urv: 200
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 270
            left: imgBlock1.left
            leftMargin: 600
        }
    }
    AI {
        id: aiPT701
        name: "Рк"
        symbol: "PT701"
        pv: 0
        lrv: 0
        urv: 1.6
        stw: 0
        unit: "МПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 320
            left: imgBlock1.left
            leftMargin: 600
        }
    }
    AI {
        id: aiFT901
        name: "Gвх турбины"
        symbol: "FT901"
        pv: 0
        lrv: 0
        urv: 20
        stw: 0
        unit: "кг/с"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 390
            left: imgBlock1.left
            leftMargin: 500
        }
    }
    AI {
        id: aiPDT902
        name: "Разр возд"
        symbol: "PDT902"
        pv: 0
        lrv: 0
        urv: 2.5
        stw: 0
        unit: "кПа"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 435
            left: imgBlock1.left
            leftMargin: 500
        }
    }
    AI {
        id: aiGair_1
        name: "Gвозд ГТД"
        symbol: "Gair"
        pv: 0
        lrv: 0
        urv: 15
        stw: 0
        unit: "кг/с"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 480
            left: imgBlock1.left
            leftMargin: 500
        }
    }
    AI {
        id: aiTT901
        name: "Tвх компр"
        symbol: "TT901"
        pv: 0
        lrv: -60
        urv: 60
        stw: 0
        unit: "℃"
        onEmitAddToChart: (data)=> {
                              _addCharForPlot(data)
                          }
        scale: 0.70
        anchors {
            top: imgBlock1.top
            topMargin: 525
            left: imgBlock1.left
            leftMargin: 500
        }
    }
    //======================================================

    //=========== Генератор AIpbv =====================
    Rectangle {
        width: mainRowGenerator.implicitWidth + 20 //растягиваем Rectangle по содержимому
        height: mainRowGenerator.implicitHeight + 30
        color: "transparent"
        border.color: "#cccccc"
        border.width: 1
        anchors {
            top: imgBlock1.top
            topMargin: 180
            right: imgBlock1.right
            rightMargin: 20
        }

        Label {
            text: qsTr("Генератор")
            font.pixelSize: 16
            font.bold: true
            color: "#333333"
            anchors {
                top: parent.top
                topMargin: 0
                horizontalCenter: parent.horizontalCenter
            }
        }
        RowLayout {
            id: mainRowGenerator
            anchors {
                top: parent.top
                topMargin: 25
                horizontalCenter: parent.horizontalCenter
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("Виброскорость, СКЗ")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiVT503
                        name: "X, NDE"
                        symbol: "VT503"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT504
                        name: "Y, NDE"
                        symbol: "VT504"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT501
                        name: "X, DE"
                        symbol: "VT501"
                        pv: 178
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT502
                        name: "Y, DE"
                        symbol: "VT502"
                        pv: 178
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }

                }

            }
            Item {
                width: 15
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("T обмоток, ℃")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiTE590
                        name: "U, т.1"
                        symbol: "TE590"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE591
                        name: "U, т.2"
                        symbol: "TE591"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE592
                        name: "V, т.1"
                        symbol: "TE592"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE593
                        name: "V, т.2"
                        symbol: "TE593"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE594
                        name: "W, т.1"
                        symbol: "TE594"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE595
                        name: "W, т.2"
                        symbol: "TE595"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }

            }
            Item {
                width: 15
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("T подшипн, ℃")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiTE596
                        name: "NDE"
                        symbol: "TE596"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE597
                        name: "DE"
                        symbol: "TE597"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
        }

    }
    //======================================================

    //=========== Редуктор AIpbv ======================
    Rectangle {
        width: mainRowReductor.implicitWidth + 20 //растягиваем Rectangle по содержимому
        height: mainRowReductor.implicitHeight + 30
        color: "transparent"
        border.color: "#cccccc"
        border.width: 1
        anchors {
            top: imgBlock1.top
            topMargin: 450
            right: imgBlock1.right
            rightMargin: 20
        }

        Label {
            text: qsTr("Редуктор")
            font.pixelSize: 16
            font.bold: true
            color: "#333333"
            anchors {
                top: parent.top
                topMargin: 0
                horizontalCenter: parent.horizontalCenter
            }
        }
        RowLayout {
            id: mainRowReductor
            anchors {
                top: parent.top
                topMargin: 25
                horizontalCenter: parent.horizontalCenter
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("Виброскорость, мм/с")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiVT505
                        name: "X"
                        symbol: "VT505"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT506
                        name: "Y"
                        symbol: "VT506"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT510
                        name: "Z"
                        symbol: "VT510"
                        pv: 178
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
            Item {
                width: 20
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("Вибропер, мкм")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiZT501
                        name: "НВ т.1"
                        symbol: "ZT501"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiZT502
                        name: "НВ т.2"
                        symbol: "ZT501"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
            Item {
                width: 20
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("T подшипн, ℃")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiTE576
                        name: "ПВвх т.1"
                        symbol: "TE576"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE577
                        name: "ПВвх т.2"
                        symbol: "TE577"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE578
                        name: "ПВвх т.3"
                        symbol: "TE578"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE579
                        name: "ПВвых т.1"
                        symbol: "TE579"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE580
                        name: "ПВвых т.2"
                        symbol: "TE580"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE581
                        name: "ПВвых т.3"
                        symbol: "TE581"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE582
                        name: "НВвх"
                        symbol: "TE582"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE583
                        name: "НВвых"
                        symbol: "TE583"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
        }
    }
    //======================================================

    //=========== Турбина AIpbv =======================
    Rectangle {
        width: mainRowGTD.implicitWidth + 20 //растягиваем Rectangle по содержимому
        height: mainRowGTD.implicitHeight + 30
        color: "transparent"
        border.color: "#cccccc"
        border.width: 1
        anchors {
            top: imgBlock1.top
            topMargin: 735
            right: imgBlock1.right
            rightMargin: 20
        }

        Label {
            text: qsTr("ГТД")
            font.pixelSize: 16
            font.bold: true
            color: "#333333"
            anchors {
                top: parent.top
                topMargin: 0
                horizontalCenter: parent.horizontalCenter
            }
        }
        RowLayout {
            id: mainRowGTD
            anchors {
                top: parent.top
                topMargin: 25
                horizontalCenter: parent.horizontalCenter
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("...")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiGfuel_2
                        name: "Gтг"
                        symbol: "Gfuel"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiGair_2
                        name: "Gвозд"
                        symbol: "Gair"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiLoad_2
                        name: "Нагр."
                        symbol: "Load"
                        pv: 178
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
            Item {
                width: 15
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("Виброскорость, мм/с")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiVT507
                        name: "X"
                        symbol: "VT507"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT508
                        name: "Y"
                        symbol: "VT508"
                        pv: 78
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiVT509
                        name: "Z"
                        symbol: "VT509"
                        pv: 178
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
            Item {
                width: 15
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("Вибропер, мкм")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiZT503
                        name: "т.1"
                        symbol: "ZT503"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiZT504
                        name: "т.2"
                        symbol: "ZT504"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
            Item {
                width: 15
            }
            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Label {
                    text: qsTr("T подшипн, ℃")
                    font.pixelSize: 12
                    color: "#333333"
                    Layout.alignment: Qt.AlignHCenter
                }
                RowLayout {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    AIpbv {
                        id: aiTE501A
                        name: "ОК ОП т.1"
                        symbol: "TE501A"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE501B
                        name: "ОК ОП т.2"
                        symbol: "TE501B"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE502A
                        name: "ОК ОУП т.1"
                        symbol: "TE502A"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE502B
                        name: "ОК ОУП т.2"
                        symbol: "TE502B"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE503A
                        name: "УРК ОУП т.1"
                        symbol: "TE503A"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE503B
                        name: "УРК ОУП т.2"
                        symbol: "TE503B"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE504A
                        name: "УУК ОУП т.1"
                        symbol: "TE504A"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                    AIpbv {
                        id: aiTE504B
                        name: "УУК ОУП т.2"
                        symbol: "TE504B"
                        pv: 20
                        lrv: 0
                        urv: 250
                        stw: 0
                        Layout.alignment: Qt.AlignTop
                        onEmitAddToChart: (data)=> {
                                              _addCharForPlot(data)
                                          }
                    }
                }
            }
        }
    }
    //======================================================
}
