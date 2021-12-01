import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:taxi_app/model/myData.dart';


class MyHomePageProvider extends ChangeNotifier {
  List<Employees> data;
  var client = http.Client();
  Future getData(context) async {
    // You can call an API to get data, once we've the data from API or any other flow... Following part would always be the same.
    // We forgot about one more important part .. lets do that first

    // We need access to BuildContext for loading this string and it's not recommended to store this context in any variable here
    // in change notifier..

    //var response = await DefaultAssetBundle.of(context)
    //  .loadString('assets/raw/mJson.json');
    //   var url = "http://192.168.43.146/flutter/emp.php";
    // final response = await client.get(url);

    String url ="https://unpeppered-demonstr.000webhostapp.com/emp.php";

    final response = await http.get(url);
    this.data = employeesFromMap(response.body);




    //var mJson = jsonDecode(response.body ) ;
    //this.data = Employees.fromJson(mJson);
    this.notifyListeners();
    // return json.decode(response.body);
    // now we have response as String from local json or and API request...
    //var mJson = json.decode(response);
    // now we have a json...

    this.notifyListeners(); // for callback to view
  }
}
/*Future<List<Employees>> fetchEmployees() async{
  String url ="http://192.168.43.146/flutter/emp.php";

  final response = await http.get(url);
  return employeesFromMap(response.body);
}*/