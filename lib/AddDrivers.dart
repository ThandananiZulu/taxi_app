import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/NavBar.dart';
import 'package:taxi_app/login.dart';
import 'package:taxi_app/pages/homePage.dart';
import 'package:taxi_app/welcome.dart';
import 'InputDeco_design.dart';
import 'package:http/http.dart' as http ;
import 'package:taxi_app/main.dart';

class AddDrivers extends StatefulWidget {
    @override
    _FormPageState createState() => _FormPageState();
}
Widget buildForgotPassBtn(BuildContext context){

    return Container(
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: ()  {//print("Already have account")
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => login())); },
            padding: EdgeInsets.only(right: 0),
            child: Text(
                'Already have account : Login',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),
            ),

        ),
    );
}
class _FormPageState extends State<AddDrivers> {

    dynamic token = FlutterSession().get('token');
    String dropdownvalue = 'Driver';
    var items = ['Driver', 'Manager', 'Association'];
    var mEmail;
    //String name,email,phone;
    TextEditingController fullname = TextEditingController();
    TextEditingController number_plate = TextEditingController();

    // TextEditingController _phone = TextEditingController();
    //TextController to read text entered in text field
    TextEditingController email = TextEditingController();
    var toast;

    //TextEditingController _confirmpassword = TextEditingController();
    //TextEditingController _role = TextEditingController();
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            drawer: NavBar(),
            appBar: AppBar(
                centerTitle: true,
                title: Text('Add New Driver'),
            ),
            body: Center(
                child: SingleChildScrollView(
                    child: Form(
                        key: _formkey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                CircleAvatar(
                                    radius: 70,
                                    child: ClipOval(
                                        child: Image.network("https://appmadetaxiapp.000webhostapp.com/driverimg.jpg",width: 300, height: 300, fit: BoxFit.cover,),
                                    ),
                                ),
                                SizedBox(
                                    height: 15,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
                                    child: TextFormField(
                                        controller: fullname,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoration(
                                            Icons.person, "Driver's Name"),
                                        validator: (String value) {
                                            if (value.isEmpty) {
                                                return 'Please Enter Drivers Name';
                                            }
                                            return null;
                                        },
                                        onSaved: (String value) {
                                            // name = value;
                                        },
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
                                    child: TextFormField(
                                        controller: number_plate,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoration(
                                            Icons.directions_car_filled,
                                            "Number Plate"),
                                        validator: (String value) {
                                            if (value.isEmpty) {
                                                return 'Please enter number plate';
                                            }

                                            return null;
                                        },
                                        onSaved: (String value) {
                                            //email = value;
                                        },
                                    ),
                                ),


                                Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
                                    child: TextFormField(
                                        controller: email,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoration(
                                            Icons.email, "Email"),
                                        validator: (String value) {
                                            if (value.isEmpty) {
                                                return 'Please Enter an email';
                                            }
                                            if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                .hasMatch(value)) {
                                                return 'Please enter a valid Email';
                                            }
                                            return null;
                                        },
                                        onSaved: (String value) {
                                            //email = value;
                                        },
                                    ),
                                ),



                                SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: RaisedButton(
                                        color: Colors.lightBlueAccent,
                                        onPressed: () async{
                                            if (_formkey.currentState
                                                .validate()) {
                                               await RegistrationUser();

                                                //userSignIn();

                                            } else {
                                                print("UnSuccessfull");


                                            }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50.0),
                                            side: BorderSide(
                                                color: Colors.blue, width: 2)
                                        ),
                                        textColor: Colors.white,
                                        child: Text("Add driver"),

                                    ),

                                ),
                                //buildForgotPassBtn(context),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }

    void showToast(toast) => Fluttertoast.showToast(msg: toast, fontSize: 18,);

    Future RegistrationUser() async {

        var APIURL = "https://appmadetaxiapp.000webhostapp.com/addDriver.php";
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
         mEmail = sharedPreferences.getString('email');

        Map mapeddate = {
            'fullname': fullname.text,
            'number_plate': number_plate.text,

            'drEmail': email.text,
             'mEmail': mEmail,
        };

        http.Response res = await http.post(APIURL, body: mapeddate);


        if (jsonDecode(res.body) == "user Already exist") {
            print('user already exists');
            toast = "user already exists";
            showToast(toast);
        } else {
            if (jsonDecode(res.body) == "Registration success") {
                print("Driver Registration success, The driver can login using this email");
                toast = "Driver Registration success";
                 showToast(toast);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => welcome()));
                // _showToast(context);

            } else {
                if (jsonDecode(res.body) == "error in Registration") {
                    print("error in Registration");
                    print('$mEmail');
                    print('mrthandananizulu@gmail.com');
                    toast = "error in Registration";
                    showToast(toast);
                };
            }
        }
    }
}
