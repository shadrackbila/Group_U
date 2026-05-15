import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

// Shadrack Bila 223048044
/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :   Autheticatio viewmodel
 */

class AuthViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  bool _isLoading = false;
  String? _errorMessage;
  String _userRole = 'student';
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get userRole => _userRole;
  bool get isAdmin => _userRole == 'admin';

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.signIn(email.trim(), password.trim());

      if (response.user != null) {
        _userRole = await _service.getUserRole(response.user!.id);
        _isLoading = false;
        notifyListeners();
        return true;
      }
      _errorMessage = 'Login failed. Check your credentials.';
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception:', '').trim();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> signOut() async {
    await _service.signOut();
    _userRole = 'student';
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
