enum ContactException implements Exception {
  contactNotFound(
      title: "Contato não encontrado",
      message: "Ocorreu um erro ao buscar os contatos.");

  const ContactException({required this.title, required this.message});

  final String title;
  final String message;
}
