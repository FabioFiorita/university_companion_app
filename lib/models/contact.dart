class Contact {
  final int id;
  final String area;
  final String number;

  Contact({
    required this.id,
    required this.area,
    required this.number,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      area: json['area'],
      number: json['number'],
    );
  }
}
