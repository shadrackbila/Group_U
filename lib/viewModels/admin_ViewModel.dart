
import 'package:flutter/material.dart';
import '../models/application_model.dart';

class AdminViewModel extends ChangeNotifier {

 

  bool _isLoading = false;

  String? _successMessage;
  String? _errorMessage;

  String _searchQuery = '';
  String _filterStatus = 'all';

  final List<ApplicationModel> _applications = [];

 

  bool get isLoading => _isLoading;

  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;

  String get searchQuery => _searchQuery;
  String get filterStatus => _filterStatus;

  List<ApplicationModel> get applications {

    List<ApplicationModel> filteredApps = _applications;

    // SEARCH FILTER
    if (_searchQuery.isNotEmpty) {
      filteredApps = filteredApps.where((app) {
        return app.studentName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            app.studentEmail
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            app.module1Name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // STATUS FILTER
    if (_filterStatus != 'all') {
      filteredApps = filteredApps.where((app) {
        return app.status == _filterStatus;
      }).toList();
    }

    return filteredApps;
  }

  // COUNTS
  int get totalCount => _applications.length;

  int get pendingCount =>
      _applications.where((e) => e.status == 'pending').length;

  int get approvedCount =>
      _applications.where((e) => e.status == 'approved').length;

  int get rejectedCount =>
      _applications.where((e) => e.status == 'rejected').length;

  

  Future<void> loadAllApplications() async {

    try {

      _isLoading = true;
      notifyListeners();

      // FAKE DELAY
      await Future.delayed(const Duration(seconds: 1));

      // SAMPLE DATA
      _applications.clear();

      _applications.addAll([
        ApplicationModel(
          id: '1',
          studentName: 'John Doe',
          studentEmail: 'john@gmail.com',
          module1Name: 'Programming 2',
          module1Level: 'Level 2',
          module2Name: 'Database Systems',
          module2Level: 'Level 2',
          yearOfStudy: '2',
          eligibilityConfirmed: true,
          status: 'pending',
          createdAt: DateTime.now(),
        ),

        ApplicationModel(
          id: '2',
          studentName: 'Jane Smith',
          studentEmail: 'jane@gmail.com',
          module1Name: 'Web Development',
          module1Level: 'Level 3',
          module2Name: 'Mobile Development',
          module2Level: 'Level 3',
          yearOfStudy: '3',
          eligibilityConfirmed: true,
          status: 'approved',
          createdAt: DateTime.now(),
        ),

        ApplicationModel(
          id: '3',
          studentName: 'Clark Kent',
          studentEmail: 'clark@gmail.com',
          module1Name: 'Networking',
          module1Level: 'Level 1',
          module2Name: 'Security',
          module2Level: 'Level 1',
          yearOfStudy: '1',
          eligibilityConfirmed: false,
          status: 'rejected',
          createdAt: DateTime.now(),
        ),
      ]);

      _successMessage = 'Applications loaded successfully';

    } catch (e) {

      _errorMessage = 'Failed to load applications';

    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }

  

  void setSearch(String value) {

    _searchQuery = value;
    notifyListeners();
  }


  void setFilter(String value) {

    _filterStatus = value;
    notifyListeners();
  }

  

  Future<void> approveApplication(String id) async {

    try {

      final appIndex =
          _applications.indexWhere((app) => app.id == id);

      if (appIndex != -1) {

        _applications[appIndex].status = 'approved';

        _successMessage = 'Application approved successfully';

        notifyListeners();
      }

    } catch (e) {

      _errorMessage = 'Failed to approve application';

      notifyListeners();
    }
  }

 

  Future<void> rejectApplication(String id) async {

    try {

      final appIndex =
          _applications.indexWhere((app) => app.id == id);

      if (appIndex != -1) {

        _applications[appIndex].status = 'rejected';

        _successMessage = 'Application rejected successfully';

        notifyListeners();
      }

    } catch (e) {

      _errorMessage = 'Failed to reject application';

      notifyListeners();
    }
  }

  

  Future<void> deleteApplication(String id) async {

    try {

      _applications.removeWhere((app) => app.id == id);

      _successMessage = 'Application deleted successfully';

      notifyListeners();

    } catch (e) {

      _errorMessage = 'Failed to delete application';

      notifyListeners();
    }
  }

  

  void clearMessages() {

    _successMessage = null;
    _errorMessage = null;

    notifyListeners();
  }
}
