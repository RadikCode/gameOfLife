import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getControl.dart';

//final _getG = Get.put(GetCon());
GetCon _getG = Get.find();

class GestureCube extends StatelessWidget {
  const GestureCube(
      {Key? key,
      required this.whCube,
      required this.col,
      required this.indexListX,
      required this.indexListY,
      required this.colAction,
      required this.listItem})
      : super(key: key);
  final double whCube;
  //final double h;
  final Color col;
  final Color colAction;
  final int indexListX;
  final int indexListY;
  final dynamic listItem;

  void changeItem(int x, int y, List<List<int>> list) {
    _getG.itemsList900[x][y] = 1;
    print('Координаты $x, $y');
    //print(list);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: const EdgeInsets.only(top: 1.5, bottom: 1.5, left: 1.5, right: 1.5),
        child: GestureDetector(
          onDoubleTap: () {
            _getG.addTolistForAddValuePaint(indexListX, indexListY, 0);
          },
          onTap: () {
            //changeItem(indexListX, indexListY, listItem);
            _getG.addTolistForAddValuePaint(indexListX, indexListY, 1);
          },
          child: Container(
            color: _getG.itemsList900[indexListX][indexListY] == 0 ? Colors.transparent: Colors.amber,
            width: whCube,
            height: whCube,
          ),
        )));
  }
}

