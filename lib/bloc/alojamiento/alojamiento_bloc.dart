import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamiento/alojamiento_event.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamiento/alojamiento_state.dart';
import 'package:turismo_tnt_alumnos/data/models/Alojamiento.dart';

// initial
// success
// failure

// fetched <-- event

class AlojamientoBloc extends Bloc<AlojamientoEvent, AlojamientoState> {
  final http.Client httpClient;

  AlojamientoBloc({@required this.httpClient});

  @override
  get initialState => AlojamientoInitial();

  @override
  Stream<AlojamientoState> mapEventToState(AlojamientoEvent event) async* {
    final currentState = state;
    if (event is AlojamientoFetched) {
      try {
        if (currentState is AlojamientoInitial) {
          final alojamientos = await _fetchAlojamientos(0, 20);
          yield AlojamientoSuccess(alojamientos: alojamientos);
          return;
        }
        if (currentState is AlojamientoSuccess) {
          final alojamientos = await _fetchAlojamientos(currentState.alojamientos.length, 20);
          yield AlojamientoSuccess(
            alojamientos: currentState.alojamientos + alojamientos,
          );
        }
      } catch (_) {
        yield AlojamientoFailure();
      }
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
