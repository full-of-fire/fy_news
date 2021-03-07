// 网络请求返回值最外层封装
// ** 泛型类型一定要在 models 中添加映射关系才能解析，因为 Dart 禁止了反射，不能动态创建对象 **
import 'package:fy_news/model/config.dart';
import 'package:fy_news/model/country_code.dart';
import 'package:fy_news/model/news_config.dart';
import 'package:fy_news/model/update_version.dart';
import 'package:fy_news/model/userId.dart';
import 'package:fy_news/model/verify_account_Info.dart';

import 'country_list.dart';

final models = [
  //index
  [Config, (json) => Config.fromJson(json)],
  [CountryCodeModel,(json) => CountryCodeModel.fromJson(json)],
  [UpdateVersionModel,(json) => UpdateVersionModel.fromJson(json)],
  [NewsConfig,(json) => NewsConfig.fromJson(json)],
  [CountryListModel,(json) => CountryListModel.fromJson(json)],

  //同城

  //圈子

  //资讯

  //泛亚帮

  //我的
  [VerifyAccountInfo,(json) => VerifyAccountInfo.fromJson(json)],
  [UserIdModel,(json) => UserIdModel.fromJson(json)]

];