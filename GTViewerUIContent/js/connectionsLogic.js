// connectionsLogic.js - скрипт для работы с логикой и обновления UI
.pragma library
.import "../components/paramLogicAI.js" as ParamLogicAI //импортировал для обновления сразу через JS
.import "../components/paramLogicMTR.js" as ParamLogicMTR

//хранилище компонентов
var _componentStoreAI = {}  //AI
var _componentStoreMTR = {} //Motors, Pump, Valves, etc
var _pglobalPlot = null  //указатель на globalPlot
var _pappEng = null      //указатель на appEng

//преобразуем слово в биты и представляем в качестве строки для отладки
function _wordsToBitsToString(value, bitsCount = 16) {
    let result = '';
    for (let i = bitsCount - 1; i >= 0; i--) {
        result += (value >> i) & 1;
        if (i % 4 === 0 && i !== 0) result += ' '; //группировка по 4 бита
    }
    return result;
}

//функция добавления графиков (Берем указатель на график и добавляем графики прямо тут)
function _addCharForPlot (data) {
    if (_pglobalPlot) {
        _pglobalPlot.fsetAddGraph(data)
    } else {
        console.error("CustomPlotSingleton is null!")
        return
    }
}

//функция инициализации с передачей контекста appEng
function initializeContext(appEng) {
    _pappEng = appEng
    _pglobalPlot = _pappEng.fpgetCustomPlot()
    console.log("connectionsLogic.js", "initializeContext _pappEng", _pappEng)
    if (!_pglobalPlot) return

    //сигнал добавления графика со стороны Widget (окно выбора графиков)
    _pglobalPlot.onFemitAddGraphW.connect((data) => {
                                              //поиск компонентов по symbol
                                              var components = _componentStoreAI[data.symbol];
                                              if (!components || components.length === 0) {
                                                  console.warn("connectionsLogic.js", "No components found for symbol:", data.symbol);
                                                  return;
                                              }
                                              //берем tagname из самого элемента т.к. виджет с тегами не хранит данную информацию
                                              _addCharForPlot({
                                                                  addTag: data.addTag,
                                                                  symbol: components[0].symbol,
                                                                  name: components[0].name,
                                                                  unit: components[0].unit,
                                                                  description: components[0].description,
                                                                  tagname: components[0].tagname
                                                              })
                                              // console.log("connectionsLogic.js", "Found", components.length, "components for symbol:", data.symbol, components[0].tagname);
                                          });
    //сигнал состояния графика добавлен/удален для обновления компонентов *.qml
    _pglobalPlot.onFemitStateGgaph.connect((data) => {
                                               //поиск компонентов по symbol
                                               var components = _componentStoreAI[data.symbol];
                                               if (!components || components.length === 0) {
                                                   console.warn("connectionsLogic.js", "No components found for symbol:", data.symbol);
                                                   return;
                                               }
                                               //обновляем ВСЕ компоненты с этим ID
                                               for (var i = 0; i < components.length; i++) {
                                                   ParamLogicAI.updateAddToChartIcon(components[i], data) //обновляем компоненты на прямую через JS а не через QML
                                               }
                                           });
}

//Функция регистрации компонента
function registerComponent(component) {
    if (!component && !component.symbol) return
    var componentId = component.symbol

    switch (component.type) {
    case 'AI':
        //если такого ID еще нет, создаем массив
        if (!_componentStoreAI[componentId]) {
            _componentStoreAI[componentId] = []
        }
        _componentStoreAI[componentId].push(component) //добавляем компонент в массив
        // console.log("connectionsLogic.js", "Registered component:", component.symbol, component.name, "total:", _componentStoreAI[componentId].length)

        //динамически подписываемся на onEmitAddToChart, если он существует
        if (component.onEmitAddToChart && typeof component.onEmitAddToChart.connect === 'function') {
            component.onEmitAddToChart.connect((data) => {
                                                   _addCharForPlot(data)
                                                   // console.log("connectionsLogic.js", "componentId", componentId, data.name, data.tagname, data.addTag);
                                               });
            //заполняем диалоговое окно выбора параметров на графиках
            if (_pglobalPlot) {
                _pglobalPlot.fsetFillParameters({
                                                    //берем первый элемент из массива (их может быть несколько повторяющихся на UI)
                                                    symbol: component.symbol,
                                                    name: component.name,
                                                    tagname: component.tagname
                                                })
            }
            // console.log("Subscribed to onEmitAddToChart for:", componentId);
        }
        break
    case 'MTR':
        //если такого ID еще нет, создаем массив
        if (!_componentStoreMTR[componentId]) {
            _componentStoreMTR[componentId] = []
        }
        _componentStoreMTR[componentId].push(component) //добавляем компонент в массив
        break
    default:
        console.warn("connectionsLogic.js", "Unknown component:", component.type, component.symbol, component.name)
        break
    }
}

//функция обновления данных AI, TAG и тп
function handleDataUpdateAI(arg) {
    //метеостанция
    // if (_componentStoreAI.PT908) _componentStoreAI.PT908[0].updateData(arg.PT908)
    // if (_componentStoreAI.AT901) _componentStoreAI.AT901[0].updateData(arg.AT901)
    // if (_componentStoreAI.TT903) _componentStoreAI.TT903[0].updateData(arg.TT903)

    /* Обращение в JavaScript к элементам:
     * - arg.PT908 - точечная нотация (dot notation)
     * - arg["PT908"] - скобочная нотация (bracket notation) - позволяет использовать переменные */

    var store = _componentStoreAI;
    var ids = Object.keys(store);
    for (var i = 0; i < ids.length; i++) {
        var componentId = ids[i];
        var data = arg[componentId];
        if (data === undefined || data === null) continue;

        var components = store[componentId];
        for (var j = 0; j < components.length; j++) {
            ParamLogicAI.updateData(components[j], data) //обновляем компоненты на прямую через JS а не через QML
        }
    }

    //Object.entries(_componentStoreAI) - преобразует объект в массив пар [ключ, значение]
    // for (const [componentId, components] of Object.entries(_componentStore)) { //components - элемент массива _componentStore, так же является массивом
    //     if (arg[componentId]) {
    //         //обновляем ВСЕ компоненты с этим ID
    //         components.forEach(component => {
    //                                if (component.updateData) {
    //                                    component.updateData(arg[componentId])
    //                                }
    //                            })
    //     }
    // }
    //возвращаем состояния
    return {
        rotateOn: arg.ST50 && Number(arg.ST50.pv) >= 300,
        fireOn: arg.TE71 && Number(arg.TE71.pv) >= 170,
        aiKC1:  arg.TE521 && Number(arg.TE521.pv),
        aiKC2:  arg.TE522 && Number(arg.TE522.pv),
        aiKC3:  arg.TE523 && Number(arg.TE523.pv),
        aiKC4:  arg.TE524 && Number(arg.TE524.pv),
        aiKC5:  arg.TE525 && Number(arg.TE525.pv)
    }
}

//функция обновления данных Motor, Pump, Vent и тп
function handleDataUpdateMTR(arg) {
    var store = _componentStoreMTR;
    var ids = Object.keys(store);
    for (var i = 0; i < ids.length; i++) {
        var componentId = ids[i];
        var data = arg[componentId];
        if (data === undefined || data === null) continue;

        var components = store[componentId];
        for (var j = 0; j < components.length; j++) {
            ParamLogicMTR.updateData(components[j], data) //обновляем компоненты на прямую через JS а не через QML
        }
    }
}
