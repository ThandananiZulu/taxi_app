import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/AddDrivers.dart';
import 'package:taxi_app/NavBar.dart';
import 'package:taxi_app/dailyLoad.dart';
import 'package:taxi_app/model/myGetDrivers.dart';
import 'package:taxi_app/pages/homePage.dart';
import 'package:taxi_app/provider/myHomePageProvider.dart';
import 'package:taxi_app/second_page.dart';
import 'package:taxi_app/signup.dart';
import 'InputDeco_design.dart';
import 'package:http/http.dart' as http ;

import 'model/myGetDateData.dart';

class driverWelcome extends StatefulWidget {
  @override
  _driverWelcomePageState createState() => _driverWelcomePageState();
}

class _driverWelcomePageState extends State<driverWelcome> {
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


                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage(payload: "Not Applicable")));


                          j = dataVal.length;
                        }


                      }


                      if(see != true){print('No Load List yet!');
                      toast = 'No load list yet!!';
                      showToast(toast);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => driverWelcome()));

                      }

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.blue,width: 2)
                    ),
                    textColor:Colors.white,child: Text("View Load for today"),

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

    var APIURL = "https://appmadetaxiapp.000webhostapp.com/loadsExist.php";
    var now = new DateTime.now();
    formattedDate = new DateTime(now.year, now.month,now.day).toString();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var drEmail = sharedPreferences.getString('email');


    Map mapeddate = {
      'tDate': formattedDate,
      'drEmail': drEmail,


    };
//print("JSON DATA: ${mapeddate}");

    http.Response res = await http.post(APIURL, body: mapeddate);

    this.datas = getDateFromJson(res.body);
    this.dataVal = getDateFromJson(res.body);
  }


}

