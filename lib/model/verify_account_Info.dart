
class VerifyAccountInfo  {

  VerifyAccountInfo({
    this.mobile_code,
    this.mobile,
    this.is_mobile,
    this.is_reg
  });

  /// 手机区号
  String mobile_code;
  /// 手机号
  String mobile;
  /// 是否手机号码 0=不是，1=是
  int is_mobile;
  /// 是否注册 0=未注册，1=已注册
  int is_reg;

  factory VerifyAccountInfo.fromJson(Map<String, dynamic> json) => VerifyAccountInfo(
    mobile_code: json["mobile_code"],
    mobile: json["moblie"],
    is_mobile: json["is_mobile"],
    is_reg: json["is_reg"]
  );

  Map<String, dynamic> toJson() => {
    "mobile_code": mobile_code,
    "mobile":mobile,
    "is_mobile":is_mobile,
    "is_reg":is_reg
  };
}