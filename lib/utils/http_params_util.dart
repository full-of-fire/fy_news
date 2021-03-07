import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reachability/flutter_reachability.dart';
import 'package:fy_news/Global/app_manager.dart';
import 'package:fy_news/const/localizations/app_local_manager.dart';
import 'package:fy_news/utils/store.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class HttpParamsUtil  {
  
  // 获取设备新的插件
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static final DateTime _currentDate = DateTime.now();
  // 全局context
  static BuildContext _context;
  // 配置全局上下文
  static configGlobalContext(BuildContext context) {
    HttpParamsUtil._context = context;
  }

  /*获取通用参数*/
  static Future<Map<String,dynamic>> commentParams(Map<String,dynamic> params) async {
    if(params == null){
      params = Map<String,dynamic>();
    }
    /*curl -X POST  -d 'app_country=KH&app_type=ios&bundle_id=com.awesome.combodialife&display=app&fromid=0&height=736.0&imei=DE4BEA41-0AFB-4B52-9007-A7647D9C8300&lang=zh-cn&mac=00%3A00%3A00%3A00%3A00%3A00&model=iPhone%207%20Plus&net=3&os=2&os_version=12.2&phone_brand=Apple&read_mode=0&screen=828x1472&screen_width=414.0&simulator=0&time_zone=GMT%2B7&userid=a035a1fd1c9f32ae44fdd8caefc38358&utma=c80545574d60102e20f1a518762794fe&version=2.2.17' http://api1.panasialife.com/\?ct=index\&ac=config*/
    
    Map<String,dynamic> deviceInfo = Map<String,dynamic>();
    PackageInfo info = await PackageInfo.fromPlatform();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      deviceInfo["bundle_id"] = info.packageName;
      deviceInfo["imei"] = androidDeviceInfo.androidId;
      deviceInfo["model"] = androidDeviceInfo.model;
      deviceInfo["os"] = "1"; // 安卓1 iOS 2
      deviceInfo["os_version"] = androidDeviceInfo.version.release;
      deviceInfo["phone_brand"] = androidDeviceInfo.brand;
      deviceInfo["simulator"] = androidDeviceInfo.isPhysicalDevice ? "1" : "0";
    }else if( Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      deviceInfo["bundle_id"] = info.packageName;
      deviceInfo["imei"] = iosDeviceInfo.identifierForVendor;
      deviceInfo["model"] = iosDeviceInfo.model;
      deviceInfo["os"] = "2"; // 安卓1 iOS 2
      deviceInfo["os_version"] = iosDeviceInfo.systemVersion;
      deviceInfo["phone_brand"] = "Apple";
      deviceInfo["simulator"] = iosDeviceInfo.isPhysicalDevice ? "1" : "0";
    }
    params["app_type"] = Platform.operatingSystem;
    params["bundle_id"] = deviceInfo["bundle_id"];
    params["imei"] = deviceInfo["imei"];
    params["model"] = deviceInfo["model"];
    params["os"] = deviceInfo["os"];
    params["os_version"] = deviceInfo["os_version"];
    params["phone_brand"] = deviceInfo["phone_brand"];
    params["simulator"] = deviceInfo["simulator"];
    params["version"] = info.version;
    params["display"] = "app";

    //设备高度
    if(_context != null) {
      MediaQueryData data = MediaQuery.of(_context);
      params["height"] = "${data.size.height}";
      params["screen"] = "${data.size.width*data.devicePixelRatio}x${data.size.height*data.devicePixelRatio}";
    }
    //当前时区
    params["time_zone"] = _currentDate.timeZoneName;
    //TODO
    params["fromid"] = "0";  //渠道统计id
    params["read_mode"] = "0";
    params["app_country"] = "KH";
    if(AppManager.shared.userId != null) {
      print("我现在有userID了");
      params["userid"] = AppManager.shared.userId;
    }else {
      print("暂无用户id");
    }
    // uuid 32位md5
    String utma = await _getUtma();
    print("utma == {$utma}");
    params["utma"] = utma;
    //监听网络状况
    params["net"] = await _currentNet();
    params["lang"] = _convertLanguageCode(AppLocalManager.currentLanguage.languageCode);
    params["mac"] = "00%3A00%3A00%3A00%3A00%3A00";
    return params;
  }

  /// 获取语言标识
  static String _convertLanguageCode(String code) {
    if (code == "zh") {
      return "zh-cn";
    }else if ( code == "km") {
      return "km-KH";
    }else if (code == "en") {
      return "en";
    }
  }

  static Future<String> _getUtma() async {
    final String uuid_key = "uuid_key";
    String uuid = await Store.read(uuid_key);
    if(uuid == null) {
      uuid = Uuid().v1();
      Store.save(uuid_key, uuid);
    }
    var uuid_bytes =  utf8.encode(uuid);
    return md5.convert(uuid_bytes).toString();
  }

  static Future<String> _currentNet() async {
    if(Platform.isAndroid) {
      await Permission.phone.request();
    }
    NetworkStatus networkStatus = await FlutterReachbility().currentNetworkStatus();
    switch(networkStatus) {
      case NetworkStatus.unreachable:
        return "0";
      case NetworkStatus.mobile2G:
        return "1";
      case NetworkStatus.moblie3G:
        return "2";
      case NetworkStatus.wifi:
        return "3";
      case NetworkStatus.moblie4G:
        return "4";
      case NetworkStatus.moblie5G:
        return "5";
      case NetworkStatus.otherMoblie:
        return "6";
    }
  }
}
