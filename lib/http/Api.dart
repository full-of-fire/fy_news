
import 'package:fy_news/http/user_service.dart';

enum ServerEnv { development, staging, production }
//定义开发环境
ServerEnv env = ServerEnv.development;
class Api  {
  static String get baseUrl  {
    switch(env){
      case ServerEnv.development:
        return "http://api1.panasialife.com"; //内网测试
      case ServerEnv.staging:
        return "https://testapi.panasialife.com"; //外网测试
      case ServerEnv.production:
      default:
        return "https://api.panasialife.com";  //生成环境
    }
  }

  static final user = IndexService(baseUrl);

}

class Service {
  String baseUrl;
  Service(this.baseUrl);
}


