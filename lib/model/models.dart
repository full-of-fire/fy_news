// 网络请求返回值最外层封装
// ** 泛型类型一定要在 models 中添加映射关系才能解析，因为 Dart 禁止了反射，不能动态创建对象 **
import 'package:fy_news/model/config.dart';

final models = [
  [Config, (json) => Config.fromJson(json)],
  //同城

  //圈子

  //资讯

  //泛亚帮

  //我的

];