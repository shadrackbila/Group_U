import 'package:supabase_flutter/supabase_flutter.dart';

class StudentAssistantService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> createApplication({
    required String name,
    required String surname,
    required String academicLevel,
    required String module,
    required String secondModule,
    required String secondModuleLevel,
    required bool meetRequirements,
  }) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await supabase.from('student_assistants').insert({
      'user_id': user.id,
      'name': name,
      'surname': surname,
      'academic_level': academicLevel,
      'module': module,
      'second_module': secondModule,
      'second_module_level': secondModuleLevel,
      'meet_requirements': meetRequirements,
      'status': 'Pending',
    });
  }
}
