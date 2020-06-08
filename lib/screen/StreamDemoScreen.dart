import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:turismo_tnt_alumnos/data/models/Alojamiento.dart';

class StreamDemoScreen extends StatefulWidget {
  static const ROUTE_NAME = '/stream-demo';

  @override
  _StreamDemoScreen createState() => _StreamDemoScreen();
}

class _StreamDemoScreen extends State<StreamDemoScreen> {
  StreamController<List<Alojamiento>> _alojamientosSC;
  int offset = 0;
  List<Alojamiento> lista = new List();

  void _fetchData() async {
    final response = await http
        .get("http://192.168.1.10:3000/alojamientos?limit=2&offset=${offset}");
    if (response.statusCode == 200) {
      List<Alojamiento> data = (json.decode(response.body) as List)
          .map((item) => new Alojamiento.fromJson(item))
          .toList();
      lista.addAll(data);
      _alojamientosSC.add(lista);
      //_alojamientosSC.addError("Error");
      offset += 2;
    } else {
      throw Exception('Failed to load alojamientos');
    }
  }

  @override
  void initState() {
    _alojamientosSC = new StreamController();
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('StreamController'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _fetchData,
              child: Text('perdir más'),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: _alojamientosSC.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Alojamiento>> snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.all(10.0),
                                title: new Text(snapshot.data[index].nombre),
                              );
                            });
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ),
          ],
        ));
  }
}
