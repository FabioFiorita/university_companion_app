enum ClassException implements Exception {
  classNotFound(
      title: "Aulas não encontradas",
      message: "Ocorreu um erro ao buscar as turmas.");

  const ClassException({required this.title, required this.message});

  final String title;
  final String message;
}
