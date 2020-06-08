import 'package:equatable/equatable.dart';

class Alojamiento extends Equatable {
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

  @override
  // TODO: implement props
  List<Object> get props => [
    id, 
    nombre, 
    domicilio, 
    lat, 
    lng, 
    foto, 
    clasificacionId, 
    categoriaId, 
    localidadId, 
  ];
}
