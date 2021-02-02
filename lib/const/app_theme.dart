import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:flutter/material.dart';

getTheme({bool isDarkMode = false}) => ThemeData(
  scaffoldBackgroundColor: Color(0xFFf6f7f8), // Scaffold 背景色
  backgroundColor: Color(0xFFf6f7f8), // 背景色
  primaryColor: Color(0xFF4e6da4), // 主题色
  accentColor: Color(0xFF4e6da4), // 次主题色
  visualDensity: VisualDensity.adaptivePlatformDensity,
  cardTheme: CardTheme(
    // 卡片
    margin: EdgeInsets.all(4.0),
    elevation: 0.0,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
  ),
  appBarTheme: AppBarTheme(
    // 导航条
    color: Color(0xFFFFFFFF),
    brightness: Brightness.light,
    elevation: 0.5,
    iconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
    actionsIconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
    textTheme: TextTheme(headline6: TextStyle(fontSize: 18, color: Color(0xff333333), fontWeight: FontWeight.w500)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    isDense: true,
  ),
  buttonTheme: ButtonThemeData(
    height: 44.0,
    buttonColor: Color(0xFF268FFC),
    textTheme: ButtonTextTheme.primary,
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
    },
  ),
);
