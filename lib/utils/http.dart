import 'dart:developer';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fy_news/utils/http_params_util.dart';
import 'curl_log.dart';
import 'package:fy_news/model/http_response.dart';

var dio;

class Http {
  // 工厂模式
  static Http get instance => _getInstance();

  static Http _http;

  static Http _getInstance() {
    if (_http == null) {
      _http = Http();
    }
    return _http;
  }

  String token = "";
  int mchId = 1;
  int shopId = 3;

  Dio dio;

  Http() {
    BaseOptions options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    );
    dio = Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      dio.lock();
      options.headers["token"] = token;
      options.contentType = "application/x-www-form-urlencoded";
      dio.unlock();
      log("${options.method} ${options.uri.toString()}");
      if (options.data != null) {
        log("data = ${options.data}");
      }
      return options;
    }, onResponse: (Response response) {
      try {
        inspect(response.data["data"] ?? response.data);
      } catch (e) {}
    }, onError: (DioError error) {
      log("message = ${error.message}");
    }));
    if (kDebugMode) {
      dio.interceptors.add(LoggingInterceptor());
    }
  }

  Future<T> uploadImage<T>(
    String url,
    List<int> bytes,
    String filename,
    String guid,
    int chunk,
    int chunks, {
    String originalFileName,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    var postData = FormData.fromMap({
      'gid': guid,
      'chunk': 0,
      'chunks': 1,
      "avatar": MultipartFile.fromBytes(bytes, filename: filename)
    });
    var option = Options(
        method: "POST",
        contentType: "multipart/form-data"); //上传文件的content-type 表单
    try {
      Response response = await dio.post(
        url,
        data: postData,
        options: option,
        onSendProgress: (int sent, int total) {
          print("上传进度：" +
              NumUtil.getNumByValueDouble(sent / total * 100, 2)
                  .toStringAsFixed(2) +
              "%"); //取精度，如：56.45%
        },
      );
      if (response.statusCode < 400) {
        final entity = HttpResponse<T>.fromJson(response.data);
        if (entity.code == 0) {
          return entity.data;
        } else {
          throw APIError(entity.code, response.data["msg"]);
        }
      } else {
        throw APIError(-1, "服务异常，请重试");
      }
    } on DioError catch (e) {
      throw APIError(0, e.message);
    } on APIError catch (e) {
      throw e;
    }
  }

  Future<T> get<T>(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    options = _checkOptions("GET", options);
    return await request(url, parameters: parameters, options: options);
  }

  Future<T> post<T>(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    options = _checkOptions("POST", options);
    return await request(url, parameters: parameters, options: options);
  }

  Future<T> put<T>(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    options = _checkOptions("PUT", options);
    return await request(url, parameters: parameters, options: options);
  }

  Future<T> delete<T>(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    options = _checkOptions("DELETE", options);
    return await request(url, parameters: parameters, options: options);
  }

  Future<T> request<T>(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    parameters?.removeWhere((key, value) => value == null);
    parameters = await HttpParamsUtil.commentParams(parameters);
    try {
      Response response = await dio.request(
        url,
        data: options.method != "GET" ? parameters : null,
        queryParameters: options.method == "GET" ? parameters : null,
        options: options,
      );
      if (response.statusCode < 400) {
        if (!(response.data is Map)) {
          throw "服务异常，请重试";
        }
        final entity = HttpResponse<T>.fromJson(response.data);
        if (entity.code == 0) {
          return entity.data;
        } else {
          //TODO:配置Telegram机器人
          // if (entity.code == -1 && !kDebugMode) {
          //   TelegramBotUtil.sendMessage(
          //       ErrorLogFactory.requestError(url, entity.message, response));
          // }
          throw APIError(entity.code, response.data["msg"]);
        }
      } else {
        throw APIError(-1, "服务异常，请重试");
      }
    } on DioError catch (e) {
      throw APIError(0, "网络错误，请重试");
    } on APIError catch (e) {
      throw e;
    }
    // catch (e) {
    //   // debugger(message: "JSON 解析错误");
    //   throw APIError(0, e.toString());
    // }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }
}

class APIError implements Exception {
  int code;
  String message;
  APIError(this.code, this.message);
  toString() => message ?? "网络错误，请重试";
}
