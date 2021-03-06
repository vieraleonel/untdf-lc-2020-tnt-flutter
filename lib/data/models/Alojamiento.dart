import 'package:equatable/equatable.dart';

class Alojamiento extends Equatable {
    final int id;
    final String nombre;
    final String domicilio;
    final double lat;
    final double lng;
    final String foto;
    final int clasificacionId;
    final int categoriaId;
    final int localidadId;

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
  List<Object> get props => [id];

  @override
  String toString() => this.nombre;
}
