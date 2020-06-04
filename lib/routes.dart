import 'package:flutter/widgets.dart';
import 'screen/HomeScreen.dart';
import 'TravelPage.dart';
import 'AlojamientosPage.dart';
import 'LoginPage.dart';
import 'screen/ApiClasicoScreen.dart';
import 'screen/ApiFutureBuilder.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  HomeScreen.ROUTE_NAME: (BuildContext context) => HomeScreen(),
  LoginPage.ROUTE_NAME: (BuildContext context) => LoginPage(),
  ApiClasicoScreen.ROUTE_NAME: (BuildContext context) => ApiClasicoScreen(),
  ApiFutureBuilder.ROUTE_NAME: (BuildContext context) => ApiFutureBuilder(),
  TravelPage.ROUTE_NAME: (BuildContext context) => TravelPage(),
  AlojamientosPage.ROUTE_NAME: (BuildContext context) => AlojamientosPage(),
};
