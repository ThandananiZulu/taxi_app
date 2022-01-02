import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/driverWelcome.dart';
import 'package:taxi_app/pages/homePage.dart';
import 'package:taxi_app/second_page.dart';
import 'package:taxi_app/signup.dart';
import 'package:taxi_app/welcome.dart';
import 'InputDeco_design.dart';
import 'package:http/http.dart' as http ;

class login extends StatefulWidget {
    @override
    _FormPageState createState() => _FormPageState();
}
Widget buildForgotPassBtn(BuildContext context){
    return Container(
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: ()  {//print("Already have account")
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => signup())); },

            padding: EdgeInsets.only(right: 0),
            child: Text(
                'Dont have account? : Sign Up',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold
                ),
            ),

        ),
    );
}
class _FormPageState extends State<login> {
    var toast;
    String dropdownvalue = 'Driver';
    var items = ['Driver','Manager','conductor'];
    //String name,email,phone;
    TextEditingController _name = TextEditingController();
    TextEditingController _email = TextEditingController();
    // TextEditingController _phone = TextEditingController();
    //TextController to read text entered in text field
    TextEditingController _password = TextEditingController();
    TextEditingController _confirmpassword = TextEditingController();
    TextEditingController _role = TextEditingController();
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
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
                                    child: Image.network('https://appmadetaxiapp.000webhostapp.com/taxapp.png',width: 300, height: 300, fit: BoxFit.cover,),
                                ),
                                ),
                                SizedBox(
                                    height: 15,
                                ),

                                Padding(
                                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                                    child: TextFormField(
                                        controller: _email,
                                        keyboardType: TextInputType.text,
                                        decoration:buildInputDecoration(Icons.email,"Email"),
                                        validator: (String value){
                                            if(value.isEmpty)
                                            {
                                                return 'Please Enter an email';
                                            }
                                            if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                                return 'Please a valid Email';
                                            }
                                            return null;
                                        },
                                        onSaved: (String value){
                                            //email = value;
                                        },
                                    ),
                                ),

                                Padding(
                                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                                    child: TextFormField(
                                        controller: _password,
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        decoration:buildInputDecoration(Icons.lock,"Password"),
                                        validator: (String value){
                                            if(value.isEmpty)
                                            {
                                                return 'Please Enter a Password';
                                            }
                                            return null;
                                        },

                                    ),
                                ),

                                SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: RaisedButton(
                                        color: Colors.lightBlueAccent,
                                        onPressed: () async{

                                            if(_formkey.currentState.validate())
                                            {

                                                await userSignIn();
                                                print("successful");
                                                //toast ="Successful login";
                                               // showToast(toast);
                                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));


                                            }else{
                                                print("UnSuccessful");
                                                toast ="Unsuccessful";
                                                showToast(toast);
                                            }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            side: BorderSide(color: Colors.blue,width: 2)
                                        ),
                                        textColor:Colors.white,child: Text("Login"),

                                    ),

                                ),
                                buildForgotPassBtn(context),

                            ],
                        ),
                    ),
                ),
            ),
        );
    }
    void showToast(toast) => Fluttertoast.showToast(msg: toast, fontSize: 18,);

    Future userSignIn() async{

        var url = "https://appmadetaxiapp.000webhostapp.com/login.php";
        var data = {
            "email": _email.text,
            "password": _password.text,
        };
        print("JSON DATA: ${data}");
        var res = await http.post(url, body:data);

        if(json.decode(res.body) == "i dont have an account"){
            print('you unfortunately dont have account');
            toast ="you unfortunately dont have account";
            showToast(toast);
        }else{
            if(jsonDecode(res.body) == "false"){
                print('the wrong password');
                toast ="the wrong password";
                showToast(toast);
                // _showToast(context);

            }else{
                if(json.decode(res.body) == "taxiapp"){
                    print('successful login');
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', _email.text);

                    toast ="successful login";
                    showToast(toast);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => driverWelcome()));

                }
                if(json.decode(res.body) == "true"){
                    print('successful login');
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', _email.text);

                    toast ="successful login";
                    showToast(toast);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => welcome()));

                };

            }

        }

    }

}

