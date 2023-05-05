enum SubjectException implements Exception {
  subjectNotFound(
      title: "Matérias não encontradas",
      message: "Ocorreu um erro ao buscar as matérias.");

  const SubjectException({required this.title, required this.message});

  final String title;
  final String message;
}
