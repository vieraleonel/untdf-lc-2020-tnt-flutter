import 'package:equatable/equatable.dart';

abstract class AlojamientoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AlojamientoFetched extends AlojamientoEvent {}
