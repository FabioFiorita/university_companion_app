class Validators {
  static String? validateEmail(String? value) {
    if (value == null) {
      return 'É necessário um e-mail';
    }
    if (value.isEmpty) {
      return 'É necessário um e-mail';
    }
    if (!value.contains('@')) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null) {
      return 'Senha é necessária';
    }
    if (value.isEmpty) {
      return 'Senha é necessária';
    }
    if (value.length < 8) {
      return 'Senha deve ter no mínimo 8 caracteres';
    }
    return null;
  }
}