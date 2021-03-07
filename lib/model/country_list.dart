class CountryListModel {
CountryListModel({
 
  this.list,
});

List<Country> list;

factory CountryListModel.fromJson(List<Map<String, dynamic>> json) => CountryListModel(
list: List<Country>.from(json.map((x) => Country.fromJson(x))),
);

Map<String, dynamic> toJson() => {
  "list": List<dynamic>.from(list.map((x) => x.toJson())),
};
}

class Country {
  Country({
    this.id,
    this.code,
    this.name,
  });

  int id;
  String code;
  String name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };
}