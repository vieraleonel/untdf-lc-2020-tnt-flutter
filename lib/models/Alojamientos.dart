import 'Alojamiento.dart';

class Alojamientos {
  List<Alojamiento> items = new List();

  Alojamientos.fromJsonList(List<dynamic> jsonList){

    if (jsonList == null) return;

    for (var item in jsonList) {
      final alojamientoItem = Alojamiento.fromJson(item);
      items.add(alojamientoItem);
    }
  }
}
