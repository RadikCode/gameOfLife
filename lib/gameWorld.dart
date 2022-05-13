import 'package:flutter/material.dart';
import 'gestureCube.dart';
import 'getControl.dart';
import 'package:get/get.dart';

GetCon _get = Get.find();

class GameWorld extends StatelessWidget {
  const GameWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cube = 5.0;
    Color colorCube = Colors.grey;
    Color colorCubeAct = Colors.amber;

    int gridLength = _get.itemsList900.length;
    int x, y = 0;
    return Center(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridLength),
        itemBuilder: (context, index) {
          x = (index / gridLength).floor();
          y = (index % gridLength);
          return GestureCube(
              whCube: cube,
              col: colorCube,
              indexListX: x,
              indexListY: y,
              colAction: colorCubeAct,
              listItem: _get.itemsList900);
        },
        itemCount: gridLength * gridLength,
      ),
    );
  }
}
