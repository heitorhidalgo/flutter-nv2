const _removido = Object();

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
    Object? avatarPath = _removido,
  }) {
    return PerfilModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      avatarPath: identical(avatarPath, _removido)
          ? this.avatarPath
          : avatarPath as String?,
    );
  }
}