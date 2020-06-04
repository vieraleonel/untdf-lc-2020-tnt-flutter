import 'package:flutter/material.dart';
import 'screen/HomeScreen.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      initialRoute: HomeScreen.ROUTE_NAME,
      routes: routes,
    );
  }
}
