import 'package:flutter/cupertino.dart';

class AppManager  {
  /*全局通用context*/
  BuildContext globalContext;


  static AppManager get shared => _getInstance();
  static AppManager _manager;
  static AppManager _getInstance() {
    if(_manager == null) {
      _manager = AppManager();
    }
    return _manager;
  }
  AppManager() {
    //初始化方法
  }
}