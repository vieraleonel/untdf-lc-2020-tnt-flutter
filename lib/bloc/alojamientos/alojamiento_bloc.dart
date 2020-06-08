import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamientos/alojamiento_event.dart';
import 'package:turismo_tnt_alumnos/bloc/alojamientos/alojamiento_state.dart';
import 'package:turismo_tnt_alumnos/models/Alojamiento.dart';

class AlojamientoBloc extends Bloc<AlojamientoEvent, AlojamientoState> {
  final http.Client httpClient;

  AlojamientoBloc({@required this.httpClient});

  @override
  get initialState => AlojamientoInitial();

  @override
  Stream<AlojamientoState> mapEventToState(AlojamientoEvent event) async* {
    final currentState = state;
    if (event is AlojamientoFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is AlojamientoInitial) {
          final alojamientos = await _fetchAlojamientos(0, 20);
          yield AlojamientoSuccess(alojamientos: alojamientos, hasReachedMax: false);
          return;
        }
        if (currentState is AlojamientoSuccess) {
          final alojamientos = await _fetchAlojamientos(currentState.alojamientos.length % 20, 20);
          yield alojamientos.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : AlojamientoSuccess(
                  alojamientos: currentState.alojamientos + alojamientos,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield AlojamientoFailure();
      }
    }
  }

  bool _hasReachedMax(AlojamientoState state) =>
      state is AlojamientoSuccess && state.hasReachedMax;

  Future<List<Alojamiento>> _fetchAlojamientos(int offset, int limit) async {
    final response = await http.get("http://192.168.1.10:3000/alojamientos?offset=${offset}&limit=${limit}");
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => new Alojamiento.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load alojamientos');
    }
  }
}
