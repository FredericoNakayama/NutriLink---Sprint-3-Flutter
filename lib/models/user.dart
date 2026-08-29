/// Perfis de acesso do aplicativo.
///
/// A nutriz acessa Conteúdos, Buscar Bancos e Meu Agendamento.
/// O administrador tem, além dessas, acesso ao Dashboard.
enum UserRole { nutriz, admin }

/// Usuário autenticado do NutriLink.
class AppUser {
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final String initials;

  const AppUser({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.initials,
  });

  bool get isAdmin => role == UserRole.admin;

  String get roleLabel => isAdmin ? 'Administrador' : 'Nutriz';
}
