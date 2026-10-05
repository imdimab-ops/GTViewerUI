// paramLogicMTR.js - скрипт для работы с логикой и обновления UI электродвигателей Motor MTR см.PsTechEE
.pragma library
.import QtQml as QQml //импорт модуля QtQml, для доступа к Component при создании контексного меню и паспорта, т.к. JS его нет

//хранилище
var _passportStore = {} //паспорта компонентов
var _contextMenuInstance = null //экземпляр контекстного меню


//конфигурация свойств для обновления (_propertyConfig — это объект-«схема», где для каждого свойства задана функция-преобразователь)
var _propertyConfig = {
    e_mode: Number,
    e_state: Number,
    w_diagn: Number,
    w_block: Number,
    unit: v => v,
    description: v => v,
    tagname: v => v
}

/* функция обновления состояния двигателя (работа, отказ, ошибка) */
function _updateState(obj, key) {
    if (!obj || !key) return
    switch (key) {
    case 'e_state':
        obj.running = (obj.e_state === 2) //см.PsTechEE MTR ENUM_MTR_STATE
        break
    case 'w_diagn':
        obj.fault = (obj.w_diagn & 0x01) === 0 //маска bit0 - ОК (Все в норме или выбран режим "Ремонтный") см.PsTechEE MTR DIAGN
        break
    case 'w_block':
        /* g 'w_block' отображаем в паспорте и не взводим "block",
         * тк у Regul это "Признаки действующих технологических команд и запретов" */
        break
    default:
        break
    }
}

/* !!!свойства каждого элемента obj обновляем из функции handleDataUpdate(arg) connectionsLogic.js */
function updateData(obj, data) {
    if (!obj || obj.type !== "MTR" || !data) return

    //обновляем свойства
    Object.keys(_propertyConfig).forEach(function(key) { //forEach - обновляем каждый элемент массива propertyConfig
        if (data[key] !== undefined) {
            var newVal = _propertyConfig[key](data[key])    //_propertyConfig["e_mode"] -> Number(data["e_mode"]) -> var newVal = 42
            if (obj[key] !== newVal) {
                obj[key] = newVal
                _updateState(obj, key)  //обновляем по ключам состояние двигателя
            }
        }
    })

    //oбновляем паспорт если открыт
    // var passport = _passportStore[obj]
    // if (passport && passport.visible) {
    //     passport.updateData({
    //                             pv: obj.pv,
    //                             ah: obj.ah,
    //                             ah2: obj.ah2,
    //                             al: obj.al,
    //                             al2: obj.al2,
    //                             hyst: obj.hyst,
    //                             wh: obj.wh,
    //                             wl: obj.wl,
    //                             lrv: obj.lrv,
    //                             urv: obj.urv,
    //                             bcw: obj.bcw,
    //                             stw: obj.stw,
    //                             sim: obj.sim,
    //                             timestamp: obj.timestamp,
    //                         })
    // }
}

/* отображаем контествное меню */
function showContextMenu(obj, path) {
    if (!obj) return null

    //закрываем предыдущее меню если открыто
    if (_contextMenuInstance) {
        _contextMenuInstance.close()
        _contextMenuInstance.destroy()
        _contextMenuInstance = null
    }

    var component = Qt.createComponent(path || "ContextMenu.qml")
    if (component.status === QQml.Component.Ready) {
        var contextMenu = component.createObject(obj)
        if (contextMenu) {
            //Обновляем данные
            contextMenu.targetObject = obj
            contextMenu.name = obj.name;
            contextMenu.symbol = obj.symbol;

            //Подключаем сигналы
            // contextMenu.emitAddToChart.connect(function(symbolFromMenu) {
            //     obj.addTag = !obj.addTag
            //     var data = {
            //         addTag: obj.addTag,
            //         name: obj.name,
            //         symbol: obj.symbol,
            //         unit: obj.unit,
            //         description: obj.description,
            //         tagname: obj.tagname
            //     }
            //     obj.emitAddToChart(data)
            // });
            contextMenu.emitShowPassport.connect(function(symbolFromMenu) {
                _showPassport(obj, "PassportParamMTR.qml")
            });

            contextMenu.closed.connect(function() {
                _contextMenuInstance = null
                contextMenu.destroy();
            })
            _contextMenuInstance = contextMenu
            contextMenu.open()
            return contextMenu
        }
    }
    return null
}

function getBit(value, bitPosition) {
    return (value >> bitPosition) & 1; //сдвигаем биты числа вправо на bitPosition позиций & 1 - побитовое И с числом 1
}

function getMode(obj) {
    if (!obj) return "!"
    switch (obj.e_mode) {
    case 0: return "R" //Remote
    case 1: return "A" //Auto
    case 2: return "T" //Test
    case 3: return "R" //Repair
    case 4: return "L" //Local
    default: return "!"; // неизвестный режим - белый
    }
}

function getModeColor(obj) {
    if (!obj) return "transparent";
    switch (obj.e_mode) {
    case 0: return "#4A90D9"; // Remote - синий
    case 1: return "#3ab842"; // Auto - зелёный
    case 2: return "#ffA000"; // Test - оранжевый
    case 3: return "#ff0000"; // Repair - красный
    case 4: return "#9B59B6"; // Local - фиолетовый
    default: return "transparent"; // неизвестный режим - белый
    }
}
