import 'package:equatable/equatable.dart';
import 'package:turismo_tnt_alumnos/models/Alojamiento.dart';

abstract class AlojamientoState extends Equatable {
  const AlojamientoState();

  @override
  List<Object> get props => [];
}

class AlojamientoInitial extends AlojamientoState {}

class AlojamientoFailure extends AlojamientoState {}

class AlojamientoSuccess extends AlojamientoState {
  final List<Alojamiento> alojamientos;
  final bool hasReachedMax;

  const AlojamientoSuccess({
    this.alojamientos,
    this.hasReachedMax,
  });

  AlojamientoSuccess copyWith({
    List<Alojamiento> alojamientos,
    bool hasReachedMax,
  }) {
    return AlojamientoSuccess(
      alojamientos: alojamientos ?? this.alojamientos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [alojamientos, hasReachedMax];

  @override
  String toString() =>
      'AlojamientoLoaded { alojamientos: ${alojamientos.length}, hasReachedMax: $hasReachedMax }';
}
