class Teacher {
  final int id;
  final String name;
  final String email;
  final String department;
  final String phone;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.phone,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      department: json['departament'],
      phone: json['phone_number'],
    );
  }
}
