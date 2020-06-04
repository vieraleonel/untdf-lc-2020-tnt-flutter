import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:turismo_tnt_alumnos/models/Alojamiento.dart';

class ApiFutureBuilder extends StatefulWidget {
  static const ROUTE_NAME = '/api-future-builder';

  @override
  _ApiFutureBuilder createState() => _ApiFutureBuilder();
}

class _ApiFutureBuilder extends State<ApiFutureBuilder> {
  Future<List<Alojamiento>> futureAlojamientos;

  Future<List<Alojamiento>> _fetchData() async {
    final response = await http.get("http://localhost:3000/alojamientos");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => new Alojamiento.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load alojamientos');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlojamientos = this._fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Api Clásico'),
        ),
        body: FutureBuilder<List<Alojamiento>>(
          future: futureAlojamientos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: new Text(snapshot.data[index].nombre),
                      trailing: new Image.network(
                        snapshot.data[index].foto,
                        fit: BoxFit.cover,
                        height: 40.0,
                        width: 40.0,
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ));
  }
}
