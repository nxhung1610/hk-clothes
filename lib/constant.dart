import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final background = Image.asset(
  "assets/login/background.jpg",
);

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class
  static const MaterialColor app = MaterialColor(0xff00E19B, <int, Color>{
    50: const Color(0xff00E19B),
    100: const Color(0xffd6544b),
    200: const Color(0xffffffff),
    300: const Color(0xff00E19B),
    400: const Color(0xff00E19B),
    500: const Color(0xff00E19B),
    600: const Color(0xff00E19B),
    700: const Color(0xff00E19B),
    800: const Color(0xff00E19B),
    900: const Color(0xff00E19B)
  });
}
