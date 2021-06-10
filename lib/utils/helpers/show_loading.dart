import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';

showLoading() {
  Get.defaultDialog(
    title: "Loading...",
    content: SpinKitFadingCube(
      color: AppColors.app[400],
      size: 30.0,
    ),
    barrierDismissible: false,
  );
}

dismissLoadingWidget() {
  Get.back();
}
