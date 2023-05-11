enum GeneralException implements Exception {
  tooManyRequests(
      title: "Muitas requisições", message: "Tente novamente mais tarde."),
  undefined(title: "Erro desconhecido", message: "Tente novamente mais tarde.");

  const GeneralException({required this.title, required this.message});

  final String title;
  final String message;
}
