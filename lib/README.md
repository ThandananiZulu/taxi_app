import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taxi_app/model/myData.dart';
import 'package:taxi_app/notification_api.dart';
import 'package:taxi_app/provider/myHomePageProvider.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/NotificationPlugin.dart';
import 'package:taxi_app/NavBar.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_app/second_page.dart';

class MyHomePage extends StatefulWidget{
  _MyHomeState createState() => _MyHomeState();
}


class _MyHomeState extends State<MyHomePage> {
  @override
  void initState(){
    super.initState();
    notificationPlugin.setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
    _getDriver();

  }

  bool seen = true;
  var long;
  var fname;
  String value = "";
  String vall ;
  int index;
  TextEditingController _names = TextEditingController();
var tddate;
 List<String> drivers =[];

  int num;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rank Manager Table'),
      ),
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getData(context);
              return Center(child: CircularProgressIndicator());
            }
            // when we have the json loaded... let's put the data into a data table widget
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
              child: SingleChildScrollView(
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                        label: Text('Add Load'),
                        tooltip: 'Do This when the current driver has a full taxi.'),
                    DataColumn(
                        label: Text('Full Name'),
                        tooltip: 'Name and surname of the driver'),
                    DataColumn(
                        label: Text('Number Plate'),
                        tooltip: 'Taxi number plate'),
                    DataColumn(
                        label: Text('Date'),
                        tooltip: 'represents the date of this load'),
                    DataColumn(
                        label: Text('Completed Load'),
                        tooltip: 'All loads driver has successfully completed'),
                  ],
                  rows: provider.data.toList()
                      .map((data) =>
                  // we return a DataRow every time
                  DataRow(



                      cells: [



                        DataCell((data.increment) != null
                            ? Icon(
                          Icons.add_task_sharp,
                          color: Colors.green,
                        )
                            : Icon(Icons.cancel, color: Colors.red),
                            onTap: () async{ await _getrow(data.fullname);

  drivers = provider.data.map((data) => ('${data.fullname}')).toList();
  index = provider.data.indexWhere((element) =>
  element.fullname == data.fullname);
   long = drivers.length - 1;
   fname = data.fullname;


                        }

                        ),
                        DataCell(Text(data.fullname),),
                        DataCell(Text(data.numberPlate)),
                        DataCell(Text(data.date)),
                        DataCell(Text(data.load)),
                      ]))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );


  }
  void _Add(BuildContext context)  {
    showDialog(context: context, builder: (BuildContext ctx){
      return AlertDialog(
        title: Text('Please confirm'),
        content: Text('Are you sure to add a new Load?'),
        actions: [
          //yes
      TextButton(onPressed: () async{

await updateLoad();

if (index >= 0 && index < long) {
  index = index + 1;
  vall = drivers[index];
  print('using indexwhere: $vall');
  print(index);
  print(long);
  await notificationPlugin.showNotification(
      fname, vall);


} else {
  vall = ' No Driver!';
  await notificationPlugin.showNotification(
      fname, vall);
}

Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(),));

      },
          child: Text('Yes')),
          TextButton(onPressed: (){
            Navigator.of(context).pop();

          },child: Text('No'))
        ],
      );
    });
  }
  Future updateLoad() async{

    var APIURL = "https://unpeppered-demonstr.000webhostapp.com/updateload.php";

    Map mapeddate = {
      "fullname": value,

    };
print("JSON DATA: ${mapeddate}");

    http.Response response = await http.post(APIURL,body:mapeddate);

    // var data = json.decode(response.body);
    //
    //
    // ("DATA: ${data}");
  }
  void _getrow(dynamic name) async{
    print('check: $name');
    value = name;
    await _Add(context);
  }
  onNotificationInLowerVersions(RecievedNotification recievedNotification){


  }

  onNotificationClick(String payload){
    print('Payloads $payload');
Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondPage(payload:payload),));
  }


  Future _getDriver() async {
    var APIURL = "https://unpeppered-demonstr.000webhostapp.com/getDrivers.php";
    var mEmail = "ww@gmail.com";
    var now = new DateTime.now();
    tddate = new DateTime(now.year, now.month,now.day).toString();

    Map mapeddate = {
      'mEmail': mEmail,
      'tddate': tddate,
    };

    var data = await http.post(APIURL, body: mapeddate);
    var jsonData =  json.decode(data.body);


  }

}
