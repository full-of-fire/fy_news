import 'package:fy_news/utils/http_params_util.dart';

class Config {
  Config({
    this.version,
    this.userid,
    this.htmlHeader,
    this.htmlFooter,
    this.isShowScan,
  });

  String version;
  String userid;
  String htmlHeader;
  String htmlFooter;
  int isShowScan;

  static Config fromJson(Map<String, dynamic> json) => Config(
    version: json["version"],
    userid: json["userid"],
    htmlHeader: json["html_header"],
    htmlFooter: json["html_footer"],
    isShowScan: json["is_show_scan"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "userid": userid,
    "html_header": htmlHeader,
    "html_footer": htmlFooter,
    "is_show_scan": isShowScan,
  };
}