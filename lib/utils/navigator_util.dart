
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fy_news/const/app_manager.dart';

class NavigatorUtil {
  /// 跳转到指定页面
  static push({@required Widget page}) {
    final BuildContext context = AppManager.shared.globalContext;
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}