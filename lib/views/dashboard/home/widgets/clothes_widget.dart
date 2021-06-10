import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/assets.dart';

class ClothesItem extends StatelessWidget {
  final size;
  final clothes;
  final function;
  const ClothesItem(
      {Key key, @required this.size, @required this.clothes, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.25,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: categoryHoodie,
                    color: Colors.grey[Random().nextInt(9) * 100],
                  ),
                ),
                SizedBox(
                  height: size * 0.05,
                ),
                Text(
                  "23\$",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.app[500].withOpacity(0.2),
                splashFactory: InkRipple.splashFactory,
                onTap: () => function,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
