import 'package:flutter/material.dart';
import '../models/application_model.dart';
import '../services/supabase_service.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :   Admin viewmodel
 */

class AdminViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();
  List<ApplicationModel> _allApplications = [];
  List<ApplicationModel> _filtered = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String _filterStatus = 'all';
  String _searchQuery = '';

  List<ApplicationModel> get applications => _filtered;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  String get filterStatus => _filterStatus;
  String get searchQuery => _searchQuery;

  // Counts for the summary cards
  int get totalCount => _allApplications.length;
  int get pendingCount =>
      _allApplications.where((a) => a.status == 'pending').length;
  int get approvedCount =>
      _allApplications.where((a) => a.status == 'approved').length;
  int get rejectedCount =>
      _allApplications.where((a) => a.status == 'rejected').length;

  Future<void> loadAllApplications() async {
    _setLoading(true);
    try {
      _allApplications = await _service.getAllApplications();
      _applyFilters();
    } catch (e) {
      _errorMessage = 'Failed to load applications: ${e.toString()}';
    }
    _setLoading(false);
  }

  void setFilter(String status) {
    _filterStatus = status;
    _applyFilters();
    notifyListeners();
  }

  void setSearch(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    List<ApplicationModel> result = List.from(_allApplications);

    // Status filter
    if (_filterStatus != 'all') {
      result = result.where((a) => a.status == _filterStatus).toList();
    }

    // Search filter (name or email or module)
    if (_searchQuery.isNotEmpty) {
      result = result
          .where(
            (a) =>
                a.studentName.toLowerCase().contains(_searchQuery) ||
                a.studentEmail.toLowerCase().contains(_searchQuery) ||
                a.module1Name.toLowerCase().contains(_searchQuery) ||
                (a.module2Name?.toLowerCase().contains(_searchQuery) ?? false),
          )
          .toList();
    }

    _filtered = result;
  }

  Future<void> approveApplication(String appId) async {
    await _changeStatus(appId, 'approved');
  }

  Future<void> rejectApplication(String appId) async {
    await _changeStatus(appId, 'rejected');
  }

  Future<void> _changeStatus(String appId, String newStatus) async {
    _setLoading(true);
    try {
      await _service.updateApplicationStatus(appId, newStatus);
      // Update the local list immediately so the UI refreshes without refetching
      final idx = _allApplications.indexWhere((a) => a.id == appId);
      if (idx != -1) {
        _allApplications[idx] =
            _allApplications[idx].copyWith(status: newStatus);
      }
      _applyFilters();
      _successMessage =
          'Application ${newStatus == 'approved' ? 'approved ✓' : 'rejected ✗'} successfully.';
    } catch (e) {
      _errorMessage = 'Failed to update status: ${e.toString()}';
    }
    _setLoading(false);
  }

  Future<void> deleteApplication(String appId) async {
    _setLoading(true);
    try {
      await _service.deleteApplication(appId);
      _allApplications.removeWhere((a) => a.id == appId);
      _applyFilters();
      _successMessage = 'Application removed successfully.';
    } catch (e) {
      _errorMessage = 'Failed to delete application: ${e.toString()}';
    }
    _setLoading(false);
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
