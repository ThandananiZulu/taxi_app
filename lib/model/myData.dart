// To parse this JSON data, do
//
//     final employees = employeesFromMap(jsonString);

import 'dart:convert';

List<Employees> employeesFromMap(String str) => List<Employees>.from(json.decode(str).map((x) => Employees.fromMap(x)));

String employeesToMap(List<Employees> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Employees {
  Employees({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.increment,
    this.fullname,
    this.numberPlate,
    this.date,
    this.load,
  });

  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String increment;
  String fullname;
  String numberPlate;
  String date;
  String load;

  factory Employees.fromMap(Map<String, dynamic> json) => Employees(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    increment: json["increment"],
    fullname: json["fullname"],
    numberPlate: json["NumberPlate"],
    date: json["date"],
    load: json["load"],
  );

  Map<String, dynamic> toMap() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "increment": increment,
    "fullname": fullname,
    "NumberPlate": numberPlate,
    "date": date,
    "load": load,
  };
}
