class Grade {
  final int id;
  final String code;
  final int grade;
  final int subjectId;
  final int userId;

  Grade({
    required this.id,
    required this.code,
    required this.grade,
    required this.subjectId,
    required this.userId,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      code: json['code'],
      grade: json['grade'],
      subjectId: json['subjectId'],
      userId: json['userId'],
    );
  }
}
