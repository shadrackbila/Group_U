import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../models/application_model.dart';
import '../services/supabase_service.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question :   application view model
 */

class ApplicationViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  List<ApplicationModel> _applications = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  List<ApplicationModel> get applications => _applications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // READ
  Future<void> loadApplications() async {
    final user = _service.currentUser;
    if (user == null) return;
    _setLoading(true);
    try {
      _applications = await _service.getStudentApplications(user.id);
    } catch (e) {
      _errorMessage = 'Failed to load: $e';
    }
    _setLoading(false);
  }

  // CREATE
  Future<bool> submitApplication({
    required String studentName,
    required String yearOfStudy,
    required String module1Level,
    required String module1Name,
    String? module2Level,
    String? module2Name,
    required bool eligibilityConfirmed,
    PlatformFile? documentFile,
  }) async {
    final user = _service.currentUser;
    if (user == null) return false;
    if (_applications.isNotEmpty) {
      _errorMessage = 'You have already submitted an application.';
      notifyListeners();
      return false;
    }
    _setLoading(true);
    try {
      String? docUrl;
      if (documentFile != null) {
        docUrl = await _service.uploadDocument(documentFile, user.id);
      }
      final created = await _service.createApplication(ApplicationModel(
        studentId: user.id,
        studentName: studentName,
        studentEmail: user.email ?? '',
        yearOfStudy: yearOfStudy,
        module1Level: module1Level,
        module1Name: module1Name,
        module2Level: module2Level,
        module2Name: module2Name,
        eligibilityConfirmed: eligibilityConfirmed,
        documentUrl: docUrl,
      ));
      _applications.insert(0, created);
      _successMessage = 'Application submitted successfully!';
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Submit failed: $e';
      _setLoading(false);
      return false;
    }
  }

  // UPDATE — accepts an optional newDocument to re-upload if the user replaced the file
  Future<bool> updateApplication(
    ApplicationModel updated, {
    PlatformFile? newDocument,
  }) async {
    _setLoading(true);
    try {
      String? docUrl = updated.documentUrl; // keep existing URL by default
      if (newDocument != null) {
        docUrl = await _service.uploadDocument(newDocument, updated.studentId);
      }
      final withDoc = updated.copyWith(documentUrl: docUrl);
      await _service.updateApplication(withDoc);
      final idx = _applications.indexWhere((a) => a.id == updated.id);
      if (idx != -1) _applications[idx] = withDoc;
      _successMessage = 'Application updated!';
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Update failed: $e';
      _setLoading(false);
      return false;
    }
  }

  // DELETE
  Future<bool> deleteApplication(String appId) async {
    _setLoading(true);
    try {
      await _service.deleteApplication(appId);
      _applications.removeWhere((a) => a.id == appId);
      _successMessage = 'Application deleted.';
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Delete failed: $e';
      _setLoading(false);
      return false;
    }
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
