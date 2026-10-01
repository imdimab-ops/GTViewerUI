// paramLogicMTR.js - скрипт для работы с логикой и обновления UI электродвигателей Motor MTR см.PsTechEE
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
    /* как парсить слово диагностики и блокировку смотрим библиотеку PsTechEE/MRT/Двигатель Regul */
    if ((obj.diagn & 0x02) === 0) return "АВАРИЯ"    //bit1
    if (obj.block !== 0) return "БЛОК."  //
    if (obj.state === 2) return "РАБОТА"
    return "ОСТАНОВ"
}
