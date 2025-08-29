class AuthException implements Exception {
  static const Map<String, String> errors = {
    // Sign up
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida.',
    'WEAK_PASSWORD': 'A senha deve ter pelo menos 6 caracteres.',

    // Sign in
    'INVALID_LOGIN_CREDENTIALS': 'E-mail e/ou senha inválidos.',
    'INVALID_PASSWORD': 'Senha incorreta ou inválida.',
    'EMAIL_NOT_FOUND': 'E-mail não encontrado.',
    'USER_DISABLED': 'Conta desabilitada.',

    // Rate limiting / genéricos
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Muitas tentativas. Tente mais tarde.',
    'INVALID_EMAIL': 'Formato de e-mail inválido.',
    'MISSING_PASSWORD': 'Informe a senha.',
    'UNKNOWN': 'Ocorreu um erro.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    print(errors[key]);
    return errors[key] ?? 'Ocorreu um erro.';
  }
}