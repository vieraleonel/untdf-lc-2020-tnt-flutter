import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamiento/alojamiento_event.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamiento/alojamiento_state.dart';
import 'package:turismo_tnt_alumnos/data/models/Alojamiento.dart';

// initial
// success
// failure

// fetched <-- event

class SPAlojamientoBloc extends Bloc<AlojamientoEvent, AlojamientoState> {
  final http.Client httpClient;

  SPAlojamientoBloc({@required this.httpClient});

  @override
  get initialState => AlojamientoInitial();

  @override
  Stream<AlojamientoState> mapEventToState(AlojamientoEvent event) async* {
    final currentState = state;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (currentState is AlojamientoInitial) {
        print(prefs.getString('alojamientos'));
        String sAlojamientos = prefs.getString('alojamientos') ?? null;
        List<Alojamiento> alojamientos;
        if (sAlojamientos != null) {
          alojamientos = (json.decode(sAlojamientos) as List)
            .map((item) => new Alojamiento.fromJson(item))
            .toList();
          print("DESDE SP");
          print(alojamientos);
        }
        else {
          alojamientos = await _fetchAlojamientos(0, 20);
        }
        yield AlojamientoSuccess(alojamientos: alojamientos);
        return;
      }
      if (currentState is AlojamientoSuccess) {
        final alojamientos = await _fetchAlojamientos(currentState.alojamientos.length, 20);
        
        final newAlojamientos = currentState.alojamientos + alojamientos;
        await prefs.setString('alojamientos', json.encode(newAlojamientos.map((e) => e.toJson()).toList()));
        
        yield AlojamientoSuccess(
          alojamientos: newAlojamientos,
        );
      }
    } catch (_) {
      yield AlojamientoFailure();
    }
  }


  Future<List<Alojamiento>> _fetchAlojamientos(int offset, int limit) async {
    final response = await http.get("http://192.168.1.10:3000/alojamientos?offset=$offset&limit=$limit");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => new Alojamiento.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load alojamientos');
    }
  }
}
