// To parse this JSON data, do
//
//     final getDate = getDateFromJson(jsonString);

import 'dart:convert';

List<GetDate> getDateFromJson(String str) => List<GetDate>.from(json.decode(str).map((x) => GetDate.fromJson(x)));

String getDateToJson(List<GetDate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDate {
  GetDate({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.id,
    this.drName,
    this.drNumberPlate,
    this.mName,
    this.tDate,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  DateTime the4;
  String id;
  String drName;
  String drNumberPlate;
  String mName;
  DateTime tDate;

  factory GetDate.fromJson(Map<String, dynamic> json) => GetDate(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: DateTime.parse(json["4"]),
    id: json["id"],
    drName: json["drName"],
    drNumberPlate: json["drNumberPlate"],
    mName: json["mName"],
    tDate: DateTime.parse(json["tDate"]),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": "${the4.year.toString().padLeft(4, '0')}-${the4.month.toString().padLeft(2, '0')}-${the4.day.toString().padLeft(2, '0')}",
    "id": id,
    "drName": drName,
    "drNumberPlate": drNumberPlate,
    "mName": mName,
    "tDate": "${tDate.year.toString().padLeft(4, '0')}-${tDate.month.toString().padLeft(2, '0')}-${tDate.day.toString().padLeft(2, '0')}",
  };
}
