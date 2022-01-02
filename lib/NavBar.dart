// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, non_constant_identifier_names, avoid_print, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:taxi_app/AddDrivers.dart';
import 'package:taxi_app/login.dart';
import 'package:taxi_app/pages/homePage.dart';

import 'package:taxi_app/second_page.dart';
import 'package:taxi_app/welcome.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Menu',),


            decoration: BoxDecoration(
              color: Colors.blue,
                ),
          ),
          ListTile(
            leading: Icon(Icons.car_rental_sharp),
            title: Text(''
                'Main page'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => welcome())), //SignOut Page

          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Add New Driver'),
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddDrivers())), //SignOut Page
            //Home Page
          ),
          ListTile(
            leading: Icon(Icons.chair),
            title: Text('Rank Management Table'),
            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage())), //SignOut Page
            //Drivers Page with table
          ),
          ListTile(
            leading: Icon(Icons.car_rental_sharp),
            title: Text('Drivers'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage(payload: "Not Applicable",))), //SignOut Page

          ),

          ListTile(
            leading: Icon(Icons.car_rental_sharp),
            title: Text('Logout'),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => login())), //SignOut Page

          ),
        ],
      ),
    );
  }
}
