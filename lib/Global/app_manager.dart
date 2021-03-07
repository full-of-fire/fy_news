import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/userId.dart';
import 'package:fy_news/utils/store.dart';
import 'package:uuid/uuid.dart';

class AppManager  {

  static AppManager get shared => _getInstance();
  static AppManager _manager;
  static AppManager _getInstance() {
    if(_manager == null) {
      _manager = AppManager._init();
    }
    return _manager;
  }
  AppManager._init() {
    //初始化方法
    initUserId();
  }


  /*全局通用context*/
  BuildContext globalContext;
  /*pubic userid*/
  String get userId => _userId;
  /*全局token*/
  String token;
  /*标识是否已登录*/
  bool get isLogin => token != null;
  /*private用户id*/
  String _userId;

  /// 初始化用户id
  Future<String>  initUserId() async {
    if(_userId != null) {
      return _userId;
    }
    //1.首先从本地获取
    String userId = await Store.read("user_id_key");
    if (userId != null) {
      _userId = userId;
      return _userId;
    }

    //2.请求获取userid，如果失败就uuid然后再md5
    try {
      UserIdModel idModel = await Api.common.getUserId();
      print("网络请的userid === ${idModel.userid}");
      _userId = idModel.userid;
      //保存到本地
      Store.save("user_id_key", _userId);
      return _userId;
    }catch(e) {
      String local_Uuid = Uuid().v1();
      String local_userId = md5.convert(utf8.encode(local_Uuid)).toString();
      _userId = local_userId;
      //保存到本地
      Store.save("user_id_key", _userId);
      return _userId;
    }
  }

}