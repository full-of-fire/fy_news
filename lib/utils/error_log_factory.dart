import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

class ErrorLogFactory {
  static PackageInfo _info;
  static PackageInfo get info {
    if (_info == null) {
      PackageInfo.fromPlatform().then((value) => _info = value);
    }
    return _info;
  }

  static String requestError(String url, String msg, Response response) {
    String error = "";
    String device = "[${info.appName} ${info.packageName}]";
    String debugStr = kDebugMode ? "debug" : "release";
    error += "包名 : $device\n";
    error += "OS系统 : $defaultTargetPlatform\n";
    error += "版本号 : ${info.version}+${info.buildNumber}\n";
    error += "异常类型 : 请求错误code=-1\n";
    error += "编译类型 : $debugStr\n";
    error += "详细信息 : $msg\n";
    error += "请求的接口 : $url\n";
//    error += "用户ID : $id\n";
//    error += "错误类型 : ${'JsonParseException'}\n";
    error += "----------------------------------\n";
    error += "${getCurl(response?.request)}";
    return error;
  }

  static String requestErrorOptions(String url, String msg, RequestOptions response) {
    String error = "";
    String device = "[${info.appName} ${info.packageName}]";
    String debugStr = kDebugMode ? "debug" : "release";
    error += "包名 : $device\n";
    error += "OS系统 : $defaultTargetPlatform\n";
    error += "版本号 : ${info.version}+${info.buildNumber}\n";
    error += "异常类型 : 接口数据乱码\n";
    error += "编译类型 : $debugStr\n";
    error += "详细信息 : $msg\n";
    error += "请求的接口 : $url\n";
//    error += "用户ID : $id\n";
//    error += "错误类型 : ${'JsonParseException'}\n";
    error += "----------------------------------\n";
    error += "${getCurl(response)}";
    return error;
  }

  static String getCurl(RequestOptions options) {
    if (null == options) {
      return "DioError,curl无法抓取。";
    }
    Map params = Map();
    if (options.data is FormData) {
      params.addEntries((options.data as FormData).fields);
    }

    String curl = "curl -X ";
    String method = options.method;
    String url = options.baseUrl + options.path;
    String query = Transformer.urlEncodeMap(options.queryParameters.isEmpty
        ? options.data is FormData
            ? params
            : options.data
        : options.queryParameters);

    if (method.toLowerCase() == "get") {
      if (query.isNotEmpty) {
        url += (url.contains("?") ? "&" : "?") + query;
      }

      return (curl + method + " " + "'" + url + "'");
    } else {
      String header =
          " -H " + "\"Content-Type:application/x-www-form-urlencoded\"" + " -H " + "\"Accept:application/json\"";
      options.headers.forEach((key, value) {
        header += " -H " + "\"$key:$value\" ";
      });
      header += " -d '" + query + "'";
      return (curl + method + " " + header + " " + "\"" + url + "\"");
    }
  }
}
