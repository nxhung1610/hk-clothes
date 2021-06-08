import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: Container(
        color: AppColors.app[400],
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitFadingCube(
              color: AppColors.app,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
