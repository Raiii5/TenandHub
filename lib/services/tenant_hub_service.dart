import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/event_model.dart';
import '../models/booth_model.dart';
import '../models/booking_model.dart';
import 'api_exception.dart';

class TenantHubService {
  final SupabaseClient _client;

  const TenantHubService(this._client);

  Future<List<EventModel>> getEvents() async {
    try {
      final response = await _client.from('events').select();
      final List<dynamic> data = response;

      return data.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Gagal mengambil data event: ${e.toString()}');
    }
  }

  Future<List<BoothModel>> getBoothsByEvent(String eventId) async {
    try {
      final response = await _client
          .from('booths')
          .select()
          .eq('event_id', eventId);
      final List<dynamic> data = response;

      return data.map((json) => BoothModel.fromJson(json)).toList();
    } catch (e) {
      throw ApiException('Gagal mengambil data booth: ${e.toString()}');
    }
  }

  Future<void> bookBooth(BookingModel booking) async {
    try {
      await _client.from('bookings').insert(booking.toJson());
      await _client
          .from('booths')
          .update({'status': 'booked'})
          .eq('id', booking.boothId);
    } catch (e) {
      throw ApiException('Gagal melakukan booking: ${e.toString()}');
    }
  }
}
