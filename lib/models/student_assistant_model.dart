class StudentAssistantModel {
  final int id;
  final String studentNumber;
  final String name;
  final String surname;
  final String secondModule;
  final String status;
  final String academicLevel;
  final String module;
  final bool meetRequirements;
  final String date;

  StudentAssistantModel({
    required this.id,
    required this.studentNumber,
    required this.academicLevel,
    required this.module,
    required this.meetRequirements,
    required this.name,
    required this.surname,
    required this.secondModule,
    required this.status,
    required this.date,
  });

  StudentAssistantModel copyWith({
    int? id,
    String? studentNumber,
    String? academicLevel,
    String? module,
    bool? meetRequirements,
    String? name,
    String? surname,
    String? secondModule,
    String? status,
    String? date,
  }) {
    return StudentAssistantModel(
      id: id ?? this.id,
      studentNumber: studentNumber ?? this.studentNumber,
      academicLevel: academicLevel ?? this.academicLevel,
      module: module ?? this.module,
      meetRequirements: meetRequirements ?? this.meetRequirements,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      secondModule: secondModule ?? this.secondModule,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }
}
