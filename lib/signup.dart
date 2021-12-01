

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi_app/login.dart';
import 'InputDeco_design.dart';
import 'package:http/http.dart' as http ;

class signup extends StatefulWidget {
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
class _FormPageState extends State<signup> {
    var toast;
    String dropdownvalue = 'Driver';
    var items = ['Driver','Manager','Association'];
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
                                    child: Image.network('https://unpeppered-demonstr.000webhostapp.com/taxapp.png', width: 300, height: 300, fit: BoxFit.cover,),

                                ),
                                ),
                                SizedBox(
                                    height: 15,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom:15,left: 10,right: 10),
                                    child: TextFormField(
                                        controller: _name,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoration(Icons.person,"Full Name"),
                                        validator: (String value){
                                            if(value.isEmpty)
                                            {
                                                return 'Please Enter Name';
                                            }
                                            return null;
                                        },
                                        onSaved: (String value){
                                            // name = value;
                                        },
                                    ),
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
                                                return 'Please enter a valid Email';
                                            }
                                            return null;
                                        },
                                        onSaved: (String value){
                                            //email = value;
                                        },
                                    ),
                                ),
                                /*Padding(
                  padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                  child: TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    decoration:buildInputDecoration(Icons.phone,"Phone No"),
                    validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please enter phone no ';
                      }
                      return null;
                    },
                    onSaved: (String value){
                      //phone = value;
                    },
                  ),
                ),*/
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                                    child: TextFormField(
                                        controller: _password,
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
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                                    child: TextFormField(
                                        controller: _confirmpassword,
                                        obscureText: true,
                                        keyboardType: TextInputType.text,
                                        decoration:buildInputDecoration(Icons.lock,"Confirm Password"),
                                        validator: (String value){
                                            if(value.isEmpty)
                                            {
                                                return 'Please re-enter password';
                                            }
                                            print(_password.text);

                                            print(_confirmpassword.text);

                                            if(_password.text!=_confirmpassword.text){
                                                return "Password does not match";
                                            }

                                            return null;
                                        },

                                    ),
                                ),

                                // DropdownButton(
                                //
                                //     value: dropdownvalue,
                                //
                                //
                                //     icon: Icon(Icons.keyboard_arrow_down),
                                //     items: items.map((String items) {
                                //         return DropdownMenuItem(value: items,
                                //             child: Text(items));
                                //     }).toList(),
                                //     onChanged: (String newValue){
                                //         setState(() {
                                //             dropdownvalue = newValue;
                                //
                                //         });
                                //     },
                                // ),

                                SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: RaisedButton(
                                        color: Colors.lightBlueAccent,
                                        onPressed: () async{

                                            if(_formkey.currentState.validate())
                                            {
                                                await RegistrationUser();

                                                //userSignIn();
                                                print("successful");
                                                toast ="Successful!";
                                                showToast(toast);
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => login()));

                                            }else{
                                                print("UnSuccessfull");
                                                toast ="UnSuccessfull";
                                                showToast(toast);
                                            }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            side: BorderSide(color: Colors.blue,width: 2)
                                        ),
                                        textColor:Colors.white,child: Text("Sign Up"),

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

    Future RegistrationUser() async{
        var APIURL = "https://unpeppered-demonstr.000webhostapp.com/signup.php";

        Map mapeddate = {
            'name': _name.text,
            'email': _email.text,
            //'phone': _phone.text,
            'password': _password.text,
            'role' : dropdownvalue,
        };
//print("JSON DATA: ${mapeddate}");

        http.Response reponse = await http.post(APIURL,body:mapeddate);

        var data = json.decode(reponse.body);


        print("DATA: ${data}");
        toast ="DATA: ${data}";
        showToast(toast);
    }
  void showToast(toast) => Fluttertoast.showToast(msg: toast, fontSize: 18,);


}

