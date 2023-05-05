enum ContactException implements Exception {
  contactNotFound(
      title: "Contatos não encontrados",
      message: "Ocorreu um erro ao buscar os contatos.");

  const ContactException({required this.title, required this.message});

  final String title;
  final String message;
}
