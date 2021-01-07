import 'package:dio/dio.dart';

class HttpManager {

  // 单例创建相关方法
  factory HttpManager() => _getInstance();
  static HttpManager get shared  => _getInstance();
  static HttpManager _instance;
  static HttpManager _getInstance() {
    if(_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance;
  }

  // 请求对象
  Dio dio;
  HttpManager._internal() {
    //初始化方法
    BaseOptions options = BaseOptions(
      receiveTimeout: 3000,
      connectTimeout: 3000
    );
    dio = Dio(options);
  }


  Future<Response> get(String path,{String baseUrl , Map<String,dynamic> params}) async {
    dio.options.baseUrl = baseUrl;
    Response response = await dio.get(path,queryParameters: params);
    return response;
  }

  Future<Response> post(String path,{String baseUrl, Map<String,dynamic> params}) async {
    dio.options.baseUrl = baseUrl;
    Response response = await dio.post(path,data: params);
    return response;
  }
}
