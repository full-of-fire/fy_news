
import 'package:flutter/material.dart';
import 'package:fy_news/http/Api.dart';
import 'package:fy_news/model/config.dart';
import 'package:fy_news/model/country_code.dart';
import 'package:fy_news/model/country_list.dart';
import 'package:fy_news/model/news_config.dart';
import 'package:fy_news/model/update_version.dart';
import 'package:fy_news/utils/http.dart';

class IndexService extends Service {
  IndexService(){
    this.baseUrl = this.baseUrl;
  }

  /// 获取配置
  Future<Config> getConfig() async {
    String path = this.baseUrl + "?ct=index&ac=init";
    return Http.instance.get<Config>(path);
  }

  /// 获取当前国家码
  Future<CountryCodeModel> getCurrentCountry({double lat, double lng}) async {
    String path = this.baseUrl + "?ct=index&ac=get_country";
    Map<String,dynamic> params = Map();
    params["lat"] = lat;
    params["lng"] = lng;
    return Http.instance.get<CountryCodeModel>(path,parameters: params);
  }

  /// 检查是否可更新
  Future<UpdateVersionModel> checkAppIsUpdate({String type, String version}) async {
    String path = this.baseUrl + "?ct=index&ac=update_app";
    Map<String,dynamic> params = Map();
    /// iOS
    params["type"] = type;
    params["version"] = version;
    return Http.instance.get<UpdateVersionModel>(path,parameters: params);
  }

  /// 新闻首页配置
  Future<NewsConfig> mainNewsConfig({String country}) async {
    String path = this.baseUrl + "?ct=index&ac=news_index_config";
    Map<String,dynamic> params = Map();
    /// iOS
    params["country"] = country;
    return Http.instance.post<NewsConfig>(path,parameters: params);
  }

  /// 获取国家列表
  Future<CountryListModel> getCountryList() async {
    String path = this.baseUrl + "?ct=common&ac=country_list";
    return Http.instance.post<CountryListModel>(path);
  }


}