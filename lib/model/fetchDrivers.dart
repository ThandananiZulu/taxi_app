// To parse this JSON data, do
//
//     final fetchDriver = fetchDriverFromJson(jsonString);

import 'dart:convert';

List<FetchDriver> fetchDriverFromJson(String str) => List<FetchDriver>.from(json.decode(str).map((x) => FetchDriver.fromJson(x)));

String fetchDriverToJson(List<FetchDriver> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchDriver {
  FetchDriver({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.drName,
    this.drNumberPlate,
    this.tDate,
    this.loads,
    this.id,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String drName;
  String drNumberPlate;
  String tDate;
  String loads;
  String id;


  factory FetchDriver.fromJson(Map<String, dynamic> json) => FetchDriver(
    the0: json["0"],
    the1: json["1"],
    the2: (json["2"]),
    the3: json["3"],
    the4: json["4"],
    drName: json["drName"],
    drNumberPlate: json["drNumberPlate"],
    tDate: (json["tDate"]),
    loads: json["loads"],
    id: json["id"]
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
  "3": the3,
    "drName": drName,
    "drNumberPlate": drNumberPlate,
    "tDate": tDate,
  "loads": loads,
  };
}
