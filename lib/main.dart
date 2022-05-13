import 'package:flutter/material.dart';
import 'gameWorld.dart';
import 'package:get/get.dart';
import 'getControl.dart';
import 'dart:math';

void main() {
  _get.createEtalon();
  _get.randomInitemsList();
  _get.createTempList();

  runApp(GetMaterialApp(
    title: 'Игра жизнь',
    theme: ThemeData.dark(),
    home: const GameApp(),
    debugShowCheckedModeBanner: false,
  ));
}

final _get = Get.put(GetCon());
Color iconColor = Colors.white;
Color btnColor = Colors.red;
double _iconSize = 30;
double _elevatBtn = 7.0;
int sosedi = 0;
dynamic forCompare;

final rnd = Random();

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  Future<void> game(vaLToStart) async {
    while (vaLToStart == true) {
      await Future.delayed(const Duration(milliseconds: 1));
      if (_get.start.value == false) {
        Get.snackbar('Игра остановлена!', 'Вы остановили игру');
        break;
      } else if (_get.tempListForAddValue.hashCode ==
          _get.itemsList900.hashCode) {
        Get.snackbar('Игра остановлена!', 'Устойчивое состояние');
        break;
      } else {
        _get.addGen();
      }

      for (int x = 0; x < _get.itemsList900.length; x++) {
        for (int y = 0; y < _get.itemsList900[x].length; y++) {
          // посчитаем соседей
          // и запишем в новый массив результат расчетов
          detectLiveAround(x, y, _get.itemsList900);

          // добавить код остановки?
          if (_get.start.value == false) {
            break;
          }
        }
      }

      _get.addFromTempList(_get
          .itemsList900); // записываем значение в постоянный массив из временного
      forCompare = _get.itemsList900;
    }
  }

  void detectLiveAround(x, y, list) {
    // определим соседей нашей клетки
    sosedi = 0;
    // проверка на несуществующий индекс x != -1 / 30 && y != -1 / 30
    if (x + 1 != 30 && y + 1 != 30 && x - 1 != -1 && y - 1 != -1) {
      list[x - 1][y] == 1 ? sosedi += 1 : null;
      list[x][y - 1] == 1 ? sosedi += 1 : null;
      list[x - 1][y - 1] == 1 ? sosedi += 1 : null;
      list[x + 1][y + 1] == 1 ? sosedi += 1 : null;
      list[x + 1][y] == 1 ? sosedi += 1 : null;
      list[x][y + 1] == 1 ? sosedi += 1 : null;
      list[x + 1][y - 1] == 1 ? sosedi += 1 : null;
      list[x - 1][y + 1] == 1 ? sosedi += 1 : null;
    }

    if (list[x][y] == 0 && sosedi == 3) {
      // соседей 3 меняем клетку на 1
      _get.addTolistForAddValue(x, y, 1);
    } else if (list[x][y] == 1 && sosedi > 3 || sosedi < 2) {
      // клетка 1 соседей больше > 3 или < 2  меняем на 0

      _get.addTolistForAddValue(x, y, 0);
    } else if (list[x][y] == 0 && sosedi != 3) {
      _get.addTolistForAddValue(x, y, 0);
    } else if (list[x][y] == 1 && (sosedi == 3 || sosedi == 2)) {
      _get.addTolistForAddValue(x, y, 1);
    }
  }
/*
  bool? listContainsOneValue(list) {
    for (int x = 0; x < list.length; x++) {
      if (list[x].contains(0) == true && list[x].contains(1) == false) {
        print('False');
        return false;
      } else if (list[x].contains(0) == true && list[x].contains(1) == true) {
        print('True');
        return true;
      }
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Игра жизнь'),
                  Text('Поколение: ${_get.generation}'),
                ],
              )),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 27.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => FloatingActionButton(
                  elevation: _elevatBtn,
                  backgroundColor: btnColor,
                  onPressed: () {
                    _get.changeGame();
                    game(_get.start.value);
                  },
                  child: Icon(
                      _get.start.value != false
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: _iconSize,
                      color: iconColor))),
              FloatingActionButton(
                  elevation: _elevatBtn,
                  backgroundColor: btnColor,
                  onPressed: () {
                    _get.gameStop();
                    _get.addInitemsList(); // поколение обнуляется внутри
                  },
                  child: Icon(Icons.stop, color: iconColor, size: _iconSize)),
              FloatingActionButton(
                elevation: _elevatBtn,
                backgroundColor: btnColor,
                onPressed: () {
                  _get.gameStop();
                  _get.randomInitemsList();
                },
                child: Icon(Icons.auto_fix_high,
                    color: iconColor, size: _iconSize),
              ),
            ],
          ),
        ),
        body: GameWorld());
  }
}



/*
if (_get.start.value == false) {
  Get.snackbar('Игра остановлена!', 'Вы остановили игру');
  break;
} else {}
*/

/*
else if (forCompare != _get.itemsList900) {
        forCompare = _get.itemsList900;
      }
 */