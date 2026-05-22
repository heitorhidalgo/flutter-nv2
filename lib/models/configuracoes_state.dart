class ConfiguracoesState {
  final String idiomaSelecionado;
  const ConfiguracoesState({this.idiomaSelecionado = 'Português (BR)'});

  ConfiguracoesState copyWith({String? idiomaSelecionado}) {
    return ConfiguracoesState(
      idiomaSelecionado: idiomaSelecionado ?? this.idiomaSelecionado,
    );
  }
}
