enum TeacherException implements Exception {
  teacherNotFound(
      title: "Professores não encontrados",
      message: "Ocorreu um erro ao buscar os professores.");

  const TeacherException({required this.title, required this.message});

  final String title;
  final String message;
}
