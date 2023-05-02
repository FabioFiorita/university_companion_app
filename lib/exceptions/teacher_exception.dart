enum TeacherException implements Exception {
  teacherNotFound(
      title: "Professor não encontrado",
      message: "Ocorreu um erro ao buscar os professores.");

  const TeacherException({required this.title, required this.message});

  final String title;
  final String message;
}
