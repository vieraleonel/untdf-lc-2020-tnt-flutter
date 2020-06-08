import 'package:flutter/widgets.dart';
import 'package:turismo_tnt_alumnos/screen/BlocDemoScreen.dart';
import 'package:turismo_tnt_alumnos/screen/StreamDemoScreen.dart';
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
  StreamDemoScreen.ROUTE_NAME: (BuildContext context) => StreamDemoScreen(),
  BlocDemoScreen.ROUTE_NAME: (BuildContext context) => BlocDemoScreen(),
  LoginPage.ROUTE_NAME: (BuildContext context) => LoginPage(),
  TravelPage.ROUTE_NAME: (BuildContext context) => TravelPage(),
  AlojamientosPage.ROUTE_NAME: (BuildContext context) => AlojamientosPage(),
};
