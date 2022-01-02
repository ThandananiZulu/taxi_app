import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/model/fetchDrivers.dart';
import 'package:taxi_app/model/myData.dart';




class DriverProvider extends ChangeNotifier {
  List<FetchDriver> data;
  var tddate;
  var client = http.Client();
  Future getData(context) async {
    var APIURL = "https://appmadetaxiapp.000webhostapp.com/getDrivers.php";

    var now = new DateTime.now();
    tddate = new DateTime(now.year, now.month,now.day).toString();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var mEmail = sharedPreferences.getString('email');

    Map mapeddate = {
      'mEmail': mEmail,
      'tddate': tddate,
    };

    var data = await http.post(APIURL, body: mapeddate);

    this.data = fetchDriverFromJson(data.body);

    this.notifyListeners();

  }
}

/////////////////////


class ShowDriverProvider extends ChangeNotifier {
  List<FetchDriver> data;
  var tddate;
  var client = http.Client();
  Future showData(context) async {
    var APIURL = "https://appmadetaxiapp.000webhostapp.com/showDrivers.php";

    var now = new DateTime.now();
    tddate = new DateTime(now.year, now.month,now.day).toString();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var drEmail = sharedPreferences.getString('email');

    Map mapeddate = {
      'drEmail': drEmail,
      'tddate': tddate,
    };

    var data = await http.post(APIURL, body: mapeddate);

    this.data = fetchDriverFromJson(data.body);

    this.notifyListeners();

  }
}