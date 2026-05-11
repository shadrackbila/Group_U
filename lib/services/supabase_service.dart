import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  late final SupabaseClient supabase;

  void initialize(SupabaseClient client) {
    supabase = client;
  }

  // Login method
  Future<AuthResponse> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Get user role from profiles table
  Future<String> getUserRole(String userId) async {
    try {
      final response = await supabase
          .from('profiles')
          .select('role')
          .eq('id', userId)
          .maybeSingle();
      
      if (response == null) {
        return 'student'; // Default role
      }
      return response['role'] ?? 'student';
    } catch (e) {
      return 'student'; // Default on error
    }
  }

  // Logout
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Check if user is logged in
  Session? get currentSession => supabase.auth.currentSession;
  
  bool get isLoggedIn => currentSession != null;
}