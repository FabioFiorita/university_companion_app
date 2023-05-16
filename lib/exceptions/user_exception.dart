enum UserException implements Exception {
  unauthorized(title: "Não autorizado", message: "Faça login para continuar."),
  invalidEmail(
      title: "E-mail inválido", message: "Verifique o endereço de e-mail."),
  weakPassword(
      title: "Senha fraca",
      message: "A senha deve ter no mínimo 8 caracteres."),
  wrongPassword(
      title: "Senha incorreta", message: "Verifique a senha digitada."),
  userNotFound(
      title: "Usuário não encontrado", message: "Verifique o e-mail digitado."),
  sessionExpired(
      title: "Sessão expirada",
      message: "Faça login novamente para continuar.");

  const UserException({required this.title, required this.message});

  final String title;
  final String message;
}
