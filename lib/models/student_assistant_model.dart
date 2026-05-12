class StudentAssistantModel {
  final String name;
  final String surname;
  final String secondModule;
  final String status;
  final String academicLevel;
  final String module;
  final bool meetRequirements;

  StudentAssistantModel({
    required this.academicLevel,
    required this.module,
    required this.meetRequirements,
    required this.name,
    required this.surname,
    required this.secondModule,
    required this.status,
  });

  StudentAssistantModel copyWith({
    String? academicLevel,
    String? module,
    bool? meetRequirements,
    String? name,
    String? surname,
    String? secondModule,
    String? status,
  }) {
    return StudentAssistantModel(
      academicLevel: academicLevel ?? this.academicLevel,
      module: module ?? this.module,
      meetRequirements: meetRequirements ?? this.meetRequirements,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      secondModule: secondModule ?? this.secondModule,
      status: status ?? this.status,
    );
  }
}
