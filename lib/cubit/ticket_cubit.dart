import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'ticket_state.dart';
import '../models/ticket_model.dart';
import '../services/database_service.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());

  final List<TicketModel> _webFallbackDb = [];

  void loadTickets() async {
    emit(TicketLoading());
    try {
      if (kIsWeb) {
        emit(TicketLoaded(List.from(_webFallbackDb)));
        return;
      }
      final tickets = await DatabaseService.instance.fetchAllTickets();
      emit(TicketLoaded(tickets));
    } catch (e) {
      emit(TicketLoaded(List.from(_webFallbackDb)));
    }
  }

  void addTicket(TicketModel ticket) async {
    try {
      if (kIsWeb) {
        _webFallbackDb.insert(0, ticket);
        loadTickets();
        return;
      }
      await DatabaseService.instance.insertTicket(ticket);
      loadTickets();
    } catch (e) {
      _webFallbackDb.insert(0, ticket);
      loadTickets();
    }
  }

  void cancelTicket(String id) async {
    try {
      if (kIsWeb) {
        final index = _webFallbackDb.indexWhere((t) => t.id == id);
        if (index != -1) {
          final old = _webFallbackDb[index];
          _webFallbackDb[index] = TicketModel(
            id: old.id,
            trxId: old.trxId,
            title: old.title,
            date: old.date,
            time: old.time,
            location: old.location,
            image: old.image,
            boothName: old.boothName,
            price: old.price,
            status: 'Dibatalkan',
            paymentMethod: old.paymentMethod,
          );
        }
        loadTickets();
        return;
      }
      await DatabaseService.instance.updateTicketStatus(id, 'Dibatalkan');
      loadTickets();
    } catch (e) {
      final index = _webFallbackDb.indexWhere((t) => t.id == id);
      if (index != -1) {
        final old = _webFallbackDb[index];
        _webFallbackDb[index] = TicketModel(
          id: old.id,
          trxId: old.trxId,
          title: old.title,
          date: old.date,
          time: old.time,
          location: old.location,
          image: old.image,
          boothName: old.boothName,
          price: old.price,
          status: 'Dibatalkan',
          paymentMethod: old.paymentMethod,
        );
      }
      loadTickets();
    }
  }
}
