class PerfilModel {
  final String nome;
  final String email;
  final String? avatarPath;

  const PerfilModel({
    required this.nome,
    required this.email,
    this.avatarPath,
  });

  PerfilModel copyWith({
    String? nome,
    String? email,
    String? avatarPath,
  }) {
    return PerfilModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}