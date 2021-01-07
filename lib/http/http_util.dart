

// 网络请求类
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fy_news/http/http_manager.dart';

class HttpUtil  {

  static String get baseUrl {
    // https://testapi.panasialife.com/
    // https://api.panasialife.com/
    return "http://api1.panasialife.com/";
  }

  static Future<Result> get(String path,{Map<String,dynamic> params}) async {
    Map fullParams = _commentParams(params);
    try {
      Response response = await HttpManager.shared.get(path,baseUrl: baseUrl,params: params);
      print(response.data);
      Result result = Result.fromJson(response.data as Map<String,dynamic>);
      return result;
    }catch(e) {
      print("无网络连接");
      return null;
    }
  }


  /*获取通用参数*/
  static Map<String,dynamic> _commentParams(Map<String,dynamic> params) {
    if(params == null){
      params = Map<String,dynamic>();
    }
    /*curl -X POST  -d 'app_country=KH&app_type=ios&bundle_id=com.awesome.combodialife&display=app&fromid=0&height=736.0&imei=DE4BEA41-0AFB-4B52-9007-A7647D9C8300&lang=zh-cn&mac=00%3A00%3A00%3A00%3A00%3A00&model=iPhone%207%20Plus&net=3&os=2&os_version=12.2&phone_brand=Apple&read_mode=0&screen=828x1472&screen_width=414.0&simulator=0&time_zone=GMT%2B7&userid=a035a1fd1c9f32ae44fdd8caefc38358&utma=c80545574d60102e20f1a518762794fe&version=2.2.17' http://api1.panasialife.com/\?ct=index\&ac=config*/

    params["app_country"] = "KH";
    params["app_type"] = "ios";
    params["bundle_id"] = "com.awesome.combodialife";
    params["display"] = "app";
    params["fromid"] = "0";
    params["height"] = "736.0";
    params["imei"] = "DE4BEA41-0AFB-4B52-9007-A7647D9C8300";
    params["lang"] = "zh-cn";
    params["mac"] = "00%3A00%3A00%3A00%3A00%3A00";
    params["model"] = "iPhone%207%20Plus";
    params["net"] = "3";
    params["os"] = "2";
    params["os_version"] = "12.2";
    params["phone_brand"] = "Apple";
    params["read_mode"] = "0";
    params["screen"] = "828x1472";
    params["simulator"] = "0";
    params["time_zone"] = "GMT%2B7";
    params["userid"] = "a035a1fd1c9f32ae44fdd8caefc38358";
    params["utma"] = "c80545574d60102e20f1a518762794fe";
    params["version"] = "2.2.17";
    return params;
  }
}



class Result {
  int code;
  String msg;
  dynamic data;

  static Result fromJson(Map<String,dynamic> json) {
    Result result = Result();
    result.code = json["code"] as int;
    result.msg = json["msg"] as String;
    result.data = json["data"];
    return result;
  }
}