import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/AddDrivers.dart';
import 'package:taxi_app/NavBar.dart';
import 'package:taxi_app/dailyLoad.dart';
import 'package:taxi_app/model/myGetDrivers.dart';
import 'package:taxi_app/pages/homePage.dart';
import 'package:taxi_app/provider/myHomePageProvider.dart';
import 'package:taxi_app/signup.dart';
import 'InputDeco_design.dart';
import 'package:http/http.dart' as http ;

import 'model/myGetDateData.dart';

class welcome extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<welcome> {
  bool check = false;

  var toast;
  List <GetDate> datas;
  List <GetDate> dataVal;
  List<GetDrivers> getDrivers;
  var formattedDate;
  int i =0;
  int j = 0;
  bool see =false;
  int num =0;
  int nums =0;
  //String name,email,phone;
  TextEditingController _name = TextEditingController();
 MyHomePage my = MyHomePage();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 15,
                ),

                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () async{

                            await checkDate();
                            var dateval = datas.map((datas) => ('${datas.tDate}')).toList();




                               for(i =0; i < datas.length; i++){
                                 num = num + 1;
                                 if (dateval[i] == formattedDate) {
                                   check = true;
                                   print('Already have load for today $num');
                                   toast = 'Already have a load for today!';
                                   showToast(toast);



                                    i = datas.length;
                                 }else {
                                   print('No Load List yet!');
                                   toast = 'No load list yet!!';
                                   showToast(toast);
 }


                               }


if(check != true){print('No Load List yet!');

Navigator.of(context).push(MaterialPageRoute(builder: (context) => dailyLoad()));

}


                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.blue,width: 2)
                    ),
                    textColor:Colors.white,child: Text("Create Load for today"),

                  ),

                ),

                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () async{

                      await checkDate();
                      var dateval = dataVal.map((dataVal) => ('${dataVal.tDate}')).toList();




                      for(j =0; j < dataVal.length; j++){
                        nums = nums + 1;
                        if (dateval[j] == formattedDate) {
                          see = true;


                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));


                          j = dataVal.length;
                        }


                      }


                      if(see != true){print('No Load List yet!');
                      toast = 'No load list yet!!';
                      showToast(toast);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => welcome()));

                      }

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.blue,width: 2)
                    ),
                    textColor:Colors.white,child: Text("View Load for today"),

                  ),

                ),

//                SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: 200,
//                   height: 50,
//                   child: RaisedButton(
//                     color: Colors.lightBlueAccent,
//                     onPressed: () async{
// //crete boolean to match that this is a weekly list driver
//
//                     },
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(0.0),
//                         side: BorderSide(color: Colors.blue,width: 2)
//                     ),
//                     textColor:Colors.white,child: Text("Create Weekly List"),
//
//                   ),
//
//                 ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: 200,
//                   height: 50,
//                   child: RaisedButton(
//                     color: Colors.lightBlueAccent,
//                     onPressed: () async{
//
//
//                     },
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(0.0),
//                         side: BorderSide(color: Colors.blue,width: 2)
//                     ),
//                     textColor:Colors.white,child: Text("View Weekly Load"),
//
//                   ),
//
//                 ),

                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () async{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDrivers()));

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.blue,width: 2)
                    ),
                    textColor:Colors.white,child: Text("Add New Driver"),

                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void showToast(toast) => Fluttertoast.showToast(msg: toast, fontSize: 18,);



  Future checkDate() async {

    var APIURL = "https://appmadetaxiapp.000webhostapp.com/loadExist.php";
    var now = new DateTime.now();
     formattedDate = new DateTime(now.year, now.month,now.day).toString();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var mEmail = sharedPreferences.getString('email');


    Map mapeddate = {
      'tDate': formattedDate,
      'mEmail': mEmail,


    };
//print("JSON DATA: ${mapeddate}");

    http.Response res = await http.post(APIURL, body: mapeddate);

    this.datas = getDateFromJson(res.body);
    this.dataVal = getDateFromJson(res.body);
  }

  Future dayLoad() async {
    var APIURL = "https://appmadetaxiapp.000webhostapp.com/dailyLoad.php";

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var mEmail = sharedPreferences.getString('email');

    Map mapeddate = {
      'mEmail': mEmail,


    };


    http.Response res = await http.post(APIURL, body: mapeddate);

    this.getDrivers = getDriversFromJson(res.body);

  }


}

