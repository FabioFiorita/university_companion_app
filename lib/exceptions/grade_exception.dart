enum GradeException implements Exception {
  gradeNotFound(
      title: "Nota não encontrada",
      message: "Ocorreu um erro ao buscar as notas.");

  const GradeException({required this.title, required this.message});

  final String title;
  final String message;
}
