class NewsConfig {
  NewsConfig({
    this.version,
    this.startUpTime,
    this.imgExpireTime,
    this.videoLimitTime,
    this.userid,
    this.newsAdLocation,
    this.memberInfo,
    this.areaList,
    this.selectNewsChannel,
    this.newsChannelList,
    this.selectVideoChannel,
    this.videoChannelList,
  });

  String version;
  int startUpTime;
  int imgExpireTime;
  int videoLimitTime;
  String userid;
  int newsAdLocation;
  MemberInfo memberInfo;
  List<AreaModel> areaList;
  String selectNewsChannel;
  List<ChannelModel> newsChannelList;
  String selectVideoChannel;
  List<ChannelModel> videoChannelList;

  factory NewsConfig.fromJson(Map<String, dynamic> json) => NewsConfig(
    version: json["version"],
    startUpTime: json["start_up_time"],
    imgExpireTime: json["img_expire_time"],
    videoLimitTime: json["video_limit_time"],
    userid: json["userid"],
    newsAdLocation: json["news_ad_location"],
    memberInfo: MemberInfo.fromJson(json["member_info"]),
    areaList: List<AreaModel>.from(json["area_list"].map((x) => AreaModel.fromJson(x))),
    selectNewsChannel: json["select_news_channel"],
    newsChannelList: List<ChannelModel>.from(json["news_channel_list"].map((x) => ChannelModel.fromJson(x))),
    selectVideoChannel: json["select_video_channel"],
    videoChannelList: List<ChannelModel>.from(json["video_channel_list"].map((x) => ChannelModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "start_up_time": startUpTime,
    "img_expire_time": imgExpireTime,
    "video_limit_time": videoLimitTime,
    "userid": userid,
    "news_ad_location": newsAdLocation,
    "member_info": memberInfo.toJson(),
    "area_list": List<dynamic>.from(areaList.map((x) => x.toJson())),
    "select_news_channel": selectNewsChannel,
    "news_channel_list": List<dynamic>.from(newsChannelList.map((x) => x.toJson())),
    "select_video_channel": selectVideoChannel,
    "video_channel_list": List<dynamic>.from(videoChannelList.map((x) => x.toJson())),
  };
}

class AreaModel {
  AreaModel({
    this.isFix,
    this.isDefault,
    this.name,
    this.sort,
    this.enShortName,
    this.weatherIcon,
    this.weatherDesc,
  });

  int isFix;
  int isDefault;
  String name;
  int sort;
  String enShortName;
  String weatherIcon;
  String weatherDesc;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    isFix: json["is_fix"],
    isDefault: json["is_default"],
    name: json["name"],
    sort: json["sort"],
    enShortName: json["en_short_name"],
    weatherIcon: json["weather_icon"],
    weatherDesc: json["weather_desc"],
  );

  Map<String, dynamic> toJson() => {
    "is_fix": isFix,
    "is_default": isDefault,
    "name": name,
    "sort": sort,
    "en_short_name": enShortName,
    "weather_icon": weatherIcon,
    "weather_desc": weatherDesc,
  };
}

class MemberInfo {
  MemberInfo();

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
  );

  Map<String, dynamic> toJson() => {
  };
}

class ChannelModel {
  ChannelModel({
    this.id,
    this.pid,
    this.level,
    this.cate,
    this.refreshCate,
    this.name,
    this.levelId,
    this.isFix,
    this.isDefault,
    this.isTrans,
    this.sort,
    this.isRecomChannel,
  });

  int id;
  int pid;
  int level;
  int cate;
  int refreshCate;
  String name;
  int levelId;
  int isFix;
  int isDefault;
  int isTrans;
  int sort;
  int isRecomChannel;

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
    id: json["id"],
    pid: json["pid"],
    level: json["level"],
    cate: json["cate"],
    refreshCate: json["refresh_cate"],
    name: json["name"],
    levelId: json["level_id"],
    isFix: json["is_fix"],
    isDefault: json["is_default"],
    isTrans: json["is_trans"],
    sort: json["sort"],
    isRecomChannel: json["is_recom_channel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pid": pid,
    "level": level,
    "cate": cate,
    "refresh_cate": refreshCate,
    "name": name,
    "level_id": levelId,
    "is_fix": isFix,
    "is_default": isDefault,
    "is_trans": isTrans,
    "sort": sort,
    "is_recom_channel": isRecomChannel,
  };
}