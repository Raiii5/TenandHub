import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  // 1. Fungsi untuk Mendaftar (Register)
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name}, // Menyimpan nama ke metadata Supabase
      );
      return response;
    } catch (e) {
      throw Exception('Gagal mendaftar: $e');
    }
  }

  // 2. Fungsi untuk Masuk (Login)
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Email atau password salah!');
    }
  }

  // 3. Fungsi untuk Keluar (Logout)
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // 4. Cek User yang Sedang Aktif
  User? get currentUser => _supabase.auth.currentUser;
}
