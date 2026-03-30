class SplashController {
  Future<bool> carregarDependencias() async {
    try {
      // futuramente ira verificar se:
      // 1. Iniciar o banco de dados local (SQLite/SharedPreferences)
      // 2. Checar se existe um token de usuário logado
      // 3. Baixar configurações iniciais da API

      await Future.delayed(const Duration(seconds: 3));
      return true;
    } catch (e) {
      return false;
    }
  }

}