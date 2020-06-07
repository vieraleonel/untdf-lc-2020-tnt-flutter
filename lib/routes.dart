import 'package:flutter/widgets.dart';
import 'screen/HomeScreen.dart';
import 'TravelPage.dart';
import 'AlojamientosPage.dart';
import 'LoginPage.dart';
import 'screen/ApiClasicoScreen.dart';
import 'screen/ApiFutureBuilder.dart';
import 'screen/InheretedWidgetDemoScreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  HomeScreen.ROUTE_NAME: (BuildContext context) => HomeScreen(),
  ApiClasicoScreen.ROUTE_NAME: (BuildContext context) => ApiClasicoScreen(),
  ApiFutureBuilder.ROUTE_NAME: (BuildContext context) => ApiFutureBuilder(),
  InheretedWidgetDemoScreen.ROUTE_NAME: (BuildContext context) => InheretedWidgetDemoScreen(),
  LoginPage.ROUTE_NAME: (BuildContext context) => LoginPage(),
  TravelPage.ROUTE_NAME: (BuildContext context) => TravelPage(),
  AlojamientosPage.ROUTE_NAME: (BuildContext context) => AlojamientosPage(),
};
