enum GradeException implements Exception {
  gradeNotFound(
      title: "Notas não encontradas",
      message: "Ocorreu um erro ao buscar as notas.");

  const GradeException({required this.title, required this.message});

  final String title;
  final String message;
}
