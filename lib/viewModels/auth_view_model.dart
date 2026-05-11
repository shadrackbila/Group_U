import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class AuthViewModel extends ChangeNotifier {
  final SupabaseService _authService = SupabaseService();
  
  bool _isLoading = false;
  String? _errorMessage;
  String? _currentUserRole;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get currentUserRole => _currentUserRole;
  bool get isLoggedIn => _authService.isLoggedIn;
  
  // Login method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      // Attempt sign in
      final response = await _authService.signIn(email, password);
      final userId = response.user!.id;
      
      // Get user role
      _currentUserRole = await _authService.getUserRole(userId);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
  
  // Logout method
  Future<void> logout() async {
    await _authService.signOut();
    _currentUserRole = null;
    notifyListeners();
  }
  
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  // Check authentication status on app start
  Future<void> checkAuthStatus() async {
    if (_authService.isLoggedIn) {
      final userId = _authService.currentSession!.user.id;
      _currentUserRole = await _authService.getUserRole(userId);
      notifyListeners();
    }
  }
}