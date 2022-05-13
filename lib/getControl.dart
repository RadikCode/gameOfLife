import 'package:get/get.dart';
import 'dart:math';

final rnd = Random();

const generationRows = 30;
const generationColumns = 30;

class GetCon extends GetxController {
  var tempListForAddValue = <List<int>>[].obs;

  void addTolistForAddValue(x, y, val) {
    tempListForAddValue[x][y] = val;
    tempListForAddValue.refresh();
  }

  void addTolistForAddValuePaint(x, y, val) {
    itemsList900[x][y] = val;
    itemsList900.refresh();
  }

  //результат расчета предыдущего экрана
  var etalonGAmeWorld = <List<int>>[].obs;

  void createEtalon() {
    
    etalonGAmeWorld.value = List.generate(generationRows,
        (int index) => List.generate(generationColumns, (int index) => 0),
        growable: true);
  }

  var start = false.obs;

  void changeGame() {
    start.value = !start.value;
  }

  void gameStop() {
    start.value = false;
  }

  // основной массив
  var itemsList900 = <List<int>>[].obs; // <List<int>>

  // добавляем расетные данные в основной массив
  void addFromTempList(nowItem900) {


    if (nowItem900.hashCode == tempListForAddValue.hashCode) {
      start.value = false;
    } else {
      itemsList900.clear();
      itemsList900.addAll(tempListForAddValue);

      createTempList();
      
    }
  }

  void createTempList() {
    
    tempListForAddValue.value = List.generate(generationRows,
        (int index) => List.generate(generationColumns, (int index) => 0),
        growable: true);
    tempListForAddValue.refresh();
    
  }

  void addInitemsList() {
    
    generation.value = 0;
    itemsList900.value = List.generate(generationRows,
        (int index) => List.generate(generationColumns, (int index) => 0),
        growable: true);
    itemsList900.refresh();
  }

  void randomInitemsList() {
    generation.value = 0;
    
    itemsList900.value = List.generate(
        generationRows,
        (int index) => List.generate(
            generationColumns, (int index) => rnd.nextBool() == true ? 1 : 0),
        growable: true);
    itemsList900.refresh();
  }

  var generation = 0.obs;

  void addGen() {
    generation.value += 1;
  }

  void clearGen() {
    generation.value = 0;
  }
}
