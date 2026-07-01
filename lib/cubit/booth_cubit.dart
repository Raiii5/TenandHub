import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booth_model.dart';

// State
abstract class BoothState {}

class BoothInitial extends BoothState {}

class BoothLoading extends BoothState {}

class BoothLoaded extends BoothState {
  final List<BoothModel> booths;
  BoothLoaded(this.booths);
}

class BoothError extends BoothState {
  final String message;
  BoothError(this.message);
}

// Cubit
class BoothCubit extends Cubit<BoothState> {
  BoothCubit() : super(BoothInitial());

  Future<void> fetchBooths(String eventId) async {
    emit(BoothLoading());
    try {
      final response = await Supabase.instance.client
          .from('booths')
          .select()
          .eq('event_id', eventId);

      final List<BoothModel> booths = (response as List)
          .map((json) => BoothModel.fromJson(json))
          .toList();
      emit(BoothLoaded(booths));
    // Ubah bagian catch ini
    } catch (e) {
      print("DEBUG ERROR BOOTH: $e"); // Tambahkan baris ini
      emit(BoothError(e.toString()));
    }
  }
}
