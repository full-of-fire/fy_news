import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/userId.dart';
import 'package:fy_news/utils/http.dart';

class CommonService extends Service {
  CommonService() {
    this.baseUrl = this.baseUrl + "?ct=common&ac=";
  }

  Future<UserIdModel> getUserId() {
    var path = this.baseUrl + "get_userid";
   return Http.instance.post<UserIdModel>(path);
  }
}