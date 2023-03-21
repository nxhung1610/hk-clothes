// *********************************************************************************
// PARABEAC-GENERATED CODE. DO NOT MODIFY.
// 
// FOR MORE INFORMATION ON HOW TO USE PARABEAC, PLEASE VISIT docs.parabeac.com
// *********************************************************************************
    

import 'package:flutter/material.dart';import 'package:theme/theme/theme_text_styles.g.dart';
import 'package:theme/theme/theme_colors.g.dart';

class ThemeTheme {

static const TextTheme textTheme = TextTheme(headline1: ThemeTextStyles.headline1,headline2: ThemeTextStyles.headline2,headline3: ThemeTextStyles.headline3,headline4: ThemeTextStyles.headline4,headline5: ThemeTextStyles.headline5,headline6: ThemeTextStyles.headline6,);

static const ColorScheme light = ColorScheme.light(onPrimary: ThemeColors.lightOnPrimary,primary: ThemeColors.lightPrimary,primaryContainer: ThemeColors.lightPrimaryContainer,secondary: ThemeColors.lightSecondary,onSecondary: ThemeColors.lightOnSecondary,onPrimaryContainer: ThemeColors.lightOnPrimaryContainer,secondaryContainer: ThemeColors.lightSecondaryContainer,onSecondaryContainer: ThemeColors.lightOnSecondaryContainer,shadow: ThemeColors.lightShadow);

static  ThemeData themeDataLight = ThemeData(textTheme: textTheme, colorScheme: light,);

static const ColorScheme dark = ColorScheme.dark(primary: ThemeColors.darkPrimary,onPrimary: ThemeColors.darkOnPrimary,primaryContainer: ThemeColors.darkPrimaryContainer,onPrimaryContainer: ThemeColors.darkOnPrimaryContainer,secondary: ThemeColors.darkSecondary,onSecondary: ThemeColors.darkOnSecondary,secondaryContainer: ThemeColors.darkSecondaryContainer,onSecondaryContainer: ThemeColors.darkOnSecondaryContainer,shadow: ThemeColors.darkShadow);

static  ThemeData themeDataDark = ThemeData(textTheme: textTheme, colorScheme: dark,);
}
