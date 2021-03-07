class UserIdModel {
  UserIdModel({
    this.userid,
  });

  String userid;

  factory UserIdModel.fromJson(Map<String, dynamic> json) => UserIdModel(
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
  };
}