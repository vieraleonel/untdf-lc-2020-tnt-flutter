import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:turismo_tnt_alumnos/models/Alojamiento.dart';

class ApiClasicoScreen extends StatefulWidget {
  static const ROUTE_NAME = '/api-clasico';

  @override
  _ApiClasico createState() => _ApiClasico();
}

class _ApiClasico extends State<ApiClasicoScreen> {
  List<Alojamiento> list = List();
  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get("http://localhost:3000/alojamientos");
    if (response.statusCode == 200) {
      var listTemp = (json.decode(response.body) as List)
          .map((item) => new Alojamiento.fromJson(item))
          .toList();
      setState(() {
        isLoading = false;
        list = listTemp;
      });
    } else {
      throw Exception('Failed to load alojamientos');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Api Clásico'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        title: new Text(list[index].nombre),
                        trailing: new Image.network(
                          list[index].foto,
                          fit: BoxFit.cover,
                          height: 40.0,
                          width: 40.0,
                        ),
                      );
                    }));
  }
}
