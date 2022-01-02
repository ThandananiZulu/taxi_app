import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/provider/myHomePageProvider.dart';

class SecondPage extends StatelessWidget{
    final String payload;

    const SecondPage({
        Key key,
        @required this.payload,
    }): super(key:key);

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('Current Driver: '+payload ?? ''),
            centerTitle: true,

        ),


        body: ChangeNotifierProvider<ShowDriverProvider>(
            create: (context) => ShowDriverProvider(),
            child: Consumer<ShowDriverProvider>(
                builder: (context, provider, child) {
                    if (provider.data == null) {
                        provider.showData(context);
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
                                        label: Text('Full Name'),
                                        tooltip: 'Name and surname of the driver'),
                                    DataColumn(
                                        label: Text('Number Plate'),
                                        tooltip: 'Taxi number plate'),

                                ],
                                rows: provider.data.toList()
                                    .map((data) =>
                                // we return a DataRow every time
                                DataRow(



                                    cells: [




                                        DataCell(Text(data.drName),),
                                        DataCell(Text(data.drNumberPlate)),

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