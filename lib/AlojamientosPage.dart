import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Alojamiento {
    int id;
    String nombre;
    String domicilio;
    double lat;
    double lng;
    String foto;
    int clasificacionId;
    int categoriaId;
    int localidadId;

    Alojamiento({
        this.id,
        this.nombre,
        this.domicilio,
        this.lat,
        this.lng,
        this.foto,
        this.clasificacionId,
        this.categoriaId,
        this.localidadId,
    });

    factory Alojamiento.fromJson(Map<String, dynamic> json) => Alojamiento(
        id: json["id"],
        nombre: json["nombre"],
        domicilio: json["domicilio"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        foto: json["foto"],
        clasificacionId: json["clasificacion_id"],
        categoriaId: json["categoria_id"],
        localidadId: json["localidad_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "domicilio": domicilio,
        "lat": lat,
        "lng": lng,
        "foto": foto,
        "clasificacion_id": clasificacionId,
        "categoria_id": categoriaId,
        "localidad_id": localidadId,
    };
}

class Alojamientos {
  List<Alojamiento> items = new List();

  Alojamientos.fromJsonList(List<dynamic> jsonList){

    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = Alojamiento.fromJson(item);
      items.add(pelicula);
    }
  }
}

class AlojamientosPage extends StatefulWidget {
  static const ROUTE_NAME = '/alojamientos';

  @override
  _AlojamientosState createState() => _AlojamientosState();
}

class _AlojamientosState extends State<AlojamientosPage> {
  Future<Alojamientos> futureAlojamiento;
  Alojamientos _alojamientos;

  Future<Alojamientos> fetchAlojamientos() async {
  final response = await http.get('http://localhost:3000/alojamientos');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Alojamientos.fromJsonList(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load alojamiento');
  }
}

  @override
  void initState() {
    super.initState();
    http.get("http://localhost:3000/alojamientos")
      .then((res) => json.decode(res.body))
      .then((json) => Alojamientos.fromJsonList(json))
      .then((aloj) => {
        setState((){
          _alojamientos = aloj;
        })
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alojamientos'),),
      body: Row(
        children: <Widget>[
          FutureBuilder<Alojamientos>(
            future: fetchAlojamientos(),
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                return  Container(
                  width: 300,
                  child: ListView.builder(
                    
                    itemCount: snapshot.data.items.length, 
                    itemBuilder: (context, index) { 
                      return Text(snapshot.data.items[index].nombre);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            }),
          Column(
            children: _alojamientos?.items?.map<Widget>((e) => Text('Hola')),
          )
        ],
      ),
    );
  }
}
