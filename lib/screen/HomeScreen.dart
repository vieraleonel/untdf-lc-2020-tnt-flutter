import 'package:flutter/material.dart';
import 'package:turismo_tnt_alumnos/LoginPage.dart';
import 'ApiClasicoScreen.dart';
import 'ApiFutureBuilder.dart';

class HomeScreen extends StatelessWidget {
  static const ROUTE_NAME = '/home';

  @override
  Widget build(BuildContext context) {
    goTo(routeName) {
      return () => Navigator.pushNamed(context, routeName);
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            RaisedButton(
              color: Colors.indigo,
              onPressed: goTo(LoginPage.ROUTE_NAME),
              padding: EdgeInsets.all(10),
              child: Text('Travel App',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            RaisedButton(
              color: Colors.indigo,
              onPressed: goTo(ApiClasicoScreen.ROUTE_NAME),
              padding: EdgeInsets.all(10),
              child: Text('API clásico',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            RaisedButton(
              color: Colors.indigo,
              onPressed: goTo(ApiFutureBuilder.ROUTE_NAME),
              padding: EdgeInsets.all(10),
              child: Text('API FutureBuilder',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            RaisedButton(
              color: Colors.indigo,
              onPressed: goTo(LoginPage.ROUTE_NAME),
              padding: EdgeInsets.all(10),
              child: Text('API Bloc',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
