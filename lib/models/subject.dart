class Subject {
  final int id;
  final String name;
  final String code;
  final int teacherId;
  final int userId;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.teacherId,
    required this.userId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      teacherId: json['teacherId'],
      userId: json['userId'],
    );
  }
}
