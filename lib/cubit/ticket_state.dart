import 'package:equatable/equatable.dart';
import '../models/ticket_model.dart';

abstract class TicketState extends Equatable {
  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<TicketModel> tickets;

  TicketLoaded(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class TicketError extends TicketState {
  final String message;

  TicketError(this.message);

  @override
  List<Object> get props => [message];
}
