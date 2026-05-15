/**
 * Student Numbers : 223048044, 222049725, 223022994,223014209,224131946
 * Student Names : Shadrack Bila, Lerato Gladys Molefe,Marcus Mhlambi,Lisa Sandi,Lahluma Maselana
 * Question : Application model
 */

class ApplicationModel {
  final String? id;
  final String studentId;
  final String studentName;
  final String studentEmail;
  final String yearOfStudy;
  final String module1Level;
  final String module1Name;
  final String? module2Level;
  final String? module2Name;
  final bool eligibilityConfirmed;
  final String? documentUrl;
  final String status;
  final DateTime? createdAt;

  ApplicationModel({
    this.id,
    required this.studentId,
    required this.studentName,
    required this.studentEmail,
    required this.yearOfStudy,
    required this.module1Level,
    required this.module1Name,
    this.module2Level,
    this.module2Name,
    required this.eligibilityConfirmed,
    this.documentUrl,
    this.status = 'pending',
    this.createdAt,
  });

  // Supabase row → Model
  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      id: map['id']?.toString(),
      studentId: map['student_id'] ?? '',
      studentName: map['student_name'] ?? '',
      studentEmail: map['student_email'] ?? '',
      yearOfStudy: map['year_of_study'] ?? '',
      //yearOfStudy:          map['year_of_study'].toString(),
      module1Level: map['module1_level'] ?? '',
      module1Name: map['module1_name'] ?? '',
      module2Level: map['module2_level'],
      module2Name: map['module2_name'],
      eligibilityConfirmed: map['eligibility_confirmed'] ?? false,
      documentUrl: map['document_url'],
      status: map['status'] ?? 'pending',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
    );
  }

  // Model → Supabase row
  Map<String, dynamic> toMap() => {
        'student_id': studentId,
        'student_name': studentName,
        'student_email': studentEmail,
        'year_of_study': yearOfStudy,
        'module1_level': module1Level,
        'module1_name': module1Name,
        'module2_level': module1Level,
        'module2_name': module2Name,
        'eligibility_confirmed': eligibilityConfirmed,
        'document_url': documentUrl,
        'status': status,
      };

  // Return copy with changed fields
  ApplicationModel copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? studentEmail,
    String? yearOfStudy,
    String? module1Level,
    String? module1Name,
    String? module2Level,
    String? module2Name,
    bool? eligibilityConfirmed,
    String? documentUrl,
    String? status,
    DateTime? createdAt,
  }) =>
      ApplicationModel(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        studentName: studentName ?? this.studentName,
        studentEmail: studentEmail ?? this.studentEmail,
        yearOfStudy: yearOfStudy ?? this.yearOfStudy,
        module1Level: module1Level ?? this.module1Level,
        module1Name: module1Name ?? this.module1Name,
        module2Level: module2Level ?? this.module2Level,
        module2Name: module2Name ?? this.module2Name,
        eligibilityConfirmed: eligibilityConfirmed ?? this.eligibilityConfirmed,
        documentUrl: documentUrl ?? this.documentUrl,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
}
