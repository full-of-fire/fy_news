class CountryCodeModel {
  CountryCodeModel({
    this.country,
  });

  String country;

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) => CountryCodeModel(
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
  };
}