class UpdateVersionModel {
  UpdateVersionModel({
    this.version,
    this.downloadUrl,
    this.updateStatus,
    this.tip,
  });

  String version;
  String downloadUrl;
  int updateStatus;
  String tip;

  factory UpdateVersionModel.fromJson(Map<String, dynamic> json) => UpdateVersionModel(
    version: json["version"],
    downloadUrl: json["download_url"],
    updateStatus: json["update_status"],
    tip: json["tip"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "download_url": downloadUrl,
    "update_status": updateStatus,
    "tip": tip,
  };
}