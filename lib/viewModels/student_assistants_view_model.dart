import 'package:flutter/cupertino.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:intl/intl.dart';

class StudentAssistantsViewModel extends ChangeNotifier {
  final List<StudentAssistantModel> _applications = [];

  final StudentAssistantModel _studentAssistantModel = StudentAssistantModel(
    id: 0,
    studentNumber: "",
    academicLevel: "",
    module: "",
    meetRequirements: false,
    name: "",
    surname: "",
    secondModule: "",
    status: "",
    date: "",
  );

  List<StudentAssistantModel> get applications => _applications;
  String get name => _studentAssistantModel.name;
  String get surname => _studentAssistantModel.surname;
  String get secondModule => _studentAssistantModel.secondModule;
  String get secondModuleAcademicLevel => _studentAssistantModel.status;
  String get academicLevel => _studentAssistantModel.academicLevel;
  String get module => _studentAssistantModel.module;
  bool get meetRequirements => _studentAssistantModel.meetRequirements;
  String get studentNumber => _studentAssistantModel.studentNumber;
  int get id => _studentAssistantModel.id;

  (bool, String) createApplication({
    required String studentNumber,
    required String name,
    required String surname,
    required String module,
    required String academicLevel,
    required String secondModule,
    required bool meetRequirements,
  }) {
    try {
      bool alreadyApplied = _applications.any(
        (a) => a.studentNumber == studentNumber,
      );
      if (alreadyApplied)
        return (false, "You have already submitted an application.");

      DateTime now = DateTime.now();
      final newApplication = _studentAssistantModel.copyWith(
        id: applications.length + 1,
        name: name,
        surname: surname,
        module: module,
        academicLevel: academicLevel,
        secondModule: secondModule,
        status: "pending",
        date: DateFormat('dd-MMM-yyyy HH:mm').format(now),
        meetRequirements: meetRequirements,
        studentNumber: studentNumber,
      );

      _applications.add(newApplication);
      notifyListeners();
      return (true, "Application created successfuly");
    } catch (e) {
      print(e);
      return (false, e.toString());
    }
  }

  (bool, String) updateApplication({
    String? name,
    String? surname,
    String? module,
    String? academicLevel,
    String? secondModule,
    int? index,
    bool? meetRequirements,
    String? studentNumber,
  }) {
    try {
      DateTime now = DateTime.now();

      final existing = _applications[index!];

      final updated = existing.copyWith(
        name: name,
        surname: surname,
        module: module,
        academicLevel: academicLevel,
        secondModule: secondModule,
        status: "pending",
        date: DateFormat('dd-MMM-yyyy HH:mm').format(now),
        meetRequirements: meetRequirements,
        studentNumber: studentNumber,
      );

      _applications[index] = updated;

      notifyListeners();
      return (true, "Application updated successfully");
    } catch (e) {
      print(e);
      return (false, e.toString());
    }
  }

  (bool, String) deleteApplication(int index) {
    try {
      _applications.removeAt(index);
      notifyListeners();
      return (true, "Deleted successully");
    } catch (e) {
      print(e);
      return (false, e.toString());
    }
  }
}
