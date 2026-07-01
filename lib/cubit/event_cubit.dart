import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/tenant_hub_service.dart';
import '../services/api_exception.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final TenantHubService _service;

  EventCubit(this._service) : super(EventInitial());

  Future<void> fetchEvents() async {
    emit(EventLoading());
    try {
      final events = await _service.getEvents();
      if (events.isEmpty) {
        emit(const EventLoaded([]));
        return;
      }
      emit(EventLoaded(events));
    } on ApiException catch (e) {
      emit(EventError(e.message));
    } catch (e) {
      emit(EventError(e.toString()));
    }
  }
}
