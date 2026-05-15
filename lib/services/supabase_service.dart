import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/application_model.dart';

/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question : Superbase service
 */

class SupabaseService {
  // Singleton - whole app shares one instance
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<String> getUserRole(String userId) async {
    final response = await _client
        .from('profiles')
        .select('role')
        .eq('id', userId)
        .maybeSingle();
    if (response == null) {
      await _client.from('profiles').insert({
        'id': userId,
        'role': 'student',
      });
      return 'student';
    }
    return response['role'] ?? 'student';
  }

  Future<List<ApplicationModel>> getStudentApplications(
      String studentId) async {
    final response = await _client
        .from('applications')
        .select()
        .eq('student_id', studentId)
        .order('created_at', ascending: false);
    return (response as List)
        .map((row) => ApplicationModel.fromMap(row))
        .toList();
  }

  Future<ApplicationModel> createApplication(ApplicationModel app) async {
    final response = await _client
        .from('applications')
        .insert(app.toMap())
        .select()
        .single();
    return ApplicationModel.fromMap(response);
  }

  Future<void> updateApplication(ApplicationModel app) async {
    await _client.from('applications').update(app.toMap()).eq('id', app.id!);
  }

  Future<void> deleteApplication(String appId) async {
    await _client.from('applications').delete().eq('id', appId);
  }

  Future<List<ApplicationModel>> getAllApplications() async {
    final response = await _client
        .from('applications')
        .select()
        .order('created_at', ascending: false);
    return (response as List)
        .map((row) => ApplicationModel.fromMap(row))
        .toList();
  }

  Future<void> updateApplicationStatus(String appId, String status) async {
    await _client
        .from('applications')
        .update({'status': status}).eq('id', appId);
  }

  Future<String?> uploadDocument(PlatformFile file, String studentId) async {
    final bytes = file.bytes;
    if (bytes == null) throw Exception('File bytes unavailable.');

    final ext = file.extension ?? 'bin';
    final fileName =
        '$studentId/${DateTime.now().millisecondsSinceEpoch}_${file.name}';

    await _client.storage.from('documents').uploadBinary(
          fileName,
          bytes,
          fileOptions: FileOptions(contentType: _mimeType(ext)),
        );

    return _client.storage.from('documents').getPublicUrl(fileName);
  }

  String _mimeType(String ext) {
    switch (ext.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      default:
        return 'application/octet-stream';
    }
  }
}
