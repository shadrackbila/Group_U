import 'package:flutter/cupertino.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:group_u/services/student_assistant_service.dart';

class StudentAssistantsViewModel extends ChangeNotifier {
  final StudentAssistantService _service = StudentAssistantService();
  final StudentAssistantModel _studentAssistantModel = StudentAssistantModel(
    academicLevel: "",
    module: "",
    meetRequirements: false,
    name: "",
    surname: "",
    secondModule: "",
    secondModuleAcademicLevel: "",
  );

  String get name => _studentAssistantModel.name;
  String get surname => _studentAssistantModel.surname;
  String get secondModule => _studentAssistantModel.secondModule;
  String get secondModuleAcademicLevel =>
      _studentAssistantModel.secondModuleAcademicLevel;
  String get academicLevel => _studentAssistantModel.academicLevel;
  String get module => _studentAssistantModel.module;
  bool get meetRequirements => _studentAssistantModel.meetRequirements;

Future<void> createApplication({
  required String name,
  required String surname,
  required String academicLevel,
  required String module,
  required String secondModule,
  required String secondModuleLevel,
  required bool meetRequirements,
}) async {
  await _service.createApplication(
    name: name,
    surname: surname,
    academicLevel: academicLevel,
    module: module,
    secondModule: secondModule,
    secondModuleLevel: secondModuleLevel,
    meetRequirements: meetRequirements,
  );

  notifyListeners();
}

  void updateApplication() {
    notifyListeners();
  }
}
