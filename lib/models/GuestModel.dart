// To parse this JSON data, do
//
//     final guestModel = guestModelFromJson(jsonString);

import 'dart:convert';

List<GuestModel> guestModelFromJson(String str) =>
    List<GuestModel>.from(json.decode(str).map((x) => GuestModel.fromJson(x)));

String guestModelToJson(List<GuestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuestModel {
  GuestModel({
    this.id,
    this.name,
    this.birthdate,
  });

  int id;
  String name;
  DateTime birthdate;

  factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "birthdate": birthdate == null
            ? null
            : "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
      };
}
