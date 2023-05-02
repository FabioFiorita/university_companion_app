class Class {
  final int id;
  final String day;
  final String time;
  final int subjectId;
  final int teacherId;
  final int userId;

  Class({
    required this.id,
    required this.day,
    required this.time,
    required this.subjectId,
    required this.teacherId,
    required this.userId,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      day: json['day'],
      time: json['time'],
      subjectId: json['subjectId'],
      teacherId: json['teacherId'],
      userId: json['userId'],
    );
  }
}