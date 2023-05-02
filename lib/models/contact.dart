class Contact {
  final int id;
  final String area;
  final String number;
  final int userId;

  Contact({
    required this.id,
    required this.area,
    required this.number,
    required this.userId,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      area: json['area'],
      number: json['number'],
      userId: json['userId'],
    );
  }
}