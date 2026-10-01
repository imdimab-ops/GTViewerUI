// paramLogic.js - скрипт для работы с логикой и обновления UI аналоговых компонентов AI
.pragma library
.import QtQml as QQml //импорт модуля QtQml, для доступа к Component при создании контексного меню и паспорта, т.к. JS его нет

//хранилище
var _passportStore = {} //паспорта компонентов
var _contextMenuInstance = null //экземпляр контекстного меню


function getBit(value, bitPosition) {
    return (value >> bitPosition) & 1; //сдвигаем биты числа вправо на bitPosition позиций & 1 - побитовое И с числом 1
}

function getMode(obj) {
    if (!obj) return "!"
    switch (obj.mode) {
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
    switch (obj.mode) {
    case 0: return "#4A90D9"; // Remote - синий
    case 1: return "#3ab842"; // Auto - зелёный
    case 2: return "#ffA000"; // Test - оранжевый
    case 3: return "#ff0000"; // Repair - красный
    case 4: return "#9B59B6"; // Local - фиолетовый
    default: return "transparent"; // неизвестный режим - белый
    }
}

function statusText(obj) {
    if (obj.diagn !== 0) return "АВАРИЯ"
    if (obj.block !== 0) return "БЛОК."  //
    if (obj.state === 2) return "РАБОТА"
    return "ОСТАНОВ"
}

function getProgressColor(obj) {
    if (!obj) return "#2ecc71"
    if (obj.stw & 0x02) return "#5b6262" //bit1 - Bad
    if (obj.stw & 0x08) return "#ff0000" //bit2 - Alarm
    if (obj.stw & 0x04) return "#ffA000" //bit3 - Warning
    return "#2ecc71"
}


//Функция снятия визуализации на элементе (при удалении графиков)(визуализация в контекстном меню)
function updateAddToChartIcon(obj, data) {
    if (data.symbol === obj.symbol) {
        obj.addTag = data.addTag
    }
}

