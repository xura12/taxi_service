import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:taxi_service/src/providers/client_provider.dart';
import 'package:taxi_service/src/providers/driver_provider.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_service/src/utils/shared_pref.dart';

class PushNotificationsProvider {

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  StreamController _streamController =
  StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get message => _streamController.stream;


  void initPushNotifications() async {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          print('Cuando estamos en primer plano');
          print('OnMessage: $message');
          _streamController.sink.add(message);
        },
          onLaunch: (Map<String, dynamic> message) {
            print('OnLaunch: $message');
            _streamController.sink.add(message);
            SharedPref sharedPref = new SharedPref();
            sharedPref.save('isNotification', 'true');

        },
        onResume: (Map<String, dynamic> message) {
          print('OnResume $message');
          _streamController.sink.add(message);
        }
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true,
            badge: true,
            alert: true,
            provisional: true
        )
    );

    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print('Coonfiguraciones para Ios fueron regustradas $settings');
    });


  }

  void saveToken(String idUser, String typeUser) async {
    String token = await _firebaseMessaging.getToken();
    Map<String, dynamic> data = {
      'token': token
    };

    if (typeUser == 'client') {
      ClientProvider clientProvider = new ClientProvider();
      clientProvider.update(data, idUser);
    }
    else {
      DriverProvider driverProvider = new DriverProvider();
      driverProvider.update(data, idUser);
    }

  }

  Future<void>sendMessage(String to,Map <String, dynamic>data,String title,String body)async{
    await http.post("https://fcm.googleapis.com/fcm/send",
    headers:<String, String>{
      "Content-Type":"application/json",
      "Authorization":"key=AAAAw3KmTDY:APA91bH_EUD0EXD4A0Oo8Jl3InShnkJsOWL6dz3yRAyCuCCi7uW3IWLTxdvi30rZfRVOxflqU_O0iwePA9ypWNx_8zOFMJjSHyffX1GT25wHniVC5E0nCCOFiuQc73VaP5ujy2E8-S9J"
    },
        body: jsonEncode(
            <String, dynamic> {
              'notification': <String, dynamic> {
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'ttl': '4500s',
              'data': data,
              'to': to
            }
        )
    );
  }


  void dispose () {
    _streamController?.onCancel;
  }

}