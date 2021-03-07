
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/verify_account_Info.dart';
import 'package:fy_news/utils/http.dart';

class UserService extends Service {
  /// 验证账号信息
  Future<VerifyAccountInfo> verifyAccount({String moblieCode, String mobile}) async {
    String path = this.baseUrl + "?ct=member&ac=verify_account";
    Map<String, dynamic> params = Map();
    params["mobile"] = mobile;
    params["mobile_code"] = moblieCode;
    return Http.instance.post<VerifyAccountInfo>(path, parameters: params);
  }

  /// 发送注册验证码
  Future<Map> sendVerifyCode({String moblieCode, String mobile}) async {
    String path = this.baseUrl + "?ct=member&ac=send_reg_code";
    Map<String, dynamic> params = Map();
    params["mobile"] = mobile;
    if(moblieCode != null) {
      params["mobile_code"] = moblieCode;
    }
    return Http.instance.post<Map>(path, parameters: params);
  }

  /// 手机号注册
  Future<Map> phoneRegister({String moblieCode, String mobile,String verfiyCode, String password}) async {
    String path = this.baseUrl + "?ct=member&ac=register";
    Map<String, dynamic> params = Map();
    params["mobile"] = mobile;
    params["mobile_code"] = moblieCode;
    params["reg_type"] = 2;
    params["password"] = password;
    params["verify_code"] = verfiyCode;
    ///TODO
    ///        if let countrys = UserManager.shanreInstance().configModel?.selectAreaChannelStr {
    //             params["show_countrys"] = countrys
    //         }
    ///需要带上设置的选择区域的字符串
    return Http.instance.post<Map>(path, parameters: params);
  }
}