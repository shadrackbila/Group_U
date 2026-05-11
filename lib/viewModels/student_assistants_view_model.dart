import 'package:flutter/cupertino.dart';
import 'package:group_u/models/student_assistant_model.dart';

class StudentAssistantsViewModel extends ChangeNotifier {
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

  bool createApplication({
    required String name,
    required String surname,
    required String module,
    required String academicLevel,
    required String secondModule,
  }) {
    notifyListeners();
    return true;
  }

  void updateApplication() {
    notifyListeners();
  }
}
