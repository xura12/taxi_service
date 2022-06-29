// @dart=2.9
import 'package:flutter/material.dart';
import 'package:taxi_service/src/pages/client/edit/client_edit_page.dart';
import 'package:taxi_service/src/pages/client/map/client_map_page.dart';
import 'package:taxi_service/src/pages/client/travel_calification/client_travel_calification_page.dart';
import 'package:taxi_service/src/pages/client/travel_info/client_travel_info_page.dart';
import 'package:taxi_service/src/pages/client/travel_map/client_travel_map_page.dart';
import 'package:taxi_service/src/pages/client/travel_request/client_travel_request_page.dart';
import 'package:taxi_service/src/pages/driver/edit/driver_edit_page.dart';
import 'package:taxi_service/src/pages/driver/map/driver_map_page.dart';
import 'package:taxi_service/src/pages/driver/register/driver_register_page.dart';
import 'package:taxi_service/src/pages/driver/travel_calification/driver_travel_calification_page.dart';
import 'package:taxi_service/src/pages/driver/travel_map/driver_travel_map_page.dart';
import 'package:taxi_service/src/pages/driver/travel_request/driver_travel_request_page.dart';
import 'package:taxi_service/src/pages/home/home_page.dart';
import 'package:taxi_service/src/pages/login/login_page.dart';
import 'package:taxi_service/src/pages/client/register/client_register_page.dart';
import 'package:taxi_service/src/providers/push_notifications_provider.dart';
import 'package:taxi_service/src/utils/colors.dart' as utils;
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState>navigatorKey=new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationsProvider pushNotificationsProvider=new PushNotificationsProvider();
    pushNotificationsProvider.initPushNotifications();
    pushNotificationsProvider.message.listen((data) {
      print("------------NOTIFICACION NUEVA-------------");
      print(data);
      navigatorKey.currentState.pushNamed("driver/travel/request",arguments: data);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Taxi Service",
      navigatorKey: navigatorKey,
      initialRoute: 'home',
      theme: ThemeData(
        fontFamily: "NimbusSans",
        appBarTheme: const AppBarTheme(
          elevation: 0
        ),
          primaryColor: utils.Colors.TaxiServiceColor

      ),
      routes: {
        "home":(BuildContext)=> HomePage(),
        "login":(BuildContext)=> LoginPage(),
        "client/register":(BuildContext)=> ClientRegisterPage(),
        "driver/register":(BuildContext)=> DriverRegisterPage() ,
        "driver/map":(BuildContext)=> DriverMapPage() ,
        'driver/travel/request' : (BuildContext context) => DriverTravelRequestPage(),
        'driver/travel/map' : (BuildContext context) => DriverTravelMapPage(),
        'driver/travel/calification' : (BuildContext context) => DriverTravelCalificationPage(),
        'driver/edit' : (BuildContext context) => DriverEditPage(),
        "client/map":(BuildContext)=> ClientMapPage() ,
        "client/travel/info":(BuildContext)=> ClienteTravelInfoPage() ,
        'client/travel/request' : (BuildContext context) => ClientTravelRequestPage(),
        'client/travel/map' : (BuildContext context) => ClientTravelMapPage(),
        'client/travel/calification' : (BuildContext context) => ClientTravelCalificationPage(),
        'client/edit' : (BuildContext context) => ClientEditPage(),

      },
    );
  }
}

