class LoginState {
  final bool isLoading;
  final bool manterConectado;
  final bool senhaVisivel;
  final String? erroEmail;
  final String? erroSenha;

  const LoginState({
    this.isLoading = false,
    this.manterConectado = false,
    this.senhaVisivel = false,
    this.erroEmail,
    this.erroSenha,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? manterConectado,
    bool? senhaVisivel,
    String? erroEmail,
    String? erroSenha,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      manterConectado: manterConectado ?? this.manterConectado,
      senhaVisivel: senhaVisivel ?? this.senhaVisivel,
      erroEmail: erroEmail,
      erroSenha: erroSenha,
    );
  }
}
