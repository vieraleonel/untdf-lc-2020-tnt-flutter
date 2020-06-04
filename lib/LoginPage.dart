import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const ROUTE_NAME = '/login';
  @override
  Widget build(BuildContext context) {
    
    void goToTravelPage() {
      Navigator.pushNamed(context, '/travel');
    } 

    void goToAlojamientosPage() {
      Navigator.pushNamed(context, '/alojamientos');
    } 

    final Container loginUpperText = Container(
      width: 320,
      margin: EdgeInsets.only(bottom: 15),
      child: RaisedButton(
        color: Colors.white,
        onPressed: goToTravelPage,
        padding: EdgeInsets.all(10),
        child: Text('SIGN IN',
            style: TextStyle(fontSize: 20, color: Colors.deepPurple)),
      ),
    );

    final Container loginButtons = Container(
      width: 320,
      margin: EdgeInsets.only(bottom: 15),
      child: RaisedButton(
        color: Colors.deepPurple,
        onPressed: goToAlojamientosPage,
        padding: EdgeInsets.all(10),
        child: Text('SIGN UP',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/fondo-login.png'),
                fit: BoxFit.cover,
                alignment: Alignment(-0.15, 1)),
          ),
        ),
        Container(
          color: Color.fromRGBO(0, 0, 0, 0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      'Explore the world',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Text('Travel with people. Make new friends',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
              Column(
                children: <Widget>[
                  loginUpperText,
                  loginButtons,
                ],
              )
            ],
          ),
        )
      ],
      
    ));
  }
}
