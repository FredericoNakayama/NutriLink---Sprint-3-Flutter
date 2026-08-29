import '../models/user.dart';

/// Usuários mockados para autenticação de demonstração.
///
/// Credenciais de teste:
///  - Nutriz: nutriz@nutrilink.com  / senha: 123456
///  - Admin:  adm@nutrilink.com     / senha: 123456
class MockUsers {
  MockUsers._();

  static const AppUser nutriz = AppUser(
    name: 'Ana Maria Ribeiro',
    email: 'nutriz@nutrilink.com',
    password: '123456',
    role: UserRole.nutriz,
    initials: 'AM',
  );

  static const AppUser admin = AppUser(
    name: 'Beatriz Fonseca',
    email: 'adm@nutrilink.com',
    password: '123456',
    role: UserRole.admin,
    initials: 'BF',
  );

  static const List<AppUser> all = [nutriz, admin];

  /// Retorna o usuário cujas credenciais batem, ou `null` se inválidas.
  static AppUser? authenticate(String email, String password) {
    for (final user in all) {
      if (user.email.toLowerCase() == email.trim().toLowerCase() &&
          user.password == password) {
        return user;
      }
    }
    return null;
  }
}
