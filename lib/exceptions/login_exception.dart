enum LoginException implements Exception {
  invalidEmail(
      title: "E-mail inválido", message: "Verifique o endereço de e-mail."),
  weakPassword(
      title: "Senha fraca",
      message: "A senha deve ter no mínimo 8 caracteres."),
  wrongPassword(
      title: "Senha incorreta", message: "Verifique a senha digitada."),
  userNotFound(
      title: "Usuário não encontrado", message: "Verifique o e-mail digitado."),
  tooManyRequests(
      title: "Muitas requisições", message: "Tente novamente mais tarde."),
  undefined(title: "Erro desconhecido", message: "Tente novamente mais tarde.");

  const LoginException({required this.title, required this.message});

  final String title;
  final String message;
}
