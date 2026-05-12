class StudentAssistantModel {
  final int id;
  final String name;
  final String surname;
  final String secondModule;
  final String status;
  final String academicLevel;
  final String module;
  final bool meetRequirements;
  final String secondModuleAcademicLevel;

  StudentAssistantModel({
    required this.id,
    required this.academicLevel,
    required this.module,
    required this.meetRequirements,
    required this.name,
    required this.surname,
    required this.secondModule,
    required this.secondModuleAcademicLevel,
    required this.status,
  });

  StudentAssistantModel copyWith({
    int? id,
    String? academicLevel,
    String? module,
    bool? meetRequirements,
    String? name,
    String? surname,
    String? secondModule,
    String? secondModuleAcademicLevel,
    String? status,
  }) {
    return StudentAssistantModel(
      id: id ?? this.id,
      academicLevel: academicLevel ?? this.academicLevel,
      module: module ?? this.module,
      meetRequirements: meetRequirements ?? this.meetRequirements,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      secondModule: secondModule ?? this.secondModule,
      secondModuleAcademicLevel:
          secondModuleAcademicLevel ?? this.secondModuleAcademicLevel,
      status: status ?? this.status,
    );
  }
}
