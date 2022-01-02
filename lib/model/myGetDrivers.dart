// To parse this JSON data, do
//
//     final getDrivers = getDriversFromJson(jsonString);

import 'dart:convert';

List<GetDrivers> getDriversFromJson(String str) => List<GetDrivers>.from(json.decode(str).map((x) => GetDrivers.fromJson(x)));

String getDriversToJson(List<GetDrivers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDrivers {
  GetDrivers({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.id,
    this.fullname,
    this.drEmail,
    this.cDate,
    this.numberPlate,
    this.mEmail,
  });

  String the0;
  String the1;
  String the2;
  DateTime the3;
  String the4;
  String the5;
  String id;
  String fullname;
  String drEmail;
  DateTime cDate;
  String numberPlate;
  String mEmail;

  factory GetDrivers.fromJson(Map<String, dynamic> json) => GetDrivers(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: DateTime.parse(json["3"]),
    the4: json["4"],
    the5: json["5"],
    id: json["id"],
    fullname: json["fullname"],
    drEmail: json["drEmail"],
    cDate: DateTime.parse(json["c_date"]),
    numberPlate: json["number_plate"],
    mEmail: json["mEmail"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3.toIso8601String(),
    "4": the4,
    "5": the5,
    "id": id,
    "fullname": fullname,
    "drEmail": drEmail,
    "c_date": cDate.toIso8601String(),
    "number_plate": numberPlate,
    "mEmail": mEmail,
  };
}
