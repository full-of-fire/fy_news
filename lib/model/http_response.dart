
import 'package:fy_news/model/models.dart';

class HttpResponse<T> extends Object {
  int code;
  String msg;
  T data;

  HttpResponse({this.code,this.msg,this.data});

  factory HttpResponse.fromJson(Map<String, dynamic> json) {
    return HttpResponse<T>(
      code: json['code'] as int,
      msg: json["msg"] as String,
      data: _genericFromJson(json['data'])
    );
  }

  static T _genericFromJson<T>(json) {
    T data;
    if (json != null) {
      final fromJson = (models.firstWhere((i) => i[0] == T,
          orElse: () => [null, null])[1] as Function);
      if (fromJson != null) {
        data = fromJson(json);
      } else {
        data = json as T;
      }
    }
    return data;
  }
}