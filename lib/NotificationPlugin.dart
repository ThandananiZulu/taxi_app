import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show File, Platform;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
class NotificationPlugin{
    //
    var initializationSettings;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    final BehaviorSubject<RecievedNotification> didReceivedLocalNotificationSubject =
    BehaviorSubject<RecievedNotification>();

    NotificationPlugin._(){

        init();

    }

    init() async{
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        if(Platform.isIOS){
            _requestIOSPermission();
        }
        initializePlatformSpecifics();
    }

    initializePlatformSpecifics(){
        var initializationSettingsAndroid = AndroidInitializationSettings('app_notf_icon');
        var initializationSettingsIOS = IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (id,title,body,payload) async{
                RecievedNotification recievedNotification = RecievedNotification(
                    id: id, title: title, body: body, payload: payload);
                didReceivedLocalNotificationSubject.add(recievedNotification);
            }
        );

        initializationSettings = InitializationSettings(
            android: initializationSettingsAndroid,iOS: initializationSettingsIOS);

        // flutterLocalNotificationsPlugin.initialize(initializationSettings,
        //     onSelectNotification: (String payload){
        //
        //     });
    }
    _requestIOSPermission(){
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions(
            alert: false,
            badge: true,
            sound: true,
        );


    }
    setListenerForLowerVersions(Function onNotificationInLowerVersions){
        didReceivedLocalNotificationSubject.listen((receivedNotification) {
            onNotificationInLowerVersions(receivedNotification);
        });
    }
    setOnNotificationClick(Function onNotificationClick) async{
        await  flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: (String payload) async{
                onNotificationClick(payload);
            });
    }
    Future<void> showNotification(String val, String vall) async{
        var androidChannelSpecifics = AndroidNotificationDetails(
            'CHANNEL_ID=2', 'CHANNEL_NAME', "CHANNEL_DESCRIPTION", importance: Importance.max,priority: Priority.high,playSound: true,timeoutAfter: 5000,styleInformation: DefaultStyleInformation(true,true),);
        var iosChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics,iOS: iosChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(0, '$val: Your load is full', 'Next driver is: $vall', platformChannelSpecifics, payload: '$vall');
    }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();
class RecievedNotification{
    final int id;
    final String title;
    final String body;
    final String payload;

    RecievedNotification({
        @required this.id,
        @required this.title,
        @required this.body,
        @required this.payload,
    });
}