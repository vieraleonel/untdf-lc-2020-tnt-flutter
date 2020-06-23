import 'package:equatable/equatable.dart';
import 'package:turismo_tnt_alumnos/data/models/Alojamiento.dart';

abstract class AlojamientoState extends Equatable {
  const AlojamientoState();
  

  @override
  List<Object> get props => [];
}

class AlojamientoInitial extends AlojamientoState {}

class AlojamientoFailure extends AlojamientoState {}

class AlojamientoSuccess extends AlojamientoState {
  final List<Alojamiento> alojamientos;

  const AlojamientoSuccess({
    this.alojamientos,
  });

  AlojamientoSuccess copyWith({
    List<Alojamiento> alojamientos,
  }) {
    return AlojamientoSuccess(
      alojamientos: alojamientos ?? this.alojamientos,
    );
  }

  @override
  List<Object> get props => [alojamientos];
}
