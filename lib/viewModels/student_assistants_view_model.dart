import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:group_u/models/student_assistant_model.dart';
import 'package:intl/intl.dart';

class StudentAssistantsViewModel extends ChangeNotifier {
  // final List<StudentAssistantModel> _applications = [];
  final List<StudentAssistantModel> _applications = [
    StudentAssistantModel(
      id: 1,
      studentNumber: "123456789",
      name: "John",
      surname: "Doe",
      academicLevel: "3",
      module: "CSY301",
      secondModule: "CSY201",
      meetRequirements: true,
      status: "pending",
      date: "13-May-2026 08:30",
    ),
    StudentAssistantModel(
      id: 2,
      studentNumber: "987654321",
      name: "Jane",
      surname: "Smith",
      academicLevel: "2",
      module: "CSY201",
      secondModule: "",
      meetRequirements: true,
      status: "accepted",
      date: "12-May-2026 14:15",
    ),
    StudentAssistantModel(
      id: 3,
      studentNumber: "456789123",
      name: "Bob",
      surname: "Johnson",
      academicLevel: "4",
      module: "CSY401",
      secondModule: "CSY301",
      meetRequirements: false,
      status: "rejected",
      date: "11-May-2026 10:00",
    ),
  ];

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
      if (alreadyApplied) {
        return (false, "You have already submitted an application.");
      }

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
    String? status,
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
        status: status,
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
