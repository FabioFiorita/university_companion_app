enum ExamException implements Exception {
  //TODO: Refactor to examNotFound
  gradeNotFound(
      title: "Notas não encontradas",
      message: "Ocorreu um erro ao buscar as notas.");

  const ExamException({required this.title, required this.message});

  final String title;
  final String message;
}
