import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:taxi_app/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/model/myGetDrivers.dart';

import 'package:http/http.dart' as http ;

class dailyLoad extends StatefulWidget {
  dailyLoad({Key key}) : super(key: key);

  @override
  _dailyState createState() => _dailyState();


}

class _dailyState extends State<dailyLoad> {
  bool noList = true;
  List<GetDrivers> snapshot;
  var formattedDate;


  void showToast(toast) => Fluttertoast.showToast(msg: toast, fontSize: 18,);


  Future<List<GetDrivers>> _daysLoad() async {
    var APIURL = "https://appmadetaxiapp.000webhostapp.com/dailyLoad.php";
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var mEmail = sharedPreferences.getString('email');


    Map mapeddate = {
      'mEmail': mEmail,
    };

    var data = await http.post(APIURL, body: mapeddate);
    var jsonData = json.decode(data.body);

    List<GetDrivers> users = [];

    users = getDriversFromJson(data.body);
    print(users.length);
    print('usrs r $users');
    if (users.length == 0) {
      print('Empty, Please add drivers first!');
      var toast = "Empty, please add drivers first!";
      await showToast(toast);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => welcome()));
    }
    return users;
  }

  @override
  void initState() {
    super.initState();
    initializeSnapshot();
  }

  Future initializeSnapshot() async {
    final list = await _daysLoad();
    setState(() => snapshot = list);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Create List for Today'),

        centerTitle: true,
      ),

      body: Container(

        child: Column(

          children: [


            snapshot == null
                ? Center(child: CircularProgressIndicator())
                : ReorderableListView.builder(itemCount: snapshot.length,
              shrinkWrap: true,
              onReorder: (oldIndex, newIndex) async {
                await setState(() {
                  final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

                  var items = snapshot;
                  final item = items.removeAt(oldIndex);
                  items.insert(index, item);
                });
              },
              itemBuilder: (context, index) {
                final user = snapshot[index];
                return ListTile(
                  key: ValueKey(user),
                  title: Text(user.fullname + ''),
                  subtitle: Text(user.numberPlate),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () => remove(index),
                  ),
                );


              },


            ),


            snapshot == null

                ? Center(child: Text('Loading...'))
                : SizedBox(
              width: 200,
              height: 50,
              child: RaisedButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  var drivers = snapshot.map((data) => ('${data.drEmail}'))
                      .toString();
                  print(drivers);

                  await insertDailyList(drivers);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: Colors.blue, width: 2)
                ),
                textColor: Colors.white,
                child: Text("Create List"),

              ),

            ),
          ],


        ),

      ),
floatingActionButton: FloatingActionButton(
  child: Icon(Icons.refresh),
  onPressed: refreshList,
),
    );
  }
  void remove(int index) => setState(() {snapshot.removeAt(index);

  });

  void refreshList() {

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => dailyLoad()));

  }
  Future insertDailyList(drivers) async {
    var APIURL = "https://appmadetaxiapp.000webhostapp.com/addLoad.php";
    var now = new DateTime.now();
    formattedDate = new DateTime(now.year, now.month, now.day).toString();
    var list = snapshot.map((data) => ('${data.drEmail}')).toList();
    String newLoad;
    newLoad = list.join(",");
    Map mapeddate = {
      'newLoad': newLoad,

      'dateVal': formattedDate,

    };


    print("JSON DATA: ${mapeddate}");

    http.Response res = await http.post(APIURL, body: mapeddate);


    var data = json.decode(res.body);
    print(data);
    if (json.decode(res.body) == "Registration success") {
      print('Load added successfully');
      var toast = "Load added successfully";
      showToast(toast);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => welcome()));

    } else {
      if (jsonDecode(res.body) == "error in Registration") {
        print('error');
        var toast = "Error in adding new load";
        showToast(toast);
        // _showToast(context);

      }
      print('Succesfully loaded');
    }


    Widget getWidget() {
      if (noList == false) {
        print('empty, no list');
      }
    }
  }


}
