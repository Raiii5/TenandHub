import 'package:equatable/equatable.dart';
import '../models/booth_model.dart';

abstract class BoothState extends Equatable {
  const BoothState();

  @override
  List<Object> get props => [];
}

class BoothInitial extends BoothState {}

class BoothLoading extends BoothState {}

class BoothLoaded extends BoothState {
  final List<BoothModel> booths;

  const BoothLoaded(this.booths);

  @override
  List<Object> get props => [booths];
}

class BoothActionSuccess extends BoothState {}

class BoothError extends BoothState {
  final String message;

  const BoothError(this.message);

  @override
  List<Object> get props => [message];
}
