
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/config.dart';
import 'package:fy_news/utils/http.dart';

class IndexService extends Service {
  IndexService(String baseUrl) : super(baseUrl + "?ct=index\&ac=config");
  Future<Config> getConfig() async {
    return Http.instance.get<Config>(baseUrl);
  }
}