import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  static const ROUTE_NAME = '/travel';

  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<TravelPage> {
  String _selected = 'Ushuaia';

  void _changSelected(String newSelection) {
    setState(() {
      _selected = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Travel Page'),),
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            RaisedButton(
              child: Text('Ushuaia'),
              color: _selected == 'Ushuaia' ? Colors.amber : Colors.grey,
              onPressed: () {_changSelected('Ushuaia');},
            ),
            RaisedButton(
              child: Text('Río Grande'),
              color: _selected == 'Río Grande' ? Colors.amber : Colors.grey,
              onPressed: () {_changSelected('Río Grande');},
            ),
            RaisedButton(
              child: Text('Tolhuin'),
              color: _selected == 'Tolhuin' ? Colors.amber : Colors.grey, 
              onPressed: () {_changSelected('Tolhuin');},
            ),
          ],
        )
      ),
    );
  }
}
